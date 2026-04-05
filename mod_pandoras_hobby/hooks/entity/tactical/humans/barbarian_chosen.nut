::PandorasHobby.MH.hook("scripts/entity/tactical/humans/barbarian_chosen", function(q) {
    // This is the Barbarian King
    
    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            //Barb potion only drops from champions!
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/special/ph_barb_king_potion_item"));
            }
        }

        return ret;
    }
});
