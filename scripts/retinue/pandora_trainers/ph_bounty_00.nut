this.ph_bounty_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_bounty_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Bounty Hunting";        
        this.m.Description = "";
		this.m.Image = "ui/campfire/bounty_hunter_01";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Bounty_Champ_1;

		this.m.Effects = [			
			"3% increased chance to encounter champions",			
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