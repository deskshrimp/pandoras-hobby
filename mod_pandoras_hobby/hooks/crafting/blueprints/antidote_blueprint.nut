::PandorasHobby.MH.hook("scripts/crafting/blueprints/antidote_blueprint", function(q) {
	q.create = @(__original) function()
    {
        __original();
        this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
    }
});
