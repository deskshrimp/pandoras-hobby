this.ph_anat_31 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_z_anat_31";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Purging Transient Infirmity";
        this.m.Description = "";
		this.m.Image = "ui/events/event_181";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Anatomist_2;

		this.m.Effects = [
			"Allows sickness to be treated at the Temple",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Flesh & Insight"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Alch_Anatomist_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});