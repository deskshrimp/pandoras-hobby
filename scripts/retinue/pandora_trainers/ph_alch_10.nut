this.ph_alch_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_alch_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Uncommon Potion Recipes";		
        this.m.Description = "";
		this.m.Image = "ui/campfire/alchemist_01";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Potions_1;

		this.m.Effects = [			
			"Unlocks common Potion recipes, some with alternate ingredients",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[0].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});