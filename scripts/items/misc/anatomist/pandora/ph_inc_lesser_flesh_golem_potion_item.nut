this.ph_inc_lesser_flesh_golem_potion_item <- this.inherit("scripts/items/misc/anatomist/pandora/ph_incomplete_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.ph_incomplete_anatomist_potion_item.create();
		this.m.ID = "misc.ph_inc_lesser_flesh_golem_potion";
		this.m.Name = "Incomplete Potion of Change";
		this.m.Icon = "misc/mod_ph/potion_42_inc.png";
	}
});

