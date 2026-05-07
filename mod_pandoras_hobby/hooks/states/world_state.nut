::PandorasHobby.MH.hook("scripts/states/world_state", function(q) {

    //must add the missing flags from hardened!
    if ( ! ::Hooks.hasMod("mod_hardened") )
    {
	    q.showCombatDialog = @(__original) function(_isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true, _properties = null, _pos = null)
	    {
		    if (::World.Assets.m.IsAlwaysShowingScoutingReport)
		    {
                //force the ID to ranger to force the scouting setting!
                local originalID = ::World.Assets.getOrigin().getID();
                ::World.Assets.getOrigin().m.ID = "scenario.rangers";
			    __original(_isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking, _properties, _pos);
			    ::World.Assets.getOrigin().m.ID = originalID;
    		}
	    	else
		    {
			    __original(_isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking, _properties, _pos);
		    }
	    }
	}
});
