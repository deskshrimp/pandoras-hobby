this.ph_anat_32 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_z_anat_32";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Apotheosis Incarnate";
        this.m.Description = "";
		this.m.Image = "ui/events/event_184";
		this.m.Cost = 5000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Anatomist_3;

		this.m.Effects = [
			"Unique/legendary enemies will drop incomplete potions",
			"Unlocks all anatomist potion crafting recipes",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Purging Transient Infirmity"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Alch_Anatomist_2);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});