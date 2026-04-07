this.ph_unhold_bones_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_unhold_bones";
		this.m.Name = "Behemoth Bones";
		this.m.Description = "Research Note #61U -- phalic doodles have been scribbled in the margins: Disregard the churlish marginalia; idle mercenaries have no respect for science. These remarkable bones are both larger and sturdier than \'common\' giant's bones. Thes giants must consume an inordinate quantity of bones.";
		this.m.Icon = "misc/ph_champ_unhold_bones.png";
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