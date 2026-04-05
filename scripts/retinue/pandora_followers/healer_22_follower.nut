this.healer_22_follower <- this.inherit("scripts/retinue/ph_follower_healer", {
	m = {},
    function create()
	{
		this.ph_follower_healer.create();

        this.m.ID = "follower.ph_healer_22";
		this.m.Name = "Spook";
		this.m.Age = ::PandorasHobby.Follower.Age.Old;
		this.m.BaseCost = 8000;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Adult];
		this.m.LevelsSpent = this.m.Level - 3;//has unspent skills!

		this.m.Skills = ::PandorasHobby.Follower.Skill.True_Cultist | ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All | ::PandorasHobby.Follower.Skill.Alch_Cultist;

		this.m.Description = "Spook is surprisingly skilled follower. His obsession with Davkul can really grate on you though.";

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

		this.m.Image = "ui/campfire/ph_healer_2";
    }

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Have a Moral Reputation of " + ::Const.Strings.MoralReputation[3] + " or darker. [" + ::World.Assets.getMoralReputationAsText() + "]";

		//this is the same calculation done inside the AsText() method to find the right index
		local tier = ::Math.max(0, ::Math.min(::Const.Strings.MoralReputation.len() - 1, ::World.Assets.getMoralReputation() / 10));
		this.m.Requirements[0].IsSatisfied = tier <= 3;

		this.m.Requirements[1].Text = "Have at least one cultist or converted cultist on your roster";

		local brothers = ::World.getPlayerRoster().getAll();
		foreach( bro in brothers )
		{
			if ( bro.getBackground().PH_isCultist() )
			{
				this.m.Requirements[1].IsSatisfied = true;
				break;
			}
		}

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[0].Text += " [+1000]";
		}
		if(!this.m.Requirements[1].IsSatisfied)
		{
			this.m.Cost += 1000;
			this.m.Requirements[1].Text += " [+1000]";
		}
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Counts as a true Cultist for events & Cultist Potions require 1 less Snake Oil to craft",
			"Unlocks Snake Oil & Cultist recipes",
		];

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_healer.updateEffects();
	}
});