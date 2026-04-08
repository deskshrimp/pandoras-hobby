this.ph_guide_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_guide_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Hunting";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/scout_01";
		this.m.Image = "ui/events/event_27";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Guide_Hunt_Forest;

		this.m.Effects = [
			"Can sometimes hunt for extra food. Best odds in Forests.",
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