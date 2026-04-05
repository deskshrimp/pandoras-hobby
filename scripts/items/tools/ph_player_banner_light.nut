this.ph_player_banner_light <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ph_player_banner_light";
		this.m.Name = "Light Battle Standard";
		this.m.Description = "A company standard to take into battle. Held high, allies will rally around it with renewed resolve, and enemies will know well who is about to crush them. On a smaller pole, less weaponized but more defensive.";
		this.m.Categories = "Spear, One-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;		
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Defensive;
		this.m.IsDoubleGrippable = false;
		this.m.IsDroppedAsLoot = true;
		this.m.IsIndestructible = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = false;
		this.m.ArmamentIcon = "";
		this.m.Value = 1500;
		this.m.IsPrecious = true;
		this.m.ShieldDamage = 0;
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

		this.m.Variant = 5;
		this.updateVariant();
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.IconLarge = "weapons/banner/banner_" + variant + ".png";
		this.m.Icon = "weapons/banner/banner_" + variant + "_70x70.png";
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Allies at a range of 4 tiles or less receive [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of the Resolve of the character holding this standard as a bonus, up to a maximum of the standard bearer\'s Resolve."
		});
		return result;
	}

	function getBuyPrice()
	{
		return 1000000;
	}

	function onEquip()
	{
		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return;
		}

		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;

		if (actor.hasSprite("background"))
		{
			actor.getSprite("background").setBrush("player_banner_" + variant);
		}

		if (actor.hasSprite("shaft"))
		{
			actor.getSprite("shaft").setBrush("player_banner_" + variant + "_shaft");
		}

		actor.setDirty(true);
		this.weapon.onEquip();
		
		//give thrust more cost (the flag gets in the way)
        local thrust = ::new("scripts/skills/actives/thrust");
        thrust.m.ActionPointCost += 1;
		thrust.m.FatigueCost += 5;
        this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
	}

	function onUnequip()
	{
		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return;
		}

		if (actor.hasSprite("background"))
		{
			actor.getSprite("background").resetBrush();
		}

		if (actor.hasSprite("shaft"))
		{
			actor.getSprite("shaft").resetBrush();
		}

		actor.setDirty(true);
		this.weapon.onUnequip();
	}

	function onMovementFinished()
	{
		local actor = this.getContainer().getActor();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());

		foreach( ally in allies )
		{
			if (ally.getID() != actor.getID())
			{
				ally.getSkills().update();
			}
		}
	}

});