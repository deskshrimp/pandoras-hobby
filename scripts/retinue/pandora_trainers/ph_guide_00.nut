this.ph_guide_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_guide_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Pathfinding & Logistics";
        this.m.Description = "";
		this.m.Image = "ui/campfire/scout_01";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Guide_Move;        

		this.m.Effects = [			
			"Travel 20% faster on Forest & Swamp",
			"Prevents sickness and accidents due to terrain",
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