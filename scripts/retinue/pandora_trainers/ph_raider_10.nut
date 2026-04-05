this.ph_raider_10 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_raider_10";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Mountaineering";
        this.m.Description = "";
		this.m.Image = "ui/campfire/brigand_01";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Raider_Mountain;

		this.m.Effects = [
			"Travel 20% faster on mountains",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Northern Logistics I: Snow"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Raider_Snow_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});