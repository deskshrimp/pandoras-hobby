this.ph_lookout_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_lookout_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Scounting 101: Tracking";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/lookout_01";
		this.m.Image = "ui/events/event_10";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Scouting_Vision;        

		this.m.Effects = [
			"25% increased footprint view radius",
			"Extended footprint information",
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