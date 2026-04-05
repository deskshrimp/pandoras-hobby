this.ph_named_craftable_lindwurm_shield <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {},
	function create()
	{
		this.named_shield.create();
		this.m.Variant = 7;
		this.updateVariant();
		this.m.ID = "shield.ph_named_craftable_lindwurm";
		this.m.NameList = this.Const.Strings.ShieldNames;
        this.m.PrefixList = ["Golden", "Lindwurm", "Scaly", "Wurm"];
        this.m.UseRandomName = false;
		this.m.Description = "This sturdy shield fashioned from the shimmering golden scales of a Lindwurm champion makes for protection nigh indestructible.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Value = 2500;
		this.m.MeleeDefense = 20;	//HD defense values
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = -15;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
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
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}
});

