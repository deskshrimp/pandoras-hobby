this.ph_follower_officer <- this.inherit("scripts/retinue/ph_follower", {
    m = 
	{
	},
    function create()
	{
        this.ph_follower.create();
        this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
    }

    function wasHired()
    {
        //clear all class-related flags
    }

    function isMaxLevel()
    {
        return this.hasExactSkill(::PandorasHobby.Follower.SkillMasks.Officer_MAX);
    }

    function getXPHintText()
    {        
        return "Earn 1 XP: Slay a champion, Train in town, Hire a recruit, Win a Battle, or Buy 5 tryouts. Daily Bonus XP based on # of men";
    }

    function earnDailyXP()
    {
        this.ph_follower.earnDailyXP();

        //daily bonus
        this.m.XP += this.getXP_RosterSizeBonus();
        
        //collect XP from trackers
        this.m.XP += this.getXP_Misc();
                
        //check for level up and aging
        if(this.checkForLevelAge()) this.updateEffects();
    }

    function getXP_RosterSizeBonus()
    {
        local xp = 0;     
        local maxRoll = ::World.Assets.m.BrothersMax + this.m.Level;
        local odds = ::World.getPlayerRoster().getSize();
        //Officer max level is ~12  [so X+12 vs X max odds, where X is 12 to 25 depending on the scenario]

        this.m.DailyOdds = odds;
        this.m.DailyMax = maxRoll;

        while( xp < ::PandorasHobby.Follower.MaxDailyXP && ::Math.rand(0, maxRoll) < odds )
        {
            xp += 1;
        }
        return xp;
    }

    function getXP_Misc()
    {
        local xp = 0;
        local key = "";
        local num = 0;
        local stat = 0;

        key = "Num_Champs";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_ChampionsKilled");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;

        key = "Num_Battles";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_BattlesWon");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;

        key = "Num_Hired";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("BrosHired");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;

        key = "Num_Trained";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_MenTrained");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;

        key = "Num_Tried";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_TryoutsBought");
        while(stat >= num + 5)
        {
            num += 5;
            xp += 1;
            this.setFlag(key, num);
        }

        return xp;
    }

    function updateValueTrackers()
	{
        this.setFlag("Num_Champs", ::World.Statistics.getFlags().getAsInt("PH_ChampionsKilled"));
        this.setFlag("Num_Battles", ::World.Statistics.getFlags().getAsInt("PH_BattlesWon"));
        this.setFlag("Num_Hired", ::World.Statistics.getFlags().getAsInt("BrosHired"));
        this.setFlag("Num_Tried", ::World.Statistics.getFlags().getAsInt("PH_TryoutsBought"));
        this.setFlag("Num_Trained", ::World.Statistics.getFlags().getAsInt("PH_MenTrained"));        
	}

    function onChampionKilled( _champion )
	{
		if (::Tactical.State.getStrategicProperties() == null || !::Tactical.State.getStrategicProperties().IsArenaMode)
		{
            local max = (this.m.Age == ::PandorasHobby.Follower.Age.Old) ? 300 : 200;
            ::World.Assets.addMoney(::Math.rand(25, max));
		}
	}

    function wasNewDay()
	{
        //attempt special training
        this.attemptSpecialTraining();
	}

    function attemptSpecialTraining()
    {
        if( !this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_1) ) return;

        local brothers = ::World.getPlayerRoster().getAll();
        local canTrain = [];
        foreach( b in brothers )
        {
            if( b == null) continue;
            if( b.getSkills().hasSkill("effects.ph_personal_training") ) continue;
            if( b.getSkills().hasSkillOfType(::Const.SkillType.Injury) ) continue;

            canTrain.push(b);
        }

        if(canTrain.len() == 0) return;

        //::logInfo("-->Attempt to train " + canTrain.len());

        //train at least 1 bro each day
        local odds = 80;
        do
        {
            //train
            local ind = ::Math.rand(0,canTrain.len()-1);
            this.trainABro( canTrain[ind] );
            canTrain.remove(ind);
            
            //reduce the odds of training a second bro
            odds -= 15;
        } while (canTrain.len() > 0 && ::Math.rand(0, 100) < odds);
    }

    function trainABro(_bro)
    {        
        local effect = ::new("scripts/skills/effects/ph_personal_training_effect");
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_3))
        {
            effect.applyTrainingEffect(3);
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_2))
        {
            effect.applyTrainingEffect(2);
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_1))
        {
            effect.applyTrainingEffect(1);
        }
        _bro.getSkills().add(effect);
    }


    function onUpdate()
    {   
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_5))
        {
            ::World.Assets.m.ChampionChanceAdditional += 8;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_4))
        {
            ::World.Assets.m.ChampionChanceAdditional += 7;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_3))
        {
            ::World.Assets.m.ChampionChanceAdditional += 6;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_2))
        {
            ::World.Assets.m.ChampionChanceAdditional += 5;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_1))
        {
            ::World.Assets.m.ChampionChanceAdditional += 3;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostXP))
        {
            ::World.Assets.m.IsDisciplined = true; //this flag is from vanilla, but doesn't appear to do anything....
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Recruiter_Boost))
        {
            ::World.Assets.m.RosterSizeAdditionalMin += 1;
		    ::World.Assets.m.RosterSizeAdditionalMax += 6;
		    ::World.Assets.m.TryoutPriceMult *= 0.5;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Recruiter_Tryout))
        {
            ::World.Assets.m.RosterSizeAdditionalMin += 1;
		    ::World.Assets.m.RosterSizeAdditionalMax += 3;
		    ::World.Assets.m.TryoutPriceMult *= 0.5;
        }
                
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Paymaster_Disc_2))
        {
            ::World.Assets.m.DailyWageMult *= 0.75;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Paymaster_Disc_1))
        {            
            ::World.Assets.m.DailyWageMult *= 0.85;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Brat_HireDisc))
        {
            if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
            {
                ::World.Assets.m.HiringCostMult *= 0.85;
            }
            else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
            {
                ::World.Assets.m.HiringCostMult *= 0.90;
            }
            else
            {
                ::World.Assets.m.HiringCostMult *= 0.95;
            }
        }
    }

    function updateEffects()
	{
        //follower has already included thier unique skill
        //append a summary of all the common ones

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_5))
        {
            this.m.TooltipEffects.push("8% increased chance to encounter champions");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_4))
        {
            this.m.TooltipEffects.push("7% increased chance to encounter champions");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_3))
        {
            this.m.TooltipEffects.push("6% increased chance to encounter champions");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_2))
        {
            this.m.TooltipEffects.push("5% increased chance to encounter champions");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_1))
        {
            this.m.TooltipEffects.push("3% increased chance to encounter champions");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostXP))
        {
            if ( ::Hooks.hasMod("mod_hardened") )
            {
                this.m.TooltipEffects.push("Makes your men gain 20% more experience at level 1, with 2% less at each further level");
			    this.m.TooltipEffects.push("Makes men in reserve never lose mood from not taking part in battles");
            }
            else        //Reforged doubled the bonuses!
            {
                this.m.TooltipEffects.push("Makes your men gain 40% more experience at level 1, with 4% less at each further level");
			    this.m.TooltipEffects.push("Makes men in reserve never lose mood from not taking part in battles");
            }
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_2))
        {
            this.m.TooltipEffects.push("Will train at least 1 uninjured man a day, buffing to 3 of their attributes");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_2))
        {
            this.m.TooltipEffects.push("Will train at least 1 uninjured man a day, buffing to 2 of their attributes");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Drill_BoostAttrib_1))
        {
            this.m.TooltipEffects.push("Will train at least 1 uninjured man a day, buffing to 1 of their attributes");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Recruiter_Boost))
        {            
            this.m.TooltipEffects.push("Makes you pay 50% less for tryouts");
            this.m.TooltipEffects.push("Makes up to 6 additional men available to recruit in every settlement");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Recruiter_Tryout))
        {
            this.m.TooltipEffects.push("Makes you pay 50% less for tryouts");
            this.m.TooltipEffects.push("Makes up to 3 additional men available to recruit in every settlement");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Paymaster_Disc_2))
        {
            this.m.TooltipEffects.push("Reduces the daily wage of each man by 25%");

            if(this.hasSkill(::PandorasHobby.Follower.Skill.Wardog_Desert))
            {
                //already handles desertion in his unique power, do not repeat it
                this.m.TooltipEffects.push("Prevents men demanding more pay in events");
            }
            else
            {
                this.m.TooltipEffects.push("Prevents men demanding more pay in events & Reduces desertion by 50%");
            }            
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Paymaster_Disc_1))
        {
            this.m.TooltipEffects.push("Reduces the daily wage of each man by 15%");
        }
	}
});