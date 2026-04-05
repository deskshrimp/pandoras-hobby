::PandorasHobby.MH.hook("scripts/crafting/blueprints/poisoned_oil_blueprint", function(q) {
	q.create = @(__original) function()
    {
        __original();
        this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
    }
});
