::PandorasHobby.MH.hook("scripts/entity/world/player_party", function(q) {
    if ( ! ::Hooks.hasMod("mod_hardened") )
    {
	    q.getVisionRadius = @(__original) function()
	    {
		    return __original() * ::World.Assets.getTerrainTypeVisionMult(this.getTile().Type);
	    }
    }
});