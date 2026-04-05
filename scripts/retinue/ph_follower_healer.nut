this.ph_follower_healer <- this.inherit("scripts/retinue/ph_follower", {
    m = 
	{
	},
    function create()
	{
        this.ph_follower.create();
        this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
    }

    function wasHired()
    {
        //clear all class-related flags
    }

    function isMaxLevel()
    {
        return this.hasExactSkill(::PandorasHobby.Follower.SkillMasks.Healer_MAX);
    }

    function getXPHintText()
    {
        //HD mod adds the tracking for using bandages in battle!

        if ( ::Hooks.hasMod("mod_hardened") ){
            return "Earn 1 XP: Craft a potion or reagent, Bandage an injury in battle, Treat an injury at a temple (2x if permanent). Daily Bonus XP based on # of current injuries & wounds.";        
        }        
        
        return "Earn 1 XP: Craft a potion or reagent, Treat an injury at a temple (2x if permanent). Daily Bonus XP based on # of current injuries & wounds.";
    }

    function earnDailyXP()
    {
        this.ph_follower.earnDailyXP();

        //::logInfo("Healer Daily XP");

        //daily bonus xp from total injuries on roster
        this.m.XP += this.getXP_BonusCurrentInjuries();        

        //collect XP from trackers
        this.m.XP += this.getXP_Injuries(1, 1, 1); //Perm Injs set both flags so actually 2xp
        this.m.XP += this.getXP_Crafting(1, 1, 1);

        //check for level up and aging
        if(this.checkForLevelAge()) this.updateEffects();
    }

    function getXP_BonusCurrentInjuries()
    {
        //::logInfo("Healer Daily XP -- Bonus");
        local brothers = ::World.getPlayerRoster().getAll();
        local odds = 0;
        
		foreach( b in brothers )
		{            
            odds += b.getSkills().query(::Const.SkillType.TemporaryInjury | ::Const.SkillType.PermanentInjury).len();

            //check if they are significantly wounded
            if(b.getHitpointsMax() >= (b.getHitpoints() + 20))
            {
                odds += 1;
            }
        }

        local xp = 0;
        local maxRoll = this.m.Level * 5;   //up to 75 max roll
        //Healer max level is ~15, but unlikely to be achieved or wanted, max injuries are only limited by party size

        this.m.DailyOdds = odds;
        this.m.DailyMax = maxRoll;

        while( xp < ::PandorasHobby.Follower.MaxDailyXP && ::Math.rand(0, maxRoll) < odds )
        {
            xp += 1;
        }

        //::logInfo("Healer Daily XP -- Bonus = " + xp);
        return xp;
    }

    function getXP_Injuries(_ban, _temp, _perm)
    {
        //::logInfo("Healer Daily XP -- Injuries");
        local xp = 0;

        local key = "Num_Bandages";
        local num = this.getFlag(key);
        local stat = ::World.Statistics.getFlags().getAsInt("InjuriesTreatedWithBandage");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * _ban;

        key = "Num_Treated";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * _temp;

        key = "Num_PermTreated";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PermInjuriesTreatedAtTemple");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * _perm;

        //::logInfo("Healer Daily XP -- Injuries = " + xp);
        return xp;
    }

    function getXP_Crafting(_pots, _anat, _cult)
    {
        //::logInfo("Healer Daily XP -- Crafting");
        local xp = 0;

        local key = "Potions_Crafted";
        local num = this.getFlag(key);
        local stat = ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Alchemy") + ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_SnakeOil") + ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Medicine");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * _pots;

        key = "Anatomist_Crafted";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_AnatomistCrafted");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * _anat;

        key = "Cultist_Crafted";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_CultistCrafted");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * _cult;

        //::logInfo("Healer Daily XP -- Crafting = " + xp);
        return xp;
    }

    function updateValueTrackers()
	{
        this.setFlag("Num_Bandage", ::World.Statistics.getFlags().getAsInt("InjuriesTreatedWithBandage"));
        this.setFlag("Num_Treated", ::World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple"));
        this.setFlag("Num_PermTreated", ::World.Statistics.getFlags().getAsInt("PermInjuriesTreatedAtTemple"));
        
        local num = ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Alchemy") + ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_SnakeOil") + ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Medicine");
        this.setFlag("Potions_Crafted", num);
        this.setFlag("Anatomist_Crafted", ::World.Statistics.getFlags().getAsInt("PH_AnatomistCrafted"));
        this.setFlag("Cultist_Crafted", ::World.Statistics.getFlags().getAsInt("PH_CultistCrafted"));
	}

    function wasNewDay()
	{           
        this.attemptToTendWounds();
	}

    function attemptToTendWounds()
    {
        if( !this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Treat_Tend) ) return;

        if(::World.Assets.getMedicine() == 0 || ::Math.rand(0,100) < 50){ return; } //50% to fail

        local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			local injuries = [];
			local allInjuries = b.getSkills().query(this.Const.SkillType.TemporaryInjury);

			for( local i = 0; i != allInjuries.len(); i = ++i )
			{
				local inj = allInjuries[i];

				if (!inj.isTreated() && inj.isTreatable() && inj.getHealingTime().Max > 2)
				{
					injuries.push(inj);
				}
			}

			if (injuries.len() == 0)
			{
				continue;
			}

			local e = {
				Bro = b,
				Injuries = injuries
			};
			roster.push(e);
        }

        if(roster.len() == 0) { return; }

        local ind = ::Math.rand(0,roster.len()-1);
        if(::World.Assets.getMedicine() < 2 || ::Math.rand(0,100) < 25)
        {
            //treat an injury!
			roster[ind].Injuries[::Math.rand(0,roster[ind].Injuries.len()-1)].setTreated(true);
			roster[ind].updateInjuryVisuals();
            ::World.Assets.addMedicine(-2);
        }
        else
        {
            //tend a wound
            roster[ind].Injuries[::Math.rand(0,roster[ind].Injuries.len()-1)].addHealingTime(-1);
            ::World.Assets.addMedicine(-1);
        }
    }

    function onUpdate()
    {        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Survive))
        {
            ::World.Assets.m.IsSurvivalGuaranteed = true;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Heal_Rate))
        {
            ::World.Assets.m.AdditionalHitpointsPerHour += 1;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Extra_Medicine))
        {
            if(this.m.Age == ::PandorasHobby.Follower.Age.Young)
            {
                ::World.Assets.m.MedicineMaxAdditional += 10;
            }
            else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
            {
                ::World.Assets.m.MedicineMaxAdditional += 20;
            }
            else
            {
                ::World.Assets.m.MedicineMaxAdditional += 50;
            }
        }

        //Not many updates, these followers use alot of skill checks instead
    }

    function updateEffects()
	{
        //follower has already included thier unique skill
        //append a summary of all the common ones
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Snake_Oil_2x))
        {
            this.m.TooltipEffects.push("Unlocks all \'Snake Oil\' recipes & 10% chance to produce an extra Snake Oil");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All))
        {
            this.m.TooltipEffects.push("Unlocks all \'Snake Oil\' recipes");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Potions_2))
        {
            this.m.TooltipEffects.push("Unlocks all alchemy recipes");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Potions_1))
        {
            this.m.TooltipEffects.push("Unlocks common alchemy recipes");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Medicine))
        {
            this.m.TooltipEffects.push("Unlocks medicinal recipes");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Holywater))
        {
            this.m.TooltipEffects.push("Unlocks holy water recipe");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Survive))
        {
            this.m.TooltipEffects.push("Every man without a permanent injury guaranteed to survive an otherwise fatal blow");
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Temple_PInj))
        {
            this.m.TooltipEffects.push("Allows Permanent Injuries to be treated at the Temple");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Heal_Rate))
        {
            this.m.TooltipEffects.push("Increases hitpoint recovery by 1 per hour");
        }

        if(!::Hooks.hasMod("mod_hardened") && this.hasExactSkill(::PandorasHobby.Follower.Skill.Medic_Survive | ::PandorasHobby.Follower.Skill.Medic_Heal_Rate))
        {
            this.m.TooltipEffects.push("Makes every injury take one less day to heal");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Medic_Treat_Tend))
        {
            this.m.TooltipEffects.push("Sometimes tends or treats wounds (requires supplies)");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Cultist))
        {
            this.m.TooltipEffects.push("Unlocks all cultist-related recipes");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Anatomist_3))
        {
            this.m.TooltipEffects.push("Unlocks all anatomist potion recipes & Allows sickness to be treated at the Temple");
        }        
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Anatomist_2))
        {
            this.m.TooltipEffects.push("Unlocks most anatomist potion recipes & Allows sickness to be treated at the Temple");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
        {
            this.m.TooltipEffects.push("Unlocks most anatomist potion recipes");
        }        
	}
});