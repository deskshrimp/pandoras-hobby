this.ph_alch_11 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_alch_11";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Advanced Potions";
        this.m.Description = "";
		this.m.Image = "ui/campfire/alchemist_01";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Potions_2;

		this.m.Effects = [
			"Unlocks all Potion recipes",
			"Unlocks reagent conversion recipes",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Uncommon Potion Recipes"
			},
			{
				IsSatisfied = false,
				Text = "Medicinal Concoctions"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Alch_Potions_1);

		this.m.Requirements[1].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Medic_Medicine);

		this.m.Requirements[2].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[2].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});