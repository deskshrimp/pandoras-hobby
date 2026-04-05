this.ph_giant_powder_bag <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.powder";
		this.m.Name = "Giant Powder Bag";
		this.m.Description = "A giant bag of black powder, used for arming exotic firearms. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/ph_powder_bag_giant.png";
		this.m.IconEmpty = "ammo/ph_powder_bag_giant_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Powder;
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 1000;
		this.m.Ammo = 9;
		this.m.AmmoMax = 9;
		this.m.IsDroppedAsLoot = true;

		//HD -- weight
		if ( ::Hooks.hasMod("mod_hardened") )
		{
			this.m.AmmoWeight = 0.7;
		}
	}

	function getTooltip()
	{
		//HD pattern
		return this.ammo.getTooltip();
	}

});