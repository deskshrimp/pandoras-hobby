::PandorasHobby.MH.hook("scripts/skills/skill", function(q) {
    q.getChanceDecapitate = @() function()
    {
        if(this.m.Container != null && this.m.Container.hasSkill("effects.ph_conqueror_potion"))
	    {            
		    return this.m.ChanceDecapitate + 31;
	    }
	    return this.m.ChanceDecapitate;
    }
});