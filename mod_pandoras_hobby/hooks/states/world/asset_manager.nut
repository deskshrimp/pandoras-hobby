::PandorasHobby.MH.hook("scripts/states/world/asset_manager", function(q) {
    
    //must add the missing flags from hardened!
    if ( ! ::Hooks.hasMod("mod_hardened") )
    {
        q.m.IsAlwaysShowingScoutingReport <- false;		// Same effect as Vanilla Poacher Origin
	    q.m.TerrainTypeVisionMult <- [];

        q.create = @(__original) function()
	    {
		    __original();
		    this.m.TerrainTypeVisionMult = array(::Const.World.TerrainFoodConsumption.len(), 1.0);
	    }

        q.resetToDefaults = @(__original) function()
	    {
		    this.m.IsAlwaysShowingScoutingReport = false;
		    this.m.TerrainTypeVisionMult = array(::Const.World.TerrainFoodConsumption.len(), 1.0);
		    __original();
	    }

        q.getTerrainTypeVisionMult <- function( _tileType )
	    {
		    return this.m.TerrainTypeVisionMult[_tileType];
	    }
    }

	//rig this to block desertion with unique follower effect
	q.checkDesertion = @(__original) function()
	{
        //Completely Blocks desertion
        if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Officer, ::PandorasHobby.Follower.Skill.Wardog_Desert) )
        {
            return;
        }

		__original();
	}	
});
