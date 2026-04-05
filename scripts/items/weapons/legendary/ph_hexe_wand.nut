this.ph_hexe_wand <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ph_hexe_wand";
		this.m.Name = "Hexe Wand";
		this.m.Description = "A macabre amalgamation of \'magic\' objects and ancient scribbles. While lacking as a bludgeon, one does witness strange events on the battlefield when wielding it.";
		this.m.Categories = "Mace, One-Handed";
		this.m.IconLarge = "weapons/melee/ph_hexe_wand.png";
		this.m.Icon = "weapons/melee/ph_hexe_wand_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;;
        this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;		
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ph_icon_hexe_wand";
		this.m.Value = 5000;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.4;

		this.m.WeaponType = ::Const.Items.WeaponType.Mace;

        this.m.Reach = 3; //::Reforged.Reach.WeaponTypeDefault.Mace;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ph_magic_bonk"));
		this.addSkill(this.new("scripts/skills/actives/knock_out"));
	}
});
