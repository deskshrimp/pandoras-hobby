this.ph_personalized_item <- this.inherit("scripts/items/item", {
	m = {
        BrothersName = "Nobody"
    },
	function create()
	{
		this.item.create();
		this.m.ID = "";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Loot | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1;

        this.m.Variant = ::Math.rand(0,100);

		this.m.MagicNumber = 99;
	}

    function setBrothersName(_name)
    {
        this.m.BrothersName = _name;
    }

    function getName()
	{
        return this.m.BrothersName + "\'s " + this.m.Name;
	}

	//rig the magic number to prevent alchemist from saving it!
	function setMagicNumber( _m )
	{
		this.m.MagicNumber = 99;
	}
    
    function onSerialize( _out )
	{	
		this.item.onSerialize(_out);	
        _out.writeString(this.m.BrothersName);		
	}

	function onDeserialize( _in )
	{	
		this.item.onDeserialize( _in );
        this.m.BrothersName = _in.readString();
		this.updateVariant();
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});

