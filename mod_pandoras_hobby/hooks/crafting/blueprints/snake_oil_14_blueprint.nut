::PandorasHobby.MH.hook("scripts/crafting/blueprints/snake_oil_14_blueprint", function(q) {
    q.onCraft = @(__original) function( _stash )
    {
        __original( _stash );

        if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_2x) )
        {
            if(::Math.rand(0,100) < 10)
            {
                __original( _stash );
            }
        }
    }

    q.create = @(__original) function()
    {
        __original();
        this.m.PH_Type = ::PandorasHobby.Blueprint.Type.SnakeOil;
    }
});
