this.ph_throwing_net_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_throwing_net";
		this.m.PreviewCraftable = this.new("scripts/items/tools/throwing_net");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_broken_net",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/throwing_net"));
	}
});

