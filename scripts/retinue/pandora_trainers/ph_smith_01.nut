this.ph_smith_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_smith_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
        this.m.Name = "Advaned Smithing";
        this.m.Description = "";
		//this.m.Image = "ui/campfire/blacksmith_01";
		this.m.Image = "ui/events/event_13";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Smith_Recipes;

		this.m.Effects = [			
			"Unlocks recipes for crafting with champion loot, altering your banner, etc",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "The Art of Gear Repair"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Smith_Repair_Speed);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});