this.ph_artificer_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.ph_artificer_helm";
		this.m.Name = "Judgement";
		this.m.Description = "A somehwat ostentatious ancient helm that has been masterfully restored and augmented with padding, mask, and a garish plume.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;        
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.IsIndestructible = true;
		this.m.Variant = 425;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10000;
		this.m.Condition = 155.0;
		this.m.ConditionMax = 155.0;
		this.m.StaminaModifier = -8;
        this.m.Vision = -2;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

    function updateVariant()
	{		
		this.m.Sprite = "ph_bust_helmet_425";
		this.m.SpriteDamaged = "ph_bust_helmet_425_damaged";
		this.m.SpriteCorpse = "ph_bust_helmet_425_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/ph_inventory_helmet_425.png";
	}

    function getTooltip()
	{
		local result = this.helmet.getTooltip();

		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
        result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to Daze"
		});
        result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the head by [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]"
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
			text = "Grants a unique skill when worn with the matching armor."
		});

		return result;
	}

    function onEquip()
	{
		this.helmet.onEquip();
		
        local actor = this.getContainer().getActor();
        if(actor == null || actor.isNull()) return;

        actor.getFlags().add("head_immune_to_acid");

        local skill = actor.getSkills().getSkillByID("actives.ph_bro_slap");
        if(skill == null)
        {
            skill = ::new("scripts/skills/actives/ph_bro_slap");
            actor.getSkills().add(skill);
        }
        skill.m.HasHelmet = true;
	}

	function onUnequip()
	{
		this.helmet.onUnequip();

		local actor = this.getContainer().getActor();
        if(actor == null || actor.isNull()) return;

        actor.getFlags().remove("head_immune_to_acid");

        local skill = actor.getSkills().getSkillByID("actives.ph_bro_slap");
        if(skill == null) return;
        skill.m.HasHelmet = false;
        if(skill.isHidden()) actor.getSkills().remove(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.helmet.onUpdateProperties(_properties);
		_properties.TargetAttractionMult *= 1.1;
        _properties.IsImmuneToDaze = true;
	}

    function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Head)
		{
			_properties.DamageReceivedRangedMult *= 0.9;
		}
	}
});

