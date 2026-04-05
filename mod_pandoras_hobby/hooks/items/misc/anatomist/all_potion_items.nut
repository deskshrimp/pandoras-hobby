// ********** Must add check for every potion onUse() to prevent duplicate potion use!! ***********************
//the original onUse methods always return true, so our logic here is all that matters!

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/alp_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.alp_potion") ) return false;

        return __original(_actor, _item);
    }
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/ancient_priest_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.ancient_priest_potion") ) return false;
        return __original(_actor, _item);
    }
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/direwolf_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.direwolf_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/fallen_hero_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.fallen_hero_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/geist_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.geist_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/goblin_grunt_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.goblin_grunt_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/goblin_overseer_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.goblin_overseer_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/goblin_shaman_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.goblin_shaman_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/grand_diviner_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        //also barb does not approve
        if( _actor.getSkills().hasSkill("effects.ph_barb_king_potion") ) return false;

        if( _actor.getSkills().hasSkill("effects.grand_diviner_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/greater_flesh_golem_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.greater_flesh_golem_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/hexe_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.hexe_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/honor_guard_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.honor_guard_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/hyena_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.hyena_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/ifrit_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.ifrit_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/ijirok_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.ijirok_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/kraken_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.kraken_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/lesser_flesh_golem_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.lesser_flesh_golem_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/lindwurm_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.lindwurm_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/lorekeeper_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.lorekeeper_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/nachzehrer_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.nachzehrer_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/necromancer_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.necromancer_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/necrosavant_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.necrosavant_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/orc_berserker_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.orc_berserker_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/orc_warlord_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.orc_warlord_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/orc_warrior_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.orc_warrior_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/orc_young_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.orc_young_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/rachegeist_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.rachegeist_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/schrat_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.schrat_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/serpent_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.serpent_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/skeleton_warrior_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.skeleton_warrior_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/unhold_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.unhold_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/webknecht_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.webknecht_potion") ) return false;
        return __original(_actor, _item);
    }
    
});

::PandorasHobby.MH.hook("scripts/items/misc/anatomist/wiederganger_potion_item", function(q) {
    q.onUse = @(__original) function( _actor, _item = null )
    {
        if( _actor.getSkills().hasSkill("effects.wiederganger_potion") ) return false;
        return __original(_actor, _item);
    }
    
});