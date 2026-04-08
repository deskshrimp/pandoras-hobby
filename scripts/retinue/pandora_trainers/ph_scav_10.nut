this.ph_scav_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_scav_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Battlefield Scavenger";		
        this.m.Description = "";
		//this.m.Image = "ui/campfire/scavenger_01";
		this.m.Image = "ui/events/event_22";
		this.m.Cost = 3000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Scav_Scavenge_1;

		this.m.Effects = [			
			"Recovers a part of all ammo you use during battle",
			"Recovers tools and supplies from every armor destroyed by you during battle"
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