this.ph_nego_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_nego_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Contract Negotiation";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/negotiator_01";
		this.m.Image = "ui/events/event_63";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Nego_Negotiation;

		this.m.Effects = [			
			"Allows for more rounds of contract negotiations with potential employers, and without any hit to relations"
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