this.ph_incomplete_anatomist_potion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = false;
		this.m.IsSellable = true;
        this.m.Description = "This incomplete concoction presents the possibility of future miracles that continue the expansion of the horizon of scientific achievement.";
		this.m.IconLarge = "";		
		this.m.Value = 250;

		this.m.MagicNumber = 99;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	//rig the magic number to prevent alchemist from saving it!
	function setMagicNumber( _m )
	{
		this.m.MagicNumber = 99;
	}
});

