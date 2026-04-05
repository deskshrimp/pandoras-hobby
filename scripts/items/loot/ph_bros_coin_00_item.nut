this.ph_bros_coin_00_item <- this.inherit("scripts/items/ph_personalized_item", {
	m = {},
	function create()
	{
		this.ph_personalized_item.create();
		this.m.ID = "loot.ph_bros_coin_00";
		this.m.Name = "Contract";
        this.m.BrothersName = "Nobody";
		this.m.Description = "A mercenary's contract.. freshly signed..";
		this.m.Icon = "loot/ph_bro_contract.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1;
        
        this.m.Variant = ::Math.rand(0,100);
	}

	function getName()
	{
        return this.m.BrothersName + "\'s " + this.m.Name;
	}

	function updateVariant()
	{
		if (this.m.Variant < 20)
        {
            this.m.Description = "Barely knew " + this.m.BrothersName + ".";
        }
        else if (this.m.Variant < 40)
        {
            this.m.Description = this.m.BrothersName + " wasn't with the company very long.";
        }
        else if (this.m.Variant < 60)
        {
            this.m.Description = this.m.BrothersName + " just wasn't cut out for mercenary life.";
        }
		else if (this.m.Variant < 60){
			this.m.Description = this.m.BrothersName + "'s contract.. the ink's still wet..";
		}
		else
		{        
        	this.m.Description = this.m.BrothersName + " kept a copy of his contract in his pocket. Guess he had to remind himself why he here.";
		}
	} 
});

