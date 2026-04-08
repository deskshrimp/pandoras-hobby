this.ph_minst_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_minst_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Writing Balads";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/minstrel_01";
		this.m.Image = "ui/events/event_92";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Minstrel_Renown_1;

		this.m.Effects = [
			"Makes you earn 15% more renown with every action"
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