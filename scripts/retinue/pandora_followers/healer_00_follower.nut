this.healer_00_follower <- this.inherit("scripts/retinue/ph_follower_healer", {
	m = {},
    function create()
	{
		this.ph_follower_healer.create();

        this.m.ID = "follower.ph_healer_00";
		this.m.Name = "Foundling";
		this.m.Age = ::PandorasHobby.Follower.Age.Young;		
		this.m.BaseCost = 1500;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = 1;
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Extra_Medicine;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		this.m.Image = "ui/campfire/ph_healer_0";
    }

	function onEvaluate()
	{		
		this.m.Requirements[0].Text = "Treated " + ::Math.min(5, ::World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple")) + "/5 men with injuries at a Temple";
		this.m.Requirements[0].IsSatisfied = (::World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple") >= 5);

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[0].Text += " [+1000]";
		}
	}

	function getDescription()
	{
		if(this.m.Age == ::PandorasHobby.Follower.Age.Young)
		{
			return "A young foundling who was left at the temple. With time & training he could become an asset.";
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			return "A fine young man who has honed the skills he learned at the Temple.";
		}
		else
		{
			return "Foundling knows how to pack more medicine into every man's kit, an asset for any mercenary company.";
		}		
	}

	function updateEffects()
	{
		this.m.Effects = [
			"+10 Medical Supply Capacity",
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			this.m.Effects = [
				"+20 Medical Supply Capacity",
			];
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects = [
				"+50 Medical Supply Capacity",
			];
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_healer.updateEffects();
	}
});