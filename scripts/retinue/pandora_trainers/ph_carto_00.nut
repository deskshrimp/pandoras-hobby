this.ph_carto_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;		
        this.m.ID = "trainer.ph_carto_00";
        this.m.Name = "Cartography for Profit";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/cartographer_01";
		this.m.Image = "ui/events/event_45";
		this.m.Cost = 3000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Carto_Pay;        

		this.m.Effects = [			
			"Pays you 100 to 400 crowns for each location you discover. The further from civilization, the more you\'re paid. Legendary locations pay double.",
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