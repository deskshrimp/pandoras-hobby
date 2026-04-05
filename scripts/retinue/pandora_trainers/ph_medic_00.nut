this.ph_medic_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_medic_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Medicinal Concoctions";
        this.m.Description = "";
		this.m.Image = "ui/campfire/surgeon_01";
		this.m.Cost = 1000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Medic_Medicine;

		this.m.Effects = [
			"Unlocks a variety of recipes for helpful medicines",			
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