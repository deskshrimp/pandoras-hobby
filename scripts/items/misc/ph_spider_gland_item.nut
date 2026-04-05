this.ph_spider_gland_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_spider_gland";
		this.m.Name = "Unusual Poison Gland";
		this.m.Description = "Research Note #2416G: The auxillary poison gland of a mutant Webknecht. This gland is unique in both color and poison. Why would a Webknecht require such potent venom? Perhaps its progeny one day cannibalize its own kin?";
		this.m.Icon = "misc/ph_inventory_champ_spider_gland.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1500;
	}
});