::PandorasHobby.MH.hook("scripts/events/events/wound_gets_infected_event", function(q) {
    
    //HD Hardened already hooks this, so we need to modify their content indirectly
    //We can do this via the onClear method that is called before the score update
    
    if ( ::Hooks.hasMod("mod_hardened") )
    {
        q.m.PH_BaseScorePerInjury <- q.m.ScorePerInjury;
    }

    q.onClear  = @(__original) function(){
        __original();

        if (! ::Hooks.hasMod("mod_hardened") )
        {
            return;
        }
        
        if( ! ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Less_Infection) )
        {
            this.m.ScorePerInjury = this.m.PH_BaseScorePerInjury;
            return;
        }

        if( ::World.Assets.getMedicine() != 0 )
        {
            if(::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Healer).getAge() == ::PandorasHobby.Follower.Age.Adult)
            {
                this.m.ScorePerInjury = 3;
            }
            else if(::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Healer).getAge() == ::PandorasHobby.Follower.Age.Old)
            {
                this.m.ScorePerInjury = 1;
            }
        }
        else
        {
            if(::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Healer).getAge() == ::PandorasHobby.Follower.Age.Adult)
            {
                this.m.ScorePerInjury = 4;
            }
            else if(::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Healer).getAge() == ::PandorasHobby.Follower.Age.Old)
            {
                this.m.ScorePerInjury = 3;
            }
        }
    }

    q.onUpdateScore = @(__original) function() {

        __original();
        
        if ( ::Hooks.hasMod("mod_hardened") )
        {
            return;
        }

        //without Hardened changes we need to modify the score directly ourselves
        //heavily increase infection chance without medicine!
        if (::World.Assets.getMedicine() == 0)
		{
			this.m.Score *= 3.0;
		}

        //now apply the reductions from the Doctor follower
        if(::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Healer).getAge() == ::PandorasHobby.Follower.Age.Adult)
        {
            this.m.Score *= 0.5;
        }
        else if(::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Healer).getAge() == ::PandorasHobby.Follower.Age.Old)
        {
            this.m.Score *= 0.3;
        }
    }
});