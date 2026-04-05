this.ph_cook_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_cook_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Preserve & Persevere";
        this.m.Description = "";
		this.m.Image = "ui/campfire/cook_01";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Cook_Preserve;

		this.m.Effects = [			
			"Makes all provisions last 5 extra days",
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