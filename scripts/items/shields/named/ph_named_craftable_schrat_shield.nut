this.ph_named_craftable_schrat_shield <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {},
	function create()
	{
		this.named_shield.create();
		this.m.Variant = 8;
		this.updateVariant();
		this.m.ID = "shield.ph_named_craftable_schrat";
		this.m.NameList = this.Const.Strings.ShieldNames;
        this.m.PrefixList = ["Living", "Ever-growing", "Woody", "Schrat"];
        this.m.UseRandomName = false;
		this.m.Description = "A schrat shield that has been fed some sprouts to grow. It's hideous, but it sort of grows on you.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Value = 3000;
		this.m.MeleeDefense = 25;	//HD defense values
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = -13;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_named_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_named_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_named_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/ph_inventory_named_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/ph_icon_named_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.named_shield.onEquip();
		//Removed for HD
		//this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

    function getTooltip()
	{
		local result = this.shield.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Regenerates itself by [color=" + this.Const.UI.Color.PositiveValue + "]20[/color] points of durability each turn."
		});
		return result;
	}

    function onTurnStart()
	{
		this.m.Condition = this.Math.min(this.m.ConditionMax, this.m.Condition + 20);
		this.updateAppearance();
	}

	function onCombatFinished()
	{
		this.m.Condition = this.m.ConditionMax;
		this.updateAppearance();
	}

});

