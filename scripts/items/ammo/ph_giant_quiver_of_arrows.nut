this.ph_giant_quiver_of_arrows <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.arrows";
		this.m.Name = "Giant Quiver of Arrows";
		this.m.Description = "A giant quiver of arrows, required to use bows of all kinds. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/ph_quiver_giant.png";
		this.m.IconEmpty = "ammo/ph_quiver_giant_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Arrows;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 1000;
		this.m.Ammo = 18;
		this.m.AmmoMax = 18;
		this.m.IsDroppedAsLoot = true;

		//HD -- weight
		if ( ::Hooks.hasMod("mod_hardened") )
		{
			this.m.AmmoWeight = 0.5;
		}
	}

	function getTooltip()
	{
		//HD pattern
		return this.ammo.getTooltip();
	}

});