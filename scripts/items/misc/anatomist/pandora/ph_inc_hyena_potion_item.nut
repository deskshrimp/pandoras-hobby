this.ph_inc_hyena_potion_item <- this.inherit("scripts/items/misc/anatomist/pandora/ph_incomplete_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.ph_incomplete_anatomist_potion_item.create();
		this.m.ID = "misc.ph_inc_hyena_potion";
		this.m.Name = "Incomplete Bloodgate Brew";
		this.m.Icon = "misc/mod_ph/potion_30_inc.png";
	}
});

