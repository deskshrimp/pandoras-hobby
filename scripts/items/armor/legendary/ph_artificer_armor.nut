this.ph_artificer_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.ph_artificer_armor";
		this.m.Name = "Honor";
		this.m.Description = "The incredible work of a blind tinker. This ancient armor has been polished, passivated, gilded, and expertly refurbished.";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IsIndestructible = true;
		this.m.Variant = 425;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10000;
		this.m.Condition = 155;
		this.m.ConditionMax = 155;
		this.m.StaminaModifier = -13;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

    function updateVariant()
	{		
		this.m.Sprite = "ph_bust_body_425";
		this.m.SpriteDamaged = "ph_bust_body_425_damaged";
		this.m.SpriteCorpse = "ph_bust_body_425_dead";
		this.m.IconLarge = "armor/ph_inventory_body_armor_425.png";
		this.m.Icon = "armor/ph_icon_body_armor_425.png";
	}

	function getTooltip()
	{
		local result = this.armor.getTooltip();

        result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]"
		});
        result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Somewhat [color=" + this.Const.UI.Color.NegativeValue + "]more likely[/color] to be attacked"
		});
        result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants a unique skill when worn with the matching helmet."
		});

        return result;
	}

    function onEquip()
	{
		this.armor.onEquip();
		
        local actor = this.getContainer().getActor();
        if(actor == null || actor.isNull()) return;

        actor.getFlags().add("body_immune_to_acid");

        local skill = actor.getSkills().getSkillByID("actives.ph_bro_slap");
        if(skill == null)
        {
            skill = ::new("scripts/skills/actives/ph_bro_slap");
            actor.getSkills().add(skill);
        }
        skill.m.HasArmor = true;
	}

	function onUnequip()
	{
		this.armor.onUnequip();

		local actor = this.getContainer().getActor();
        if(actor == null || actor.isNull()) return;

        actor.getFlags().remove("body_immune_to_acid");

        local skill = actor.getSkills().getSkillByID("actives.ph_bro_slap");
        if(skill == null) return;
        skill.m.HasArmor = false;
        if(skill.isHidden()) actor.getSkills().remove(skill);
	}

    function onUpdateProperties( _properties )
	{
		this.armor.onUpdateProperties(_properties);
		_properties.TargetAttractionMult *= 1.1;
	}

    function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedRangedMult *= 0.9;
		}
	}
});

