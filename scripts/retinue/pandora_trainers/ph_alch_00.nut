this.ph_alch_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_alch_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "101 Ways to Make Snake Oil";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/alchemist_01";
		this.m.Image = "ui/events/event_106";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All;

		this.m.Effects = [			
			"Has a 25% chance of not consuming any crafting component used by you",
			"Unlocks \'Snake Oil\' recipes to earn money by crafting from various low tier components"
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