this.ph_bros_coin_01_item <- this.inherit("scripts/items/ph_personalized_item", {
	m = {},
	function create()
	{
		this.ph_personalized_item.create();
		this.m.ID = "loot.ph_bros_coin_01";
		this.m.Name = "(Un)Lucky Copper";
        this.m.BrothersName = "Nobody";
		this.m.Description = "A single copper coin.";
		this.m.Icon = "loot/ph_coin_copper.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 10;
        
        this.m.Variant = ::Math.rand(0,100);
	}

	function getName()
	{
        return this.m.BrothersName + "\'s " + this.m.Name;
	}

	function updateVariant()
	{
		if (this.m.Variant < 25)
        {
            this.m.Description = "The first copper " + this.m.BrothersName + " earned as a mercenary.";
        }
        else if (this.m.Variant < 50)
        {
            this.m.Description = this.m.BrothersName + " was given this coin by his parents when he left home.";
        }
        else if (this.m.Variant < 75)
        {
            this.m.Description = this.m.BrothersName + " always kept this coin in his left boot. Fark knows how he walked on it.";
        }
		else
		{        
        	this.m.Description = "A single copper that was found next to " + this.m.BrothersName + "\'s body after the battle.";
		}
	}
});

