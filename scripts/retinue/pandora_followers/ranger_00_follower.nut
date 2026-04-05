this.ranger_00_follower <- this.inherit("scripts/retinue/ph_follower_ranger", {
	m = {},
    function create()
	{
		this.ph_follower_ranger.create();

        this.m.ID = "follower.ph_ranger_00";
		this.m.Name = "Pup";
		this.m.Age = ::PandorasHobby.Follower.Age.Young;
		this.m.BaseCost = 1500;
		this.m.Cost = this.m.BaseCost;		

		this.m.Level = 2; //starts with 2 skills!
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Guide_Hunt_Forest | ::PandorasHobby.Follower.Skill.Pup_Hunt;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have a heart"
			}
		];

		this.m.Image = "ui/campfire/ph_ranger_0";
    }

	function getDescription()
	{
		if(this.m.Age == ::PandorasHobby.Follower.Age.Young)
		{
			return "A couple of young pups with more energy than skill.";
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			return "A couple of fine young pups that can sometimes feed themselves.";
		}
		else
		{
			return "Pup and his pups only really care about food. An honest pursuit.";
		}		
	}

    function onEvaluate()
	{		
		this.m.Requirements[0].IsSatisfied = true;
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Slightly better hunting yields than other Rangers",
			"Sometimes hunts for extra food. Best in Forests"
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			this.m.Effects[0] = "Somewhat better hunting yields than other Rangers";
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "Better hunting yields than other Rangers";
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;		
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_ranger.updateEffects();
	}
});