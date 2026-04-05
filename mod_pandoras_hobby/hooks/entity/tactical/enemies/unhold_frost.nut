::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/unhold_frost", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //Boost their hitpoints
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 100;
        
        //give them back the vanilla steel brow -- they are the apex unhold afterall
        this.getSkills().add(::new("scripts/skills/perks/perk_steel_brow"));

        //bonus perks -- the menacing frost bully        
        this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));

        return true;
    }
});