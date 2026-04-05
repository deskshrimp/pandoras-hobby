this.ph_skele_sternum_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_skele_sternum";
		this.m.Name = "Ancient Sternum with Ribs";
		this.m.Description = "Research Note #2766: The Ancient Dead lack flesh to wound. Strikes that should pierce them find no flesh to bite and are turned aside by their unnaturally sturdy bones. A man with such ribs would alas still bleed, however, this inner armor would still as such protect and limit mortal wounds to his most vital organs.";
		this.m.Icon = "misc/ph_skele_sternum.png";
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1800;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});