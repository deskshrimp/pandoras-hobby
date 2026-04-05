this.ph_agent_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_agent_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Common Caravan Routes";
        this.m.Description = "";
		this.m.Image = "ui/campfire/agent_01";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Agent_Caravan;

		this.m.Effects = [			
			"Makes you see the position of some caravans at all times and even if outside your sight radius"
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