::PandorasHobby.MH.hook("scripts/entity/world/location", function(q) {

    //must add the missing flags from hardened!
    if ( ! ::Hooks.hasMod("mod_hardened") )
    {
	    q.m.HideDefenderAtNight <- true;	// Hide Defender Line up at night?
	
	    // Locations no longer display defender during night, unless the player has Lookout follower or plays Poacher Scenario
	    q.isShowingDefenders = @(__original) function()
	    {
            return ::World.Assets.m.IsAlwaysShowingScoutingReport || ::World.Assets.getOrigin().getID() == "scenario.rangers" || (this.m.IsShowingDefenders && ::World.getTime().IsDaytime);
        }
	}
});