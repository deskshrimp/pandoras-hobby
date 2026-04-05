this.ph_bros_coin_02_item <- this.inherit("scripts/items/ph_personalized_item", {
	m = {},
	function create()
	{
		this.ph_personalized_item.create();
		this.m.ID = "loot.ph_bros_coin_02";
		this.m.Name = "Lucky Silver";
        this.m.BrothersName = "Nobody";
		this.m.Description = "A single silver coin.";
		this.m.Icon = "loot/ph_coin_silver.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 50;
        
        this.m.Variant = ::Math.rand(0,100);
	}

	function updateVariant()
	{
		if (this.m.Variant < 50)
        {
            this.m.Description = this.m.BrothersName + " was going to give it to his first born.. Now he never will.";
        }
		else
		{
			this.m.Description = "A fortune teller once told " + this.m.BrothersName + " to always keep it with him. Not sure it helped.";
		}
	}
});