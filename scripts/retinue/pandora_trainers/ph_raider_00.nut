this.ph_raider_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_raider_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Northern Logistics I: Snow";
        this.m.Description = "";
		this.m.Image = "ui/campfire/brigand_01";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Raider_Snow_1;

		this.m.Effects = [
			"Travel 10% faster on snow & tundra",
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