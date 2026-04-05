this.ph_research_sample_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 0;

		this.m.IsChangeableInBattle = true; //part of the droppable loot check in Human.onDeath->getDroppableItems

		//let the alchemist try to save them (we could always lower the odds by making it roll twice to succeed?)
        //this.m.MagicNumber = 99;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/cleave_hit_hitpoints_01.wav", this.Const.Sound.Volume.Inventory);
		//this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

    function getSellPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	/*
    //rig the magic number to prevent alchemist from saving it!
	function setMagicNumber( _m )
	{
		this.m.MagicNumber = 99;
	}
	*/
});