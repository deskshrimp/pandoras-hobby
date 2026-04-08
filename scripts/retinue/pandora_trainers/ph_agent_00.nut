this.ph_agent_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_agent_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Settlement Situations";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/agent_01";
		this.m.Image = "ui/events/event_77";
		this.m.Cost = 4000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Agent_Settlements;

		this.m.Effects = [			
			"Reveals available contracts and active situations in the tooltip of settlements no matter where you are"
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