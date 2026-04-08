this.ph_recruit_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_recruit_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Holding Tryouts";        
        this.m.Description = "";
		//this.m.Image = "ui/campfire/recruiter_01";
		this.m.Image = "ui/events/event_65";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Recruiter_Tryout;

		this.m.Effects = [			
			"Makes you pay 50% less for tryouts",
			"Makes up to 3 additional men available to recruit in every settlement"
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