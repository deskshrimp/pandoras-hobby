this.ph_golden_whacker <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ph_golden_whacker";
		this.m.Name = "The Golden Whacker";
		this.m.Description = "At first glance this large hammer appears to be a crudely fashioned golden bludgeon, a rather unsuitable material, however, through some hidden genius the golden goose affixed as the head now produces gold during battle!";
		this.m.Categories = "Hammer, Two-Handed";
		this.m.IconLarge = "weapons/melee/ph_golden_whacker.png";
		this.m.Icon = "weapons/melee/ph_golden_whacker_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Legendary;
		this.m.IsAgainstShields = true;
        this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ph_golden_whacker";
		this.m.Value = 8000;
		this.m.ShieldDamage = 30;
		this.m.Condition = 150.0;
		this.m.ConditionMax = 150.0;
		this.m.StaminaModifier = -20;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 2.0;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;

		this.m.WeaponType = ::Const.Items.WeaponType.Hammer;

        this.m.Reach = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ph_whack"));
		this.addSkill(this.new("scripts/skills/actives/ph_spin_to_win"));

        this.addSkill(this.new("scripts/skills/special/ph_golden_eggs"));
		
        //will also have pummel added by Reforged mastery skills
	}

    function getTooltip()
	{
		local result = this.weapon.getTooltip();

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/money2.png",
			text = "Enemies drop gold when slain!"
		});

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/repair_item.png",
			text = "Gold is a soft material with increased durability lost."
		});

		return result;
	}

    //increase the condition lost on hit
    function onDamageDealt( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull())
		{
			return;
		}

		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
			{
				this.lowerCondition(::Const.Combat.WeaponDurabilityLossOnHit + 1.0);
			}
		}
	}

    //generate gold!
    function generateGold(_targetEntity)
    {
        local tile = _targetEntity.getTile();
        if(tile == null)
        {
            tile = this.getContainer().getActor().getTile();
        }

        local loot = ::new("scripts/items/supplies/money_item");
        loot.setAmount( ::Math.floor(_targetEntity.getXPValue() * ::Math.rand(10,25) * 0.01) );
        loot.m.IsDroppedAsLoot = true;
		loot.drop(tile);
    }
});
