this.ph_warwolf_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_warwolf_01";
		this.m.PreviewCraftable = this.new("scripts/items/accessory/wolf_item");
		this.m.Cost = 200;
		local ingredients = [
			{
				Script = "scripts/items/accessory/wardog_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/growth_pearls_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/wolf_item"));
	}
});

