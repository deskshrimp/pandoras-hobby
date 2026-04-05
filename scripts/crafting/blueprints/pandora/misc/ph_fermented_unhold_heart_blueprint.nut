this.ph_fermented_unhold_heart_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_fermented_unhold_heart";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Food;
		this.m.PreviewCraftable = this.new("scripts/items/supplies/fermented_unhold_heart_item");
		this.m.Cost = 40;
		local ingredients = [
			{
				Script = "scripts/items/supplies/mead_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_heart_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
        _stash.add(::new("scripts/items/supplies/fermented_unhold_heart_item"));
	}

});

