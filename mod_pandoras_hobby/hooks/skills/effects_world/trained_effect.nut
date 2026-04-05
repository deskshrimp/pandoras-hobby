::PandorasHobby.MH.hook("scripts/skills/effects_world/trained_effect", function(q) {
    
    //Trained buff doesn't actualy call this at all, so we can use it
    //this effect doesn't exist outside of training in town (and a single event)

    q.onAdded= @(__original) function()
	{
		__original();
        ::World.Statistics.getFlags().increment("PH_MenTrained");
	}
});