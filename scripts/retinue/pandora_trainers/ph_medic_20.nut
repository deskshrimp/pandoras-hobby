this.ph_medic_20 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_medic_20";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Emergency Field Medicine";  //"How to Save a Life"
        this.m.Description = "";
		//this.m.Image = "ui/campfire/surgeon_01";
		this.m.Image = "ui/events/event_34";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Medic_Survive;

		this.m.Effects = [
			"Makes every man without a permanent injury guaranteed to survive an otherwise fatal blow",
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