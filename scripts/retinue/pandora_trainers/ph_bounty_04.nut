this.ph_bounty_04 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_bounty_04";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;		
        this.m.Name = "Ultimate Thrillseeker";
        this.m.Description = "";
		this.m.Image = "ui/campfire/bounty_hunter_01";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Bounty_Champ_5;

		this.m.Effects = [
			"8% increased chance to encounter champions",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Champion Hunter"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_4);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});