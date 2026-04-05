this.ph_broken_net <- this.inherit("scripts/items/item", {
	m = 
	{
		IsToothed = false,
		IsReinforced = false,		
	},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.ph_broken_net";
		this.m.Name = "Broken Net";
		this.m.Description = "A broken net. Can be fixed or scrapped.";
		this.m.Icon = "misc/ph_broken_net.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1;
	}

	function setToothed( _r )
	{
		this.m.IsToothed = _r;
	}

	function isToothed()
	{
		return this.m.IsToothed;
	}

	function setReinforced( _r )
	{
		this.m.IsReinforced = _r;
	}

	function isReinforced()
	{
		return this.m.IsReinforced;
	}

	function isBasic()
	{
		return !this.m.IsToothed && !this.m.IsReinforced;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}
});

