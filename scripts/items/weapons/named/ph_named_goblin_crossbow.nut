this.ph_named_goblin_crossbow <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		IsLoaded = true
	},
	function isLoaded()
	{
		return this.m.IsLoaded;
	}

	function setLoaded( _l )
	{
		this.m.IsLoaded = _l;
	}

	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ID = "weapon.ph_named_goblin_crossbow";
		this.m.NameList = ::Const.Strings.CrossbowNames;
		this.m.UseRandomName = false;
		this.m.Description = "A large and heavy crossbow with menacing spikes in front. More like a minitature ballista, it shoots stakes with enough force to knock back a target hit.";
		this.m.Categories = "Bow, Two-Handed";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Defensive;
		this.m.EquipSound = ::Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5000;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.RangeMin = 1;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
        this.m.StaminaModifier = -10;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.5;        
		this.randomizeValues();

        this.m.WeaponType = ::Const.Items.WeaponType.Crossbow;

        //RF
        this.m.Reach = 0;

        //HD
        this.m.FatigueOnSkillUse = 2;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/ranged/ph_named_crossbow_goblin_01.png";
		this.m.Icon = "weapons/ranged/ph_named_crossbow_goblin_01_70x70.png";

		this.m.ArmamentIcon = "icon_goblin_crossbow_01";
	}

	function getAmmoID()
	{
		return "ammo.bolts";
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shoot_stake"));

        //RF - Always add reload skill to DummyPlayer so that it appears in nested tooltips of weapons
		if (!this.m.IsLoaded || ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			local reload = ::Reforged.new("scripts/skills/actives/reload_bolt");
			this.addSkill(reload);
		}
	}

	function onCombatFinished()
	{
		this.named_weapon.onCombatFinished();
		this.m.IsLoaded = true;
	}

    function getTooltip()
	{
		local result = this.weapon.getTooltip();

		if (!this.m.IsLoaded)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		return result;
	}
});

