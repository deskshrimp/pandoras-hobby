this.ph_player_banner_light <- this.inherit("scripts/items/tools/player_banner", {
	m = {},
	function create()
	{
		this.player_banner.create();

		this.m.ID = "weapon.ph_player_banner_light";
		this.m.Name = "Light Battle Standard";
		this.m.Description = "A company standard to take into battle. Held high, allies will rally around it with renewed resolve, and enemies will know well who is about to crush them. On a smaller pole, less weaponized but more defensive.";
		this.m.Categories = "Spear, One-Handed";
		
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = null;//::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded | ::Const.Items.ItemType.Defensive;
		
		this.m.IsDoubleGrippable = false;
		this.m.RangeMin = 1;
		this.m.RangeMax = 1;
		this.m.RangeIdeal = 1;
				
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -12;		
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;

		this.m.ItemProperty = ::Const.Items.Property.PlayerBattleStandard;

		this.m.WeaponType = ::Const.Items.WeaponType.Spear;
		this.m.Reach = ::Reforged.Reach.WeaponTypeDefault.Spear;
	}

	function onEquip()
	{
		this.player_banner.onEquip();
		
		//remove the default skills and add our own (info wasn't updating properly otherwise)
		while(this.m.SkillPtrs.len() > 0)
		{
			this.removeSkill(this.m.SkillPtrs[this.m.SkillPtrs.len()-1]);
		}
		
		//give thrust more cost (the flag gets in the way)
        local thrust = ::new("scripts/skills/actives/thrust");
        thrust.m.ActionPointCost += 1;
		thrust.m.FatigueCost += 5;
        this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
	}

});