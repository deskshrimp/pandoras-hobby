this.ph_reinforced_throwing_net_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_reinforced_throwing_net";
		this.m.PreviewCraftable = this.new("scripts/items/tools/reinforced_throwing_net");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_broken_net",
				Num = 2
			},
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/reinforced_throwing_net"));
	}
});

