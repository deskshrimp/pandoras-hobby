this.ph_anat_30 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_z_anat_30";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Healer;
        this.m.Name = "Flesh & Insight";
        this.m.Description = "";		
		this.m.Image = "ui/events/event_181";
		this.m.Cost = 1500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Alch_Anatomist_1;

		this.m.Effects = [
			"Champions will drops incomplete anatomist potions",
			"Unlocks most anatomist potion crafting recipes",
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Uncommon Potion Recipes"
			},
			{
				IsSatisfied = false,
				Text = "Medicinal Concoctions"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Alch_Potions_1);

		this.m.Requirements[1].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Medic_Medicine);

		this.m.Requirements[2].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[2].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});