this.ph_minst_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_minst_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Spreading Rumors";
        this.m.Description = "";
		this.m.Image = "ui/campfire/minstrel_01";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Minstrel_Renown_2;

		this.m.Effects = [			
			"Makes you earn 20% more renown with every action"
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Writing Balads"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Minstrel_Renown_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});