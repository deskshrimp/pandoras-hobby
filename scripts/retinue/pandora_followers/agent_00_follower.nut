this.agent_00_follower <- this.inherit("scripts/retinue/ph_follower_agent", {
	m = {},
    function create()
	{
		this.ph_follower_agent.create();

        this.m.ID = "follower.ph_agent_00";
		//this.m.Name = "Little Bird";
		this.m.Age = ::PandorasHobby.Follower.Age.Young;
		this.m.BaseCost = 1250;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = 1;
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.LittleBird_Rumors;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		//this.m.Image = "ui/campfire/ph_agent_0";
    }

	function onEvaluate()
	{		
		this.m.Requirements[0].Text = "Paid for " + ::Math.min(10, ::World.Statistics.getFlags().getAsInt("PH_RumorsBought")) + "/5 rumors in the tavern.";
		if (::World.Statistics.getFlags().getAsInt("PH_RumorsBought") >= 5)
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
			return "Little Bird";
		}
		else
		{
			return "Songbird";
		}
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_agent_0";
		}
		else
		{
			return "ui/campfire/minstrel_0";
		}
	}

	function getDescription()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			if(this.m.Age == ::PandorasHobby.Follower.Age.Young)
			{
				return "A clever little thing with a knack for hearing things and learning secrets.";
			}
			else if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
			{
				return "She never runs out of rumors, and they\'re always start with \'a little bird told me\'.";
			}
			else
			{
				return "No longer a \'little\' bird, but sharper than ever.";
			}
		}
		else
		{
			return "Possessing of a clear voice and even clearer hearing, Songbird excells at gathering and spreading rumors.";
		}
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Makes tavern rumors more likely to contain useful information",
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
		{
			this.m.Effects[0] = "Makes tavern rumors more likely to contain useful information & +10% renown gain";
		}
		else if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "Makes tavern rumors more likely to contain useful information & +10% renown gain & good relations decay 10% slower";
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