this.ph_davkuls_favor <- this.inherit("scripts/items/ph_personalized_item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "loot.ph_davkuls_favor";
		this.m.Name = "Davkul's Favor";
        this.m.BrothersName = "Nobody";
		this.m.Description = "What the fark?";
		this.m.Icon = "loot/ph_davkuls_favor.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2500;
        
        this.m.Variant = 0;

		this.m.MagicNumber = 99;
	}

    function updateVariant()
	{
		if(this.m.Variant > 100)
		{
			//from the sacrifice event
			this.m.Description = this.m.BrothersName + " was strong with Davkul. This terrible gift from Davkul must be used in accordance with his will."
		}
		else
		{		
			//from a regular death
			this.m.Description = "It was found on " + this.m.BrothersName + "'s withered body after he fell in battle. His bloody death was Davkul's will. Another will be his chosen."
		}
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
    
	//rig the magic number to prevent alchemist from saving it!
	function setMagicNumber( _m )
	{
		this.m.MagicNumber = 99;
	}
});

