this.ph_quart_02 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_quart_02";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Hoard like a Dragon";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/quartermaster_01";
		this.m.Image = "ui/events/event_55";
		this.m.Cost = 3000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Quart_Storage_3;

		this.m.Effects = [			
			"",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Advanced Hoarding Techniques"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		local num = (40 + ::World.Retinue.getInventoryUpgrades() * 20);

		this.m.Effects = [			
			"Increases Ammo, Tool, & Medicine storage by 40 plus 20 per cart upgrade [Currently: +" + num + "]",
		];

		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Quart_Storage_2);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});