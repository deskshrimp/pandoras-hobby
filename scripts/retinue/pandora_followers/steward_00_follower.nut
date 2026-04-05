this.steward_00_follower <- this.inherit("scripts/retinue/ph_follower_steward", {
	m = {},
    function create()
	{
		this.ph_follower_steward.create();

        this.m.ID = "follower.ph_steward_00";
		this.m.Name = "Fish";
		this.m.Age = ::PandorasHobby.Follower.Age.Young;		
		this.m.BaseCost = 1250;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = 1;
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Net_Master;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		this.m.Image = "ui/campfire/ph_steward_0";
    }

	function onEvaluate()
	{		
		this.m.Requirements[0].Text = "Used a port to travel " + ::Math.min(5, ::World.Statistics.getFlags().getAsInt("PH_PortFastTravelUsed")) + "/5 times";
		this.m.Requirements[0].IsSatisfied = (::World.Statistics.getFlags().getAsInt("PH_PortFastTravelUsed") >= 5);

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 500;
			this.m.Requirements[0].Text += " [+500]";
		}		
	}

	function getDescription()
	{
		if(this.m.Age == ::PandorasHobby.Follower.Age.Young)
		{
			return "A young fisherboy who knows how to work with nets.";
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			return "An adventurous lad who chose a life of chasing after mercenaries instead of working the docks.";
		}
		else
		{
			return "Fish left the docks long ago, but the docks never left him. He's the finest net-maker you'll ever find.";
		}		
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Will repair 1 broken net in stash each day (costs ammo/tools)",
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			this.m.Effects = [
				"Will repair and upgrade 1 net in stash each day (costs ammo/tools/web)",				
			];
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects = [
				"Unlock Toothed Net recipe + Will repair and upgrade 1 net in stash each day (costs ammo/tools/web/teeth)",
			];
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_steward.updateEffects();
	}
});