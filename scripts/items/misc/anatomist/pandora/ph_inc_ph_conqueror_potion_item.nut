this.ph_inc_ph_conqueror_potion_item <- this.inherit("scripts/items/misc/anatomist/pandora/ph_incomplete_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.ph_incomplete_anatomist_potion_item.create();
		this.m.ID = "misc.ph_inc_ph_conqueror_potion";
		this.m.Name = "Incomplete Skulltaker\'s Essence";
		this.m.Icon = "misc/mod_ph/ph_potion_conq_inc.png";
	}
});

