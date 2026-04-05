this.ph_inc_honor_guard_potion_item <- this.inherit("scripts/items/misc/anatomist/pandora/ph_incomplete_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.ph_incomplete_anatomist_potion_item.create();
		this.m.ID = "misc.ph_inc_honor_guard_potion";
		this.m.Name = "Incomplete Elixir of Boneflesh";
		this.m.Icon = "misc/mod_ph/potion_19_inc.png";
	}
});

