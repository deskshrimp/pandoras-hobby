this.ranger_11_follower <- this.inherit("scripts/retinue/ph_follower_ranger", {
	m = {},
    function create()
	{
		this.ph_follower_ranger.create();

        this.m.ID = "follower.ph_ranger_11";
		//this.m.Name = "Rambler";
		this.m.Age = ::PandorasHobby.Follower.Age.Adult;
		this.m.BaseCost = 3500;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Young];
		this.m.LevelsSpent = this.m.Level - 1; //has an unspent level!

		this.m.Skills = ::PandorasHobby.Follower.Skill.Rambler_Move | ::PandorasHobby.Follower.Skill.Guide_Move;

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

		//this.m.Image = "ui/campfire/ph_ranger_1";
    }

    function onEvaluate()
	{
		local numCaravans = ::World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone");

		this.m.Requirements[0].Text = "Completed " + ::Math.min(5, numCaravans) + "/5 caravan escort contracts";
		this.m.Requirements[1].Text = "Have " + ::Const.Strings.BusinessReputation[5] + " reputation. (" + ::World.Assets.getBusinessReputation() + "/" + ::Const.BusinessReputation[5] + ")";

		this.m.Requirements[0].IsSatisfied = numCaravans >= 5;
		this.m.Requirements[1].IsSatisfied = ::World.Assets.getBusinessReputation() >= ::Const.BusinessReputation[5];
		
		//adjust cost
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
			return "Rambler";
		}
		else
		{
			return "Rambler";
		}
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_ranger_1";
		}
		else
		{
			return "ui/campfire/lookout_0";
		}
	}

	function getDescription()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
			{
				return "A skilled young caravan hand who grew bored of staying on the roads.";
			}		
		
			return "Rambler always finds the path that's a bit smoother than the rest.";
		}
		else
		{
			return "Rambler always finds the path that's a bit smoother than the rest.";
		}
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Travel 5% faster on Plains, Farmland, Steppe, Badlands, & Oasis.",
			"Travel 20% faster on Forest & Swamp + Prevents sickness and accidents due to terrain"
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "Travel 10% faster on Plains, Farmland, Steppe, Badlands, & Oasis.";
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