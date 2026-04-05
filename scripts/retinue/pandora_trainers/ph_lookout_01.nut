this.ph_lookout_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_lookout_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Ranger;
        this.m.Name = "Scouting 102: Reports";		
        this.m.Description = "";
		this.m.Image = "ui/campfire/lookout_01";
		this.m.Cost = 2500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Scouting_Report;        

		this.m.Effects = [
			"Always receive a scouting report for enemies near you"            
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Scounting 101: Tracking"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Scouting_Vision);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});