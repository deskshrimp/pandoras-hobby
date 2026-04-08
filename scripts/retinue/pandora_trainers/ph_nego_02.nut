this.ph_nego_02 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_nego_02";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Earning Forgiveness";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/negotiator_01";
		this.m.Image = "ui/events/event_63";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Nego_Decay_2;

		this.m.Effects = [			
			"Bad Relations recover 50% faster",
			"Good Relations decay 15% slower",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Maintaining your Rep"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Nego_Decay_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});