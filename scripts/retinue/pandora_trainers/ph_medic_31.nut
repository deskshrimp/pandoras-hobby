this.ph_medic_31 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_medic_31";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "On the Care of Acute Injury";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/surgeon_01";
		this.m.Image = "ui/events/event_34";
		this.m.Cost = 5000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Medic_Treat_Tend;

		this.m.Effects = [
			"Provides a daily chance to tend or treat your injured men"
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Emergency Field Medicine"
			},
			{
				IsSatisfied = false,
				Text = "Improved Wound Care and You"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Medic_Survive);

		this.m.Requirements[1].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Medic_Heal_Rate);

		this.m.Requirements[2].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[2].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});