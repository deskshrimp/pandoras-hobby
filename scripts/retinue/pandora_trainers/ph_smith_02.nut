this.ph_smith_02 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_smith_02";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;        
		this.m.Name = "There is no Tool";
        this.m.Description = "";
		this.m.Image = "ui/campfire/blacksmith_01";
		this.m.Cost = 4000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Smith_Recipes;

		this.m.Effects = [
			"Unlocks recipes for crafting with champion loot, altering your banner, etc",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Advaned Smithing"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Smith_Recipes);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});