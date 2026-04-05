this.ph_inc_ijirok_potion_item <- this.inherit("scripts/items/misc/anatomist/pandora/ph_incomplete_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.ph_incomplete_anatomist_potion_item.create();
		this.m.ID = "misc.ph_inc_ijirok_potion";
		this.m.Name = "Incomplete Elixir of the Mad God";
		this.m.Icon = "misc/mod_ph/potion_37_inc.png";
	}
});

