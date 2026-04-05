::PandorasHobby.MH.hook("scripts/crafting/blueprints/fermented_unhold_heart_blueprint", function(q) {

    q.create = @(__original) function()
    {
        __original();
        this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Food;
    }
});