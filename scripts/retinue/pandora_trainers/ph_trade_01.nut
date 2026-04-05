this.ph_trade_01 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_trade_01";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "Finding Hidden Gems";
        this.m.Description = "";
		this.m.Image = "ui/campfire/trader_01";
		this.m.Cost = 2000;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Trader_Shop;

		this.m.Effects = [
			"10% increased maximum rarity of items in shops"
		];

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "The Art of the Trade"
			},
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = this.checkRequiredSkill(::PandorasHobby.Follower.Skill.Trader_Trade);

		this.m.Requirements[1].Text = "An available skill point (You have " + this.getAvailableSkillPoints() + ")";
		this.m.Requirements[1].IsSatisfied = this.getAvailableSkillPoints() > 0;
	}
});