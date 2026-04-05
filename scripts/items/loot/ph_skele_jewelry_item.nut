this.ph_skele_jewelry_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "loot.ph_skele_jewelry";
		this.m.Name = "Ruined Ancient Jewelry";
		this.m.Description = "Research Note #509: By all appearances the ancients possessed an abundance of jewelry. A great deal of their society must have necessarily been focused on its manufacture. For near every ancient corpse is draped in some finery or another. With such obsessions did they neglect to provide for the regular obligations and necessities of life? Is this the hubris that felled their empire?";
		this.m.Icon = "loot/ph_skele_jewelry.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 500;

		this.m.MagicNumber = 99;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * 1.5 * this.World.State.getCurrentTown().getBuyPriceMult()));
		}
		else
		{
			return this.Math.ceil(this.getValue());
		}
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseLootSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue());
		}
	}

	//rig the magic number to prevent alchemist from saving it!
	function setMagicNumber( _m )
	{
		this.m.MagicNumber = 99;
	}
});