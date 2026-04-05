this.ph_lookout_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_lookout_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Scounting 201: High Ground";
        this.m.Description = "";
		this.m.Image = "ui/campfire/lookout_01";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Lookout_High;

		this.m.Effects = [
			"25% more Vision while on a Hill or Mountain",			
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