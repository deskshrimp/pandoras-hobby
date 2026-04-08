this.ph_guide_11 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_guide_11";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Hunting & Gathering";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/scout_01";
		this.m.Image = "ui/events/event_37";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Guide_Hunt_All;

		this.m.Effects = [
			"Can often hunt for extra food. Best odds in Forests.",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Hunting"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Guide_Hunt_Forest);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});