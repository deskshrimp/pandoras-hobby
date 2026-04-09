this.officer_00_follower <- this.inherit("scripts/retinue/ph_follower_officer", {
	m = {},
    function create()
	{
		this.ph_follower_officer.create();

        this.m.ID = "follower.ph_officer_00";
		//this.m.Name = "Brat";
		this.m.Age = ::PandorasHobby.Follower.Age.Young;
		this.m.BaseCost = 1500;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = 1;
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Brat_HireDisc;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		//this.m.Image = "ui/campfire/ph_officer_0";
    }

	function onEvaluate()
	{		
		this.m.Requirements[0].Text = "Recruited " + ::Math.min(10, ::World.Statistics.getFlags().getAsInt("BrosHired")) + "/10 men";
		if (::World.Statistics.getFlags().getAsInt("BrosHired") >= 10)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 500;
			this.m.Requirements[0].Text += " [+500]";
		}		
	}

	function getBaseName()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "Brat";
		}
		else
		{
			return "Mecks";
		}
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_officer_0";
		}
		else
		{
			return "ui/campfire/recruiter_0";
		}
	}

	function getDescription()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			if(this.m.Age == ::PandorasHobby.Follower.Age.Young)
			{
				return "A brat with a real talent at egging men on.";
			}
			else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
			{	
				return "Has a rare talent for goading men into actions they will regret later, yet leaving them with only themselves to blame.";
			}
			else
			{
				return "A skilled recruiter1 and negotiator. A perfect addition to a growing company.";
			}
		}	
		else
		{
			return "Mecks has a rare talent for goading men into actions they will regret later, yet leaving them with only themselves to blame.";
		}	
	}

	function updateEffects()
	{
		this.m.Effects = [
			"You pay 5% less up front for hiring new men",
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			this.m.Effects[0] = "You pay 10% less up front for hiring new men";
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "You pay 15% less up front for hiring new men";			
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