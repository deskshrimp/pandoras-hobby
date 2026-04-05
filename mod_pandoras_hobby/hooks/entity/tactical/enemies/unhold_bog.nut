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
        
        //give the HD perk from Frost version
        this.getSkills().add(::new("scripts/skills/perks/perk_killing_frenzy"));

        //bonus perk -- they should worry with a giant looming over them!
        this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));

        return true;
    }
});