this.ph_drill_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_drill_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Officer;
		this.m.Name = "Training Drills";
        this.m.Description = "";
		this.m.Image = "ui/campfire/drill_01";
		this.m.Cost = 3500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Drill_BoostXP;

		if ( ::Hooks.hasMod("mod_hardened") )
		{
			this.m.Effects = [			
				"Makes your men gain 20% more experience at level 1, with 2% less at each further level",
				"Makes men in reserve never lose mood from not taking part in battles"
			];
		}
		else
		{
			//Reforged doubles these bonuses
			"Makes your men gain 40% more experience at level 1, with 4% less at each further level",
			"Makes men in reserve never lose mood from not taking part in battles"
		}

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