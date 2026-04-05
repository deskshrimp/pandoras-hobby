this.ph_quart_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_quart_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Advanced Hoarding Techniques";
        this.m.Description = "";
		this.m.Image = "ui/campfire/quartermaster_01";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Quart_Storage_2;

		this.m.Effects = [			
			"",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "How to Hoard"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		local num = (30 + ::World.Retinue.getInventoryUpgrades() * 15);

		this.m.Effects = [			
			"Increases Ammo, Tool, & Medicine storage by 30 plus 15 per cart upgrade [Currently: +" + num + "]",
		];

		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Quart_Storage_1);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});