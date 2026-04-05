this.steward_22_follower <- this.inherit("scripts/retinue/ph_follower_steward", {
	m = {},
    function create()
	{
		this.ph_follower_steward.create();

        this.m.ID = "follower.ph_steward_22";
		this.m.Name = "Tinker";
		this.m.Age = ::PandorasHobby.Follower.Age.Old;
		this.m.BaseCost = 7500;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Adult] + 1; //has an extra level!
		this.m.LevelsSpent = this.m.Level - 2; //unspent levels

		this.m.Skills = ::PandorasHobby.Follower.Skill.Tool_Storage | ::PandorasHobby.Follower.Skill.Scav_RecoverAll | ::PandorasHobby.Follower.Skill.Scav_Scavenge_1 | ::PandorasHobby.Follower.Skill.Smith_Repair_Speed | ::PandorasHobby.Follower.Skill.Smith_Recipes;

		this.m.Description = "Possessed by curiosity and a seemingly limitless number of pockets, Tinker is an experienced craftsman looking for some fresh air and new trinkets to work on.";

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

		this.m.Image = "ui/campfire/ph_steward_2";
    }

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Had " + this.Math.min(5, ::World.Statistics.getFlags().getAsInt("ItemsRepaired")) + "/5 items repaired at a town\'s smith";
		if (::World.Statistics.getFlags().getAsInt("ItemsRepaired") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}

		this.m.Requirements[1].Text = "Have " + ::Const.Strings.BusinessReputation[6] + " reputation. (" + ::World.Assets.getBusinessReputation() + "/" + ::Const.BusinessReputation[6] + ")";
		this.m.Requirements[1].IsSatisfied = ::World.Assets.getBusinessReputation() >= ::Const.BusinessReputation[6];

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

	function updateEffects()
	{	
		this.m.Effects = [
			"Increases tool storage by 50",
			"Unlocks Champ gear recipes + scavenges + 25% faster repair speed",
		];

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_steward.updateEffects();
	}
});