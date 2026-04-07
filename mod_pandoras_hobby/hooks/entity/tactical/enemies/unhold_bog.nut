::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/unhold_bog", function(q) {

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
        
        if ( ::Hooks.hasMod("mod_hardened") )
        {
            this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_rattle", function(o) {
			    o.m.RequiredWeaponType = null;
		    }));
        }
        
        this.m.Skills.add(::new("scripts/skills/perks/perk_lone_wolf"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_rf_feral_rage"));

        return true;
    }
});