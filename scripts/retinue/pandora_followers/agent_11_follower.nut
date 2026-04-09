this.agent_11_follower <- this.inherit("scripts/retinue/ph_follower_agent", {
	m = {},
    function create()
	{
		this.ph_follower_agent.create();

        this.m.ID = "follower.ph_agent_11";
		//this.m.Name = "Porter";
		this.m.Age = ::PandorasHobby.Follower.Age.Adult;
		this.m.BaseCost = 6250;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Young];
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Porter_Rarity | ::PandorasHobby.Follower.Skill.Trader_Trade | ::PandorasHobby.Follower.Skill.Trader_Shop;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		//this.m.Image = "ui/campfire/ph_agent_1";
    }

	function onEvaluate()
	{		
		local settlements = ::World.EntityManager.getSettlements();
		local settlementsVisited = 0;
		local maxSettlements = settlements.len();

		foreach( s in settlements )
		{
			if (s.isVisited())
			{
				settlementsVisited = ++settlementsVisited;
			}
		}

		this.m.Requirements[0].Text = "Visited " + settlementsVisited + "/" + maxSettlements + " settlements";

		if (settlementsVisited >= maxSettlements)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}

		this.m.Requirements[1].Text = "Have " + ::Const.Strings.BusinessReputation[5] + " reputation. (" + ::World.Assets.getBusinessReputation() + "/" + ::Const.BusinessReputation[5] + ")";
		this.m.Requirements[1].IsSatisfied = ::World.Assets.getBusinessReputation() >= ::Const.BusinessReputation[5];

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[0].Text += " [+1000]";
		}
		if(!this.m.Requirements[1].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[1].Text += " [+1000]";
		}
	}

	function getBaseName()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "Porter";
		}
		else
		{
			return "Monger";
		}
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_agent_1";
		}
		else
		{
			return "ui/campfire/trader_0";
		}
	}

	function getDescription()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
			{
				return "An experienced porter hand who knows where to find trade goods, and the occasional special trinket.";
			}
			else
			{
				return "An experienced trader who ensures that merchants don't hold any of their wares back when dealing with the company.";
			}
		}
		else
		{
			return "An experienced trader who ensures that merchants don't hold any of their wares back when dealing with the company.";
		}	
	}

	function updateEffects()
	{
		this.m.Effects = [
			"15% increased shop item rarity",
			"+1 trade goods in shops & trade goods are 100% more common",
		];

		if (! ::Hooks.hasMod("mod_hardened") )
		{
			//HD mod adds the bit about making goods more common
			this.m.Effects[1] = "+1 maximum amount of each type of Trade Goods for sale";
		}

		if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			if(::World != null && ::World.Statistics != null)
			{
				this.m.Effects[0] = "15% increased shop item rarity & 1% additional rarity per 25 trade goods sold (up to 15%) [+" + this.getShopRarityBonus() + "%]";
			}
			else
			{
				this.m.Effects[0] = "15% increased shop item rarity & 1% additional rarity per 25 trade goods sold (up to 15%)";
			}
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_agent.updateEffects();
	}
});