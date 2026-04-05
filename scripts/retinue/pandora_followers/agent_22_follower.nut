this.agent_22_follower <- this.inherit("scripts/retinue/ph_follower_agent", {
	m = {},
    function create()
	{
		this.ph_follower_agent.create();

        this.m.ID = "follower.ph_agent_22";
		this.m.Name = "Joro";
		this.m.Age = ::PandorasHobby.Follower.Age.Old;
		this.m.BaseCost = 8500;
		this.m.Cost = this.m.BaseCost;

		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Adult] + 1; //bonus level (note 1 skill is a repeat, so only 6)
		this.m.LevelsSpent = this.m.Level - 1; //unspent level

		this.m.Skills = ::PandorasHobby.Follower.Skill.Joro_Spider | ::PandorasHobby.Follower.Skill.Agent_Settlements | ::PandorasHobby.Follower.Skill.Agent_Caravan | ::PandorasHobby.Follower.Skill.Nego_Negotiation | ::PandorasHobby.Follower.Skill.Nego_Decay_1 | ::PandorasHobby.Follower.Skill.Nego_Decay_2 | ::PandorasHobby.Follower.Skill.Nego_Decay_3;

		this.m.Description = "Joro \'The Spider\' is the daughter of a fallen noble family and a master negotiator who knows how to get what she wants from any merchant or petty noble.";

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		this.m.Image = "ui/campfire/ph_agent_2";
    }

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Have allied relations with a noble house or city state";
		this.m.Requirements[0].IsSatisfied = this.isAlliedWithNoble();

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[0].Text += " [+1000]";
		}
	}

	function isAlliedWithNoble()
	{
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			if (n.getPlayerRelation() >= 90.0)
			{
				return true;				
			}
		}

		local citystates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( c in citystates )
		{
			if (c.getPlayerRelation() >= 90.0)
			{
				return true;
			}
		}

		return false;
	}

	function updateEffects()
	{	
		this.m.Effects = [
			"Allows for many more rounds of contract negotiations with potential employers, and without any hit to relations",
			"A Master of Negotiation and Diplomacy",
		];

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_agent.updateEffects();
	}
});