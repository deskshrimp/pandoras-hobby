::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/schrat", function(q) {

    //not a champion
    //would need to modify the entire inner-workings to preserve its status as its size changed OR lock it at size 3 as a sort of sand unhold until it died
    //instead just give it a small chance to drop the incomplete anatomist pot
    
    //only the base class needs to handle the extra drops        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

        if(::Math.rand(0,100) < 5)
        {
            ret.push(::new("scripts/items/misc/ph_sand_jar_item"));
        }

		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
        {
            if(::Math.rand(0,100) < 5)
            {
                this.PH_AttemptIncompletePotionDrop( ret, "ifrit", ::Const.Items.PH_ReducedPotionDropRate );                
            }
        }

		return ret;
    }
});