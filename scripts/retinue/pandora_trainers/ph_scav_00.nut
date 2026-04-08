this.ph_scav_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_scav_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Leave no Trace";		
        this.m.Description = "";
		//this.m.Image = "ui/campfire/scavenger_01";
		this.m.Image = "ui/events/event_86";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Scav_RecoverAll;

		this.m.Effects = [			
			"Recovers all equipment worn by your men even if broken or lost because of death",
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