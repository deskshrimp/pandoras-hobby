this.ph_wurm_scales_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_wurm_scales";
		this.m.Name = "Golden Scales";
		this.m.Description = "Research Note #2901: I hypothesize, that with a sufficient application of alkali, the soft tissues of the rather vexing creature known as the lindwurm may be preserved for further study. Mayhaps, one day, we will have the ability to render fighting men and their arms immune to the foul acidic blood.";
		this.m.Icon = "misc/ph_lindwurm_champ.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});