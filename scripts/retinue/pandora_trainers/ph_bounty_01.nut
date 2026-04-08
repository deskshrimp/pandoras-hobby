this.ph_bounty_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_bounty_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;		
        this.m.Name = "Chump or Champion?";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/bounty_hunter_01";
		this.m.Image = "ui/events/event_122";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Bounty_Champ_2;

		this.m.Effects = [			
			"5% increased chance to encounter champions",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Bounty Hunting"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Bounty_Champ_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});