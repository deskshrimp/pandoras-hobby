this.ph_follower_agent <- this.inherit("scripts/retinue/ph_follower", {
    m = 
	{
	},
    function create()
	{
        this.ph_follower.create();
        this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
    }

    function wasHired()
    {
        //clear all class-related flags
    }

    function isMaxLevel()
    {
        return this.hasExactSkill(::PandorasHobby.Follower.SkillMasks.Agent_MAX);
    }

    function getXPHintText()
    {        
        return "Earn 1 XP: Complete a contract, or Sell 5 trade goods. Daily Bonus XP based on settlement, noble, & citystate relations.";
    }

    function earnDailyXP()
    {
        this.ph_follower.earnDailyXP();

        //daily Ally bonus
        this.m.XP += this.getXP_RelationsBonus();
        
        //collect XP from trackers        
        this.m.XP += this.getXP_Contracts(1);
        this.m.XP += this.getXP_TradeGoods(1);
        
        //this one is just awkward, let it go, unless there is a better framing.
        //this.m.XP += this.getXP_VisitedTowns(2);
                
        //check for level up and aging
        if(this.checkForLevelAge()) this.updateEffects();
    }

    function getXP_Contracts(_val)
    {
        local key = "Num_Contracts";
        local numContracts = this.getFlag(key);
        local statContracts = ::World.Contracts.getContractsFinished();
        if(statContracts > numContracts) this.setFlag(key, statContracts);

        return (statContracts - numContracts) * _val;
    }

    function getXP_TradeGoods(_val)
    {
        local key = "Num_TradeGoods";
        local num = this.getFlag(key);
        local stat = ::World.Statistics.getFlags().getAsInt("TradeGoodsSold");
        local xp = 0;
        while(stat >= num + 5)
        {
            num += 5;
            xp += _val;
            this.setFlag(key, num);
        }
        return xp;
    }

    function getXP_VisitedTowns(_val)
    {
        local settlements = ::World.EntityManager.getSettlements();
		local settlementsVisited = 0;
		foreach( s in settlements )
		{
			if (s.isVisited())
			{
				settlementsVisited = ++settlementsVisited;
			}
		}

        local key = "Num_TownsVisited";
        local num = this.getFlag(key);

        if(settlementsVisited > num) this.setFlag(key, settlementsVisited);

        return (settlementsVisited - num) * _val;
    }

    function getXP_RelationsBonus()
    {
        local xp = 0;
        local odds = 0;        

        local factions = ::World.FactionManager.getFactions();
        foreach(f in factions)
        {
            if (f == null) continue;

            if(f.getType() == ::Const.FactionType.Settlement)
            {
                odds += getXPValueForFactionRelation(f, 1, 2, 10, 2);
            }
            else if(f.getType() == ::Const.FactionType.NobleHouse)
            {
                odds += getXPValueForFactionRelation(f, 0, 5, 20, 2);
            }
            else if(f.getType() == ::Const.FactionType.OrientalCityState)
            {
                odds += getXPValueForFactionRelation(f, 1, 5, 20, 3);
            }
        }
        
        //Agent max level is ~11
        local maxRoll = this.m.Level * 10;

        this.m.DailyOdds = odds;
        this.m.DailyMax = maxRoll;

        while( xp < ::PandorasHobby.Follower.MaxDailyXP && ::Math.rand(0,maxRoll) < odds )
        {
            xp += 1;            
        }
        return xp;
    }

    function getXPValueForFactionRelation(_faction, _low, _mid, _high, _neg)
    {
        if(_faction.getPlayerRelation() <= 10.0) return 0;


        if(_faction.getPlayerRelation() >= 90.0) return _high;

        if(_faction.getPlayerRelation() >= 80.0) return _mid;

        if(_faction.getPlayerRelation() >= 70.0) return _low;

        if(_faction.getPlayerRelation() <= 20.0) return _neg;
        if(_faction.getPlayerRelation() <= 30.0) return _low;

        return 0;
    }
   

    function updateValueTrackers()
	{        
        this.setFlag("Num_Contracts", ::World.Contracts.getContractsFinished());
        this.setFlag("Num_TradeGoods", ::World.Statistics.getFlags().getAsInt("TradeGoodsSold"));
        //do not update the town visit flag, let it always apply        
	}

    function wasNewDay()
	{
	}

    function onGetShopRarityMult()
    {
        return this.getShopRarityBonus() * 0.01;
    }

    function getShopRarityBonus()
    {
        local bonus = 0;

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Trader_Shop))
        {
            bonus += 10;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Porter_Rarity))
        {
            if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
            {
                bonus += 5;
            }
            else
            {
                bonus += 5 + ::Math.min(15, ::World.Statistics.getFlags().getAsInt("TradeGoodsSold") / 25 );
            }
        }

        return bonus;
    }

    function onUpdate()
    {        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Agent_Caravan))
        {
            ::World.Assets.m.IsBrigand = true;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Joro_Spider))
        {
            ::World.Assets.m.NegotiationAnnoyanceMult = 0.25;
		    ::World.Assets.m.AdvancePaymentCap = 0.85;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Negotiation))
        {
            ::World.Assets.m.NegotiationAnnoyanceMult = 0.5;
		    ::World.Assets.m.AdvancePaymentCap = 0.75;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Decay_3))
        {
            ::World.Assets.m.RelationDecayGoodMult = 0.85;
		    ::World.Assets.m.RelationDecayBadMult = 2.0;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Decay_2))
        {
            ::World.Assets.m.RelationDecayGoodMult = 0.85;
		    ::World.Assets.m.RelationDecayBadMult = 1.50;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Decay_1))
        {
            ::World.Assets.m.RelationDecayGoodMult = 0.85;
		    ::World.Assets.m.RelationDecayBadMult = 1.15;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Minstrel_Renown_2))
        {
            ::World.Assets.m.BusinessReputationRate *= 1.20;
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Minstrel_Renown_1))
        {
            ::World.Assets.m.BusinessReputationRate *= 1.15;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.LittleBird_Rumors))
        {
            ::World.Assets.m.IsNonFlavorRumorsOnly = true;

            if(this.m.Age >= ::PandorasHobby.Follower.Age.Adult)
            {
                ::World.Assets.m.BusinessReputationRate *= 1.1;
            }
            
            if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
            {
                ::World.Assets.m.RelationDecayGoodMult *= 0.9;
            }
        }
    }

    function updateEffects()
	{
        //follower has already included thier unique skill
        //append a summary of all the common ones

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Agent_Settlements))
        {
            this.m.TooltipEffects.push("Reveals available contracts and active situations in the tooltip of settlements no matter where you are");
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Agent_Caravan))
        {
            this.m.TooltipEffects.push("Makes you see the position of some caravans at all times and even if outside your sight radius");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Negotiation) && !this.hasSkill(::PandorasHobby.Follower.Skill.Joro_Spider) )
        {
            this.m.TooltipEffects.push("Allows for more rounds of contract negotiations with potential employers, and without any hit to relations");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Decay_3))
        {
            this.m.TooltipEffects.push("Good relations decay 15% slower");
            this.m.TooltipEffects.push("Bad relations decay 100% faster");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Decay_2))
        {
            this.m.TooltipEffects.push("Good relations decay 15% slower");
            this.m.TooltipEffects.push("Bad relations decay 50% faster");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Nego_Decay_1))
        {
            this.m.TooltipEffects.push("Good relations decay 15% slower");
            this.m.TooltipEffects.push("Bad relations decay 15% faster");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Minstrel_Renown_2))
        {
            this.m.TooltipEffects.push("Makes you earn 20% more renown with every action");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Minstrel_Renown_1))
        {
            this.m.TooltipEffects.push("Makes you earn 15% more renown with every action");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Trader_Trade))
        {
            this.m.TooltipEffects.push("+1 maximum amount of each type of Trade Goods for sale");

            if ( ::Hooks.hasMod("mod_hardened") )
            {
                this.m.TooltipEffects.push("Trade Goods are 100% more common in shops");
            }
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Trader_Shop) && !this.hasSkill(::PandorasHobby.Follower.Skill.Porter_Rarity))
        {
            this.m.TooltipEffects.push("10% increased shop item rarity");
        }
	}
});