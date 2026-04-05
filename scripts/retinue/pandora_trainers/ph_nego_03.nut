this.ph_nego_03 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_nego_03";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Tabula Rasa";
        this.m.Description = "";
		this.m.Image = "ui/campfire/negotiator_01";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Nego_Decay_3;

		this.m.Effects = [			
			"Bad Relations recover 100% faster",
			"Good Relations decay 15% slower",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Earning Forgiveness"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Nego_Decay_2);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});