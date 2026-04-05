::PandorasHobby.MH.hook("scripts/entity/world/settlement_modifiers", function(q) {
    q.reset = @(__original) function () {
        __original();

        //trade gives 10%
        if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Agent, ::PandorasHobby.Follower.Skill.Trader_Shop) || ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Agent, ::PandorasHobby.Follower.Skill.Porter_Rarity) )
        {
            this.RarityMult *= ::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Agent).onGetShopRarityMult();
        }      
    }
});