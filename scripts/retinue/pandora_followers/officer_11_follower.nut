this.officer_11_follower <- this.inherit("scripts/retinue/ph_follower_officer", {
	m = {},
    function create()
	{
		this.ph_follower_officer.create();

        this.m.ID = "follower.ph_officer_11";
		this.m.Name = "The Collector";
		this.m.Age = ::PandorasHobby.Follower.Age.Adult;
		this.m.BaseCost = 4000;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Young];
		this.m.LevelsSpent = this.m.Level - 1; //unspent level

		this.m.Skills = ::PandorasHobby.Follower.Skill.Collector_Pay | ::PandorasHobby.Follower.Skill.Bounty_Champ_1;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		this.m.Image = "ui/campfire/ph_officer_1";
    }

	function onEvaluate()
	{	
		this.m.Requirements[0].Text = "Slay a Champion";
		this.m.Requirements[0].IsSatisfied = (::World.Statistics.getFlags().getAsInt("PH_ChampionsKilled") > 0);

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 2000;
			this.m.Requirements[0].Text += " [+2000]";
		}		
	}

	function getDescription()
	{
		if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			return "With a disposition as fiery as her mane, The Collector cares only about driving the company to slay the toughest enemies we can find.";
		}
		else
		{
			return "You aren't sure where her money comes from or who the fark would buy such grisly trophies, but as long as the company gets a cut, it isn't your problem.";
		}		
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Pays up to 200 crowns for each champion slain",
			"3% increased chance for champions",
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "Pays up to 300 crowns for each champion slain";
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_officer.updateEffects();
	}
});