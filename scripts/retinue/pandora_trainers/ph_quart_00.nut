this.ph_quart_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_quart_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "How to Hoard";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/quartermaster_01";
		this.m.Image = "ui/events/event_55";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Quart_Storage_1;

		this.m.Effects = [			
			"",
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
		local num = (20 + ::World.Retinue.getInventoryUpgrades() * 10);
		this.m.Effects = [			
			"Increases Ammo, Tool, & Medicine storage by 20 plus 10 per cart upgrade [Currently: +" + num + "]",
		];

		this.m.Requirements[0].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[0].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});