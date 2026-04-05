this.ph_hyena_gland_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_hyena_gland";
		this.m.Name = "Hyenal Gland";
		this.m.Description = "";
		this.m.Icon = "misc/ph_hyena_gland.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1500;
	}

	function updateVariant()
	{
		if (this.m.Variant < 100)
        {
            this.m.Description = "Research Note #1992-W: The enlarged & discolored adrenal gland of a particularly terrible direwolf specimen. If one could reduce the size of these glands, perhaps a less irascible direwolf might be created?";
        }
		else
		{
			this.m.Description = "Research Note #1992-H: The presumed adrenal gland of a southern hyena that bares a remarkable sembalace to that of the northen direwolf. Are these species perhaps realted? Was there once a terrible dire-hyena-wolf that sired them both?";
		}		
	}
});

