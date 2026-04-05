this.ph_recruit_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_recruit_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Making Muster";        
        this.m.Description = "";
		this.m.Image = "ui/campfire/recruiter_01";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Recruiter_Boost;

		this.m.Effects = [
			"Makes up to 6 additional men available to recruit in every settlement"
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Holding Tryouts"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Recruiter_Tryout);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});