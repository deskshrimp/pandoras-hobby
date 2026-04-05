::PandorasHobby.MH.hook("scripts/entity/tactical/actor", function(q) {

    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            //Apotheosis only drops from champions!
            if(this.m.IsMiniboss)
            {
                //::logInfo("PANDORA > Actor -> drop apotheosis or generic?");

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    if(::Math.rand(0,100) < 10)
                    {
                        ret.push(::new("scripts/items/misc/anatomist/apotheosis_potion_item"));
                    }
                    else if(::Math.rand(0,100) < 6) //~5.4% chance really, given the 90% fail rate of teh first check
                    {
                        ret.push(::new("scripts/items/misc/anatomist/ph_generic_sample_item"));
                    }
                }
            }
        }

        return ret;
    }

    q.PH_AttemptIncompletePotionDrop <- function(_loot, _pot, _oddsDropMult)
    {
        //_potName is just the monster: e.g. "alp"
        
        local flagName = "PH_TotalIncDrop_" + _pot;

        local numDropped = ::World.Statistics.getFlags().getAsInt(flagName);
        local odds = ::Math.max(10, 100 - numDropped * _oddsDropMult);

        if(::Math.rand(0,100) < odds)
        {
            ::World.Statistics.getFlags().increment(flagName);

            _loot.push(::new("scripts/items/misc/anatomist/pandora/ph_inc_" + _pot + "_potion_item"));

            return true;
        }

        return false;
    }
});