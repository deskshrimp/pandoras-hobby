this.ph_paymaster_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_paymaster_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Suppressing Wages";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/paymaster_01";
		this.m.Image = "ui/events/event_04";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Paymaster_Disc_2;

		this.m.Effects = [			
			"Reduces the daily wage of each man by 25%",
			"Reduces desertion by 50% + Prevents men demanding more pay"
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Cutting Expenses"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Paymaster_Disc_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});