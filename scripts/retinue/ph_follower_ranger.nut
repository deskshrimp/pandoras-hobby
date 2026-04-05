this.ph_follower_ranger <- this.inherit("scripts/retinue/ph_follower", {
    m = 
	{
	},
    function create()
	{
        this.ph_follower.create();
        this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
    }

    function wasHired()
    {
        //clear all class-related flags
    }

    function isMaxLevel()
    {
        return this.hasExactSkill(::PandorasHobby.Follower.SkillMasks.Ranger_MAX);
    }

    function getXPHintText()
    {        
        return "Earn 1 XP: Battle Beasts, Complete a non-caravan Contract, Raid a Caravan, or Discover a Location. Daily Bonus XP based on # of legendary locations found.";
    }

    function earnDailyXP()
    {
        this.ph_follower.earnDailyXP();

        //Legendary Locations provide daily bonus xp chances
        this.m.XP += this.getXP_LegendaryLocationsBonus();

        //collect XP from trackers
        this.m.XP += this.getXP_Beast(1);
        this.m.XP += this.getXP_Contracts(1);
        this.m.XP += this.getXP_Raids(1);
        this.m.XP += this.getXP_Locations(1);
        
        //check for level up and aging
        if(this.checkForLevelAge()) this.updateEffects();
    }

    function getXP_Beast(_val)
    {
        local key = "Num_Beasts";
        local numBeasts = this.getFlag(key);
        local statBeasts = ::World.Statistics.getFlags().getAsInt("BeastsDefeated");
        if(statBeasts > numBeasts) this.setFlag(key, statBeasts);

        return (statBeasts - numBeasts) * _val;
    }

    function getXP_Contracts(_val)
    {
        local key = "Num_Contracts";
        local numContracts = this.getFlag(key);
        local statContracts = ::World.Contracts.getContractsFinished() - ::World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone");
        if(statContracts > numContracts) this.setFlag(key, statContracts);

        return (statContracts - numContracts) * _val;
    }

    function getXP_Raids(_val)
    {
        local key = "Num_Raids";
        local numRaids = this.getFlag(key);
        local statRaids = ::World.Statistics.getFlags().getAsInt("CaravansRaided");
        if(statRaids > numRaids) this.setFlag(key, statRaids);

        return (statRaids - numRaids) * _val;
    }

    function getXP_Locations(_val)
    {
        local key = "Num_Locs";
        local numLocs = this.getFlag(key);
        local statLocs = ::World.Statistics.getFlags().getAsInt("LocationsDiscovered");
        if(statLocs > numLocs) this.setFlag(key, statLocs);

        return (statLocs - numLocs) * _val;
    }

    function getXP_LegendaryLocationsBonus()
    {
        local xp = 0;
        local count = ::World.Flags.getAsInt("LegendaryLocationsDiscovered");
        local odds = ::Math.min(15, count); //there are 15 or so of these depending on how they are counted (mods can cadd more!)
        local maxRoll = this.m.Level * 2;
        //Ranger max level is ~12   [so 24 vs 15 max odds]

        this.m.DailyOdds = odds;
        this.m.DailyMax = maxRoll;
        
        while( xp < ::PandorasHobby.Follower.MaxDailyXP && ::Math.rand(0, maxRoll) < odds )
        {
            xp += 1;
        }        
        return xp;
    }

    function updateValueTrackers()
	{
        this.setFlag("Num_Beasts", ::World.Statistics.getFlags().getAsInt("BeastsDefeated"));
        this.setFlag("Num_Contracts", ::World.Contracts.getContractsFinished() - ::World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone"));
        this.setFlag("Num_Raids", ::World.Statistics.getFlags().getAsInt("CaravansRaided"));
        this.setFlag("Num_Locs", ::World.Statistics.getFlags().getAsInt("LocationsDiscovered"));
        //this.setFlag("Num_LegLocs", ::World.Flags.getAsInt("LegendaryLocationsDiscovered"));
	}

    function wasNewDay()
	{
        //try to hunt
        this.attemptHunting();
	}

    function attemptHunting()
    {
        if( !this.hasSkill(::PandorasHobby.Follower.Skill.Guide_Hunt_Forest) ) return;

        //Basic hunting works best on Forest, Plains, Farmland, and Tundra and Hills
        //Advanced Hunting works on any terrain
        //No we can simply this, just reduce all the base hunting odds, unless using Advanced hunting!

        local odds = ::PandorasHobby.Follower.HuntingOdds[::World.State.getPlayer().getTile().Type];

        if( !this.hasSkill(::PandorasHobby.Follower.Skill.Guide_Hunt_All) ) odds -= 8;

        if( ::Math.rand(0,100) > odds ) return;

        //hunt was successful, give them some food!
        local bonus = 0;        
        if( this.hasSkill(::PandorasHobby.Follower.Skill.Pup_Hunt) ) bonus += (this.m.Age * this.m.Age);

        local item = ::new("scripts/items/supplies/strange_meat_item");
        item.randomizeAmount();
        item.setAmount(item.getAmount() + bonus);
		::World.Assets.getStash().add(item);
    }

    function onUpdate()
    {        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scouting_Report))
        {
            ::World.Assets.m.IsAlwaysShowingScoutingReport = true;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scouting_Vision))
        {
            ::World.Assets.m.IsShowingExtendedFootprints = true;
            ::World.Assets.m.FootprintVision += 0.30;
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Snow_2))
        {
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Snow] *= 1.15;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Tundra] *= 1.15;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Snow_1))
        {
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Snow] *= 1.10;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Tundra] *= 1.10;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Guide_Move))
        {
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Forest] *= 1.2;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.SnowyForest] *= 1.2;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.LeaveForest] *= 1.2;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.AutumnForest] *= 1.2;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Swamp] *= 1.2;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Lookout_High))
        {
            // More Vision in Mountains and Hills
		    ::World.Assets.m.TerrainTypeVisionMult[::Const.World.TerrainType.Hills] *= 1.25;
		    ::World.Assets.m.TerrainTypeVisionMult[::Const.World.TerrainType.Mountains] *= 1.25;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Lookout_All))
        {
            ::World.Assets.m.VisionRadiusMult = 1.10;
        }

        //Carto_Pay is handled elsewhere
        //all Hunting skills are handled elsewhere
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Mountain))
        {
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Mountains] *= 1.2;            
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Rambler_Move))
        {
            //"Travel 5-10% faster on Plains, Farmland, Steppe, Badlands, & Oasis."
            local bonus = (this.m.Age == ::PandorasHobby.Follower.Age.Old) ? 1.10 : 1.05;

            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Plains] *= bonus;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Farmland] *= bonus;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Steppe] *= bonus;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Badlands] *= bonus;
            ::World.Assets.m.TerrainTypeSpeedMult[::Const.World.TerrainType.Oasis] *= bonus;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.OldBear_Ammo))
        {
            ::World.Assets.m.AmmoMaxAdditional += (5 * ::World.getPlayerRoster().getSize());
        }        
    }

    //HD code for the brigand chasing speed mod
    function getMovementSpeedMult()
    {
        if (this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Pursuit) && this.isFollowingParty()) return 1.2;

        return 1.0;
    }

    function isFollowingParty()
    {
        local autoAttack = ::World.State.m.AutoAttack;
		if (::MSU.isNull(autoAttack)) return false;
		if (!autoAttack.isAlive()) return false;
		if (autoAttack.isHiddenToPlayer()) return false;
		if (autoAttack.isAlliedWithPlayer()) return false;

        ::logDebug("DEBUG: HOT PURSUIT!!");

		return true;
    }

    function onLocationDiscovered( _location )
	{
		local settlements = ::World.EntityManager.getSettlements();
		local dist = 9999;

		foreach( s in settlements )
		{
			local d = s.getTile().getDistanceTo(_location.getTile());

			if (d < dist)
			{
				dist = d;
			}
		}

		local reward = ::Math.min(400, ::Math.max(100, 10 * dist));

		if (_location.isLocationType(::Const.World.LocationType.Unique))
		{
			reward *= 2;
		}

		::World.Assets.addMoney(reward);
	}

    function updateEffects()
	{
        //follower has already included thier unique skill
        //append a summary of all the common ones

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scouting_Vision))
        {
            this.m.TooltipEffects.push("30% increased footprint view radius + Extended footprint information");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scouting_Report))
        {
            this.m.TooltipEffects.push("Always receive a scouting report for enemies near you");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Snow_2))
        {
            this.m.TooltipEffects.push("Travel 15% faster on Snow & Tundra");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Snow_1))
        {
            this.m.TooltipEffects.push("Travel 10% faster on Snow & Tundra");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Mountain))
        {
            this.m.TooltipEffects.push("Travel 20% faster on Mountains");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Raider_Pursuit))
        {
            this.m.TooltipEffects.push("Travel 20% faster while following a visible enemy");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Guide_Move))
        {
            this.m.TooltipEffects.push("Travel 20% faster on Forest & Swamp + Prevents sickness and accidents due to terrain");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Lookout_All))
        {
            this.m.TooltipEffects.push("10% increased sight radius");
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Lookout_High))
        {
            this.m.TooltipEffects.push("25% more Vision while on a Hill or Mountain");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Carto_Pay))
        {
            this.m.TooltipEffects.push("Earn up to 400 crowns for each location you discover. Double for Legendary.");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Guide_Hunt_All))
        {
            this.m.TooltipEffects.push("Often hunts for extra food. Best in Forests.");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Guide_Hunt_Forest))
        {
            this.m.TooltipEffects.push("Sometimes hunts for extra food. Best in Forests.");
        }
	}
});