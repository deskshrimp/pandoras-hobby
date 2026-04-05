this.ph_named_armor_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {
		PrefixList = ::Const.Strings.RandomArmorPrefix,
		SuffixList = [],
		NameList = [],
		CreatureNames = [],
		UseRandomName = true,

        SpecialModifier = 0,

		ConditionRollMin = 110,
		ConditionRollMax = 125,
		SpecialRollMin = 110,
		SpecialRollMax = 125,
	},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Named;
        this.m.IsDroppedAsLoot = true;
	}

	function createRandomName()
	{
		if (!this.m.UseRandomName || this.Math.rand(1, 100) <= 35)
		{
			if (this.m.SuffixList.len() == 0 || this.Math.rand(1, 100) <= 80)
			{
				return ::MSU.Array.rand(this.m.PrefixList) + " " + ::MSU.Array.rand(this.m.NameList);
			}
			else
			{
				return ::MSU.Array.rand(this.m.NameList) + " " + ::MSU.Array.rand(this.m.SuffixList);
			}
		}
		else if (this.m.CreatureNames.len() > 0 && this.Math.rand(1, 100) <= 50)
		{
			return ::MSU.Array.rand(this.m.CreatureNames) + "\'s " + ::MSU.Array.rand(this.m.NameList);
		}
		else if (this.Math.rand(1, 100) <= 50)
		{
			return ::MSU.Array.rand(::Const.Strings.KnightNames) + "\'s " + ::MSU.Array.rand(this.m.NameList);
		}
		else
		{
			return ::MSU.Array.rand(::Const.Strings.BanditLeaderNames) + "\'s " + ::MSU.Array.rand(this.m.NameList);
		}
	}

	function setName( _name )
	{
		this.m.Name = _name;
	}

	function randomizeValues ()
	{
		if (this.m.Name.len() == 0)
		{
			this.setName(this.createRandomName());
		}

		if(this.m.StaminaModifier != 0) this.m.StaminaModifier = ::Math.max( 0, this.m.StaminaModifier - ::Math.rand(0, 2) );
		if(this.m.ConditionModifier != 0) this.m.ConditionModifier = ::Math.floor( this.m.ConditionModifier * ::Math.rand(this.m.ConditionRollMin, this.m.ConditionRollMax) * 0.01 ) * 1.0;
		if(this.m.SpecialModifier != 0) this.m.SpecialModifier = ::Math.floor( this.m.SpecialModifier * ::Math.rand(this.m.SpecialRollMin, this.m.SpecialRollMax) * 0.01 ) * 1.0;
	}

    function onAdded()
	{		
		this.armor_upgrade.onAdded();
	}

	function onRemoved()
	{		
		this.armor_upgrade.onRemoved();
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);        
		_out.writeF32(this.m.ConditionModifier);
        _out.writeF32(this.m.SpecialModifier);
		_out.writeI8(this.m.StaminaModifier);

		this.armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionModifier = _in.readF32();
        this.m.SpecialModifier  = _in.readF32();
		this.m.StaminaModifier = _in.readI8();

		this.armor_upgrade.onDeserialize(_in);		
	}

});

