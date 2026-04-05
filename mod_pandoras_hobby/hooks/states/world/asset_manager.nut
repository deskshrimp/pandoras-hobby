::PandorasHobby.MH.hook("scripts/states/world/asset_manager", function(q) {

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
