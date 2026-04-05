::PandorasHobby.MH.hook("scripts/items/accessory/wolf_item", function(q) {    
    q.create = @(__original) function(){
        __original();

        //original variant code is messed up! (there are only 2 variants, not 4, and the #s are reversed on the brushes)
        this.m.Variant = ::Math.rand(0, 100) < 50 ? 1 : 2;
		this.updateVariant();
    }

    q.setEntity = @() function( _e ){
        this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/dog_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/wolf_0" + this.m.Variant + "_70x70.png";
		}
    }
});