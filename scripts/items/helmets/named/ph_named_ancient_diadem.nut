this.ph_named_ancient_diadem <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.ph_named_anient_diadem";
		this.m.Description = "A rather ostentatious piece of headgear once worn by an Ancient Priest.";
        this.m.PrefixList = ::Const.Strings.OldWeaponPrefix;
		this.m.NameList = [
			"Diadem",
            "Crown",
            "Coronet",
		];        
		this.m.ShowOnCharacter = true;
		this.m.HideHair = false;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;

        this.m.Variant = ::MSU.Array.rand([479, 480, 481]);		
		this.updateVariant();

		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 1500;
		this.m.Condition = 72;  //rolls up to 90
		this.m.ConditionMax = 72;
		this.m.StaminaModifier = -3;
		this.m.Vision = 0;
		this.randomizeValues();
	}

    function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "ph_bust_" + this.m.VariantString + "_" + variant;
		this.m.SpriteDamaged = "ph_bust_" + this.m.VariantString + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "ph_bust_" + this.m.VariantString + "_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/ph_inventory_" + this.m.VariantString + "_" + variant + ".png";
	}

    function createRandomName()
	{
		if (::Math.rand(1, 100) <= 60)
		{
            return ::MSU.Array.rand(::Const.Strings.OldWeaponPrefix) + " " + ::MSU.Array.rand(this.m.NameList);
		}
		else
		{
            return ::MSU.Array.rand(::Const.Strings.AncientDeadNames) + "\'s " + ::MSU.Array.rand(this.m.NameList);			
		}
	}
});

