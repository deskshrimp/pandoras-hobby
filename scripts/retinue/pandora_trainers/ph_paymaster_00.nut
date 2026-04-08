this.ph_paymaster_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_paymaster_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Cutting Expenses";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/paymaster_01";
		this.m.Image = "ui/events/event_04";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Paymaster_Disc_1;

		this.m.Effects = [			
			"Reduces the daily wage of each man by 15%",
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