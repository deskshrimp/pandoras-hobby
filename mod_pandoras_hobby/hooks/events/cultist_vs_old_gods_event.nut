::PandorasHobby.MH.hook("scripts/events/events/cultist_vs_old_gods_event", function(q) {
    
    q.onUpdateScore = @(__original) function()
    {
        __original();

        if(this.m.Score > 0)
        {   
            //Spook boosts the score
            if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist) )
            {
                this.m.Score += 5;
            }            
        }
    }
});