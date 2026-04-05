this.ph_zombie_blood_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_zombie_blood";
		this.m.Name = "Flesh of the Fallen";
		this.m.Description = "Research Note #341 - hastily scribbled in a margin: A simultaneously grotesque and rather disappointing sample. This lump of necrotized flesh and congealed blood is nearly devoid of scientific intrigue.";
		this.m.Icon = "misc/ph_zombie_flesh.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}
});