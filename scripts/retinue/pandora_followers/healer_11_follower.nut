this.healer_11_follower <- this.inherit("scripts/retinue/ph_follower_healer", {
	m = {},
    function create()
	{
		this.ph_follower_healer.create();

        this.m.ID = "follower.ph_healer_11";
		//this.m.Name = "Quack";
		this.m.Age = ::PandorasHobby.Follower.Age.Adult;
		this.m.BaseCost = 3500;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Young];
		this.m.LevelsSpent = this.m.Level;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Less_Infection | ::PandorasHobby.Follower.Skill.Medic_Survive | ::PandorasHobby.Follower.Skill.Medic_Medicine;

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

		//this.m.Image = "ui/campfire/ph_healer_1";
    }

	function onEvaluate()
	{
		local numTreated = ::World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple") + ::World.Statistics.getFlags().getAsInt("InjuriesTreatedWithBandage");
		if ( ::Hooks.hasMod("mod_hardened") )
		{
			this.m.Requirements[0].Text = "Treated " + ::Math.min(10, numTreated) + "/10 men with injuries at a Temple or with Bandages in the field";
		}
		else
		{
			this.m.Requirements[0].Text = "Treated " + ::Math.min(10, numTreated) + "/10 men with injuries at a Temple";
		}
		this.m.Requirements[0].IsSatisfied = (numTreated >= 10);

		this.m.Requirements[1].Text = "Have " + ::Const.Strings.BusinessReputation[5] + " reputation. (" + ::World.Assets.getBusinessReputation() + "/" + ::Const.BusinessReputation[5] + ")";
		this.m.Requirements[1].IsSatisfied = ::World.Assets.getBusinessReputation() >= ::Const.BusinessReputation[5];

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 500;
			this.m.Requirements[0].Text += " [+500]";
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
			return "Quack";
		}
		else
		{
			return "Quack";
		}
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_healer_1";
		}
		else
		{
			return "ui/campfire/surgeon_0";
		}
	}

	function getDescription()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
			{
				return "A trained physician looking to put his skills to use in the field.";
			}
			else
			{
				return "A true master of his craft, but the men still give him a hard time.";
			}
		}
		else
		{
			return "A trained physician looking to put his skills to use in the field.";
		}
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Significantly reduces the infection chance of injuries",
			"Can save men who fall in battle & unlocks medical recipes",			
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "Greatly reduces the infection chance of injuries";			
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