this.ph_cook_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_cook_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Kettles & Cauldrons";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/cook_01";
		this.m.Image = "ui/events/event_61";
		this.m.Cost = 500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Cook_Recipes;

		this.m.Effects = [			
			"Unlocks cooking recipes",
			"Prevents \'Spoiled Food\' event",
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