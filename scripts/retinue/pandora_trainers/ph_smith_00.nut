this.ph_smith_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_smith_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "The Art of Gear Repair";		
        this.m.Description = "";
		//this.m.Image = "ui/campfire/blacksmith_01";
		this.m.Image = "ui/events/event_13";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Smith_Repair_Speed;

		this.m.Effects = [			
			"Increases repair speed by 20%",
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