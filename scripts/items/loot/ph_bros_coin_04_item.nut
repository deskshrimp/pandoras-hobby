this.ph_bros_coin_04_item <- this.inherit("scripts/items/ph_personalized_item", {
	m = {},
	function create()
	{
		this.ph_personalized_item.create();
		this.m.ID = "loot.ph_bros_coin_04";
		this.m.Name = "Favorite Spoon";
        this.m.BrothersName = "Nobody";
		this.m.Description = "A large bent silver spoon.";
		this.m.Icon = "loot/ph_bro_spoon.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 250;
        
        this.m.Variant = ::Math.rand(0,100);
	}

	function updateVariant()
	{
        if (this.m.Variant < 20)
        {
            this.m.Description = this.m.BrothersName + " ate everything with a spoon. Even dirt. He was a good brother.";
        }
        else if (this.m.Variant < 50)
        {
            this.m.Description = "We still put it next to the fire when we stop to eat. " + this.m.BrothersName + " always liked when we stopped to eat.";
        }
		else
		{
        	this.m.Description = "It's all we've got left of " + this.m.BrothersName + ".. this and the memories.";
		}
	}
});

