this.ph_lookout_11 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_lookout_11";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Scounting 202: Farsight";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/lookout_01";
		this.m.Image = "ui/events/event_12";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Lookout_All;

		this.m.Effects = [
			"Increases your sight radius by 10%",			
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Scounting 201: High Ground"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Lookout_High);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});