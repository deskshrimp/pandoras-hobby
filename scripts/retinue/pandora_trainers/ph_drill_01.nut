this.ph_drill_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_drill_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Personalized Training";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/drill_01";
		this.m.Image = "ui/events/event_06";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Drill_BoostAttrib_1;

		this.m.Effects = [			
			"Will train at least 1 uninjured man a day, bestowing a temporary buff to 1 of their attributes"
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Training Drills"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Drill_BoostXP);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});