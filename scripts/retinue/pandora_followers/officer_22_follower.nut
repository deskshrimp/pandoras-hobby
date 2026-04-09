this.officer_22_follower <- this.inherit("scripts/retinue/ph_follower_officer", {
	m = {},
    function create()
	{
		this.ph_follower_officer.create();

        this.m.ID = "follower.ph_officer_22";
		//this.m.Name = "Ol\' Wardog";
		this.m.Age = ::PandorasHobby.Follower.Age.Old;
		this.m.BaseCost = 7500;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Adult];
		this.m.LevelsSpent = this.m.Level - 2; //unpsent levels

		this.m.Skills = ::PandorasHobby.Follower.Skill.Wardog_Desert | ::PandorasHobby.Follower.Skill.Drill_BoostXP | ::PandorasHobby.Follower.Skill.Drill_BoostAttrib_1 | ::PandorasHobby.Follower.Skill.Recruiter_Tryout;

		//this.m.Description = "A veteran of many wars, Ol\' Wardog commands absolute loyalty from the men. Their moods may be poor, but they will never desert the company.";

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		//this.m.Image = "ui/campfire/ph_officer_2";
    }

	function onEvaluate()
	{	
		this.m.Requirements[0].Text = "Retired a man with a permanent injury that isn\'t indebted";
		this.m.Requirements[0].IsSatisfied = (::World.Statistics.getFlags().getAsInt("BrosWithPermanentInjuryDismissed") > 0);

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[0].Text += " [+1000]";
		}		
	}

	function getBaseName()
	{
		return "Ol\' Wardog";
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_officer_2";
		}
		else
		{
			return "ui/campfire/drill_0";
		}
	}

	function getDescription()
	{
		return "A veteran of many battles, Ol\' Wardog commands absolute loyalty from the men. Their moods may be poor, but they will never desert the company.";
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Your men will never desert the company.",
			"Also a skilled Drill Seargent and Recruiter",
		];

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_officer.updateEffects();
	}
});