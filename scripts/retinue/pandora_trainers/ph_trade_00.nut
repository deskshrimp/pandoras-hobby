this.ph_trade_00 <- this.inherit("scripts/retinue/ph_trainer", {
    m = {},
    function create()
	{
        this.ph_trainer.create();
        this.m.ID = "trainer.ph_trade_00";
		this.m.Archetype = ::PandorasHobby.Follower.Archetype.Agent;
        this.m.Name = "The Art of the Trade";
        this.m.Description = "";
		this.m.Image = "ui/campfire/trader_01";
		this.m.Cost = 3500;

        this.m.Skill = ::PandorasHobby.Follower.Skill.Trader_Trade;

		this.m.Effects = [
			"+1 maximum amount of each type of Trade Goods for sale",			
		];

		if ( ::Hooks.hasMod("mod_hardened") )
		{
			this.m.Effects.push("Trade Goods are 100% more common in shops");
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