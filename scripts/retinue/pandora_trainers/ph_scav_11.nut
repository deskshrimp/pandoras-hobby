this.ph_scav_11 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_scav_11";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "A Gleaning Obsession";		
        this.m.Description = "";
		this.m.Image = "ui/campfire/scavenger_01";
		this.m.Cost = 3000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Scav_Scavenge_2;

		this.m.Effects = [			
			"Recovers up to 100% more tools & ammo after a battle",			
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Leave no Trace"
			},
			{
				IsSatisfied = false,
				Text = "Battlefield Scavenger"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Scav_RecoverAll);
		this.m.Requirements[1].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Scav_Scavenge_1);

		this.m.Requirements[2].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[2].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});