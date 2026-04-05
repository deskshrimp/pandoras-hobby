this.ph_alch_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_alch_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "10% More Snake Oil";
        this.m.Description = "";
		this.m.Image = "ui/campfire/alchemist_01";
		this.m.Cost = 3000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_2x;

		this.m.Effects = [
			"10% Chance to produce an extra Snake Oil when crafting",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "101 Ways to Make Snake Oil"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});