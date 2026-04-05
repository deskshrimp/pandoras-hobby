::PandorasHobby.MH.hook("scripts/events/events/dlc6/cultish_arrangement_event", function(q) {
    
    q.onUpdateScore = @(__original) function()
    {
        __original();

        //has a fixed score of 5 on success
        if(this.m.Score > 0)
        {   
            //Spook boosts the score
            if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist) )
            {
                this.m.Score += 5;
            }

            //also boost using the level of the chosen cultist
            if(this.m.Cultist != null)
            {
                this.m.Score += this.m.Cultist.getLevel();
            }
        }
    }
});