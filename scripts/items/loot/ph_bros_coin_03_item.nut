this.ph_bros_coin_03_item <- this.inherit("scripts/items/ph_personalized_item", {
	m = {},
	function create()
	{
		this.ph_personalized_item.create();
		this.m.ID = "loot.ph_bros_coin_03";
		this.m.Name = "Gold Coin";
        this.m.BrothersName = "Nobody";
		this.m.Description = "A single gold coin.";
		this.m.Icon = "loot/ph_coin_gold.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 200;
        
        this.m.Variant = ::Math.rand(0,100);
	}

    function updateVariant()
	{
		//handle extra class flags first!
        if (this.m.Variant >= 4000)
        {
            //Hedge Knight background
            this.m.Description = this.m.BrothersName + " said it was the last coin he won in a tourney. Still dreamed of he old life. He did."
        }
        else if (this.m.Variant >= 3000)
        {
            //Thief background
            this.m.Description = this.m.BrothersName + " said he found it layin on the ground. Someone musta had a hole in his pocket. Cheeky bastard."
        }
        else if (this.m.Variant >= 2000)
        {
            //Gambler Background
            this.m.Description = "Said he won in a game of cards. Reckon he cheated. " + this.m.BrothersName + " was a good cheater."
        }
        else if (this.m.Variant >= 1000)
        {
            //Arena Fighter trait of some level
            this.m.Description = this.m.BrothersName + " won it in the arena. Damn proud of it he was."
        }
        else
        {
            //go with a normal story
            this.m.Description = "It took " + this.m.BrothersName + " months to save up the crowns for this.. Dammit.";
        }
	}
});

