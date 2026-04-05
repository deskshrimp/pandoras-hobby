this.ph_named_serpent_skin_upgrade <- this.inherit("scripts/items/armor_upgrades/named/ph_named_armor_upgrade", {
	m = {		
	},
	function create()
	{
		this.ph_named_armor_upgrade.create();
		this.m.ID = "armor_upgrade.ph_named_serpent_skin";		
		this.m.Description = "A mantle crafted from the thin and shimmering scales of desert serpents, especially resistant to heat and flames.";
		this.m.ArmorDescription = "A mantle of serpent skin has been attached to this armor, which makes it more resistant to heat and flames.";
        this.m.NameList = ["Emerald Scale Mantle"];
		this.m.CreatureNames = ::Const.Strings.PH_SnakeNames;
		this.m.Icon = "armor_upgrades/ph_named_upgrade_27.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/ph_named_icon_upgrade_27.png";
		this.m.OverlayIconLarge = "armor_upgrades/ph_named_inventory_upgrade_27.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_27_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_27_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_27_back_dead";
		this.m.Value = 1300;

        this.m.ConditionModifier = 30;
		this.m.ConditionRollMin = 100;	//30
		this.m.ConditionRollMax = 135;	//40

		this.m.StaminaModifier = 2;

        this.m.SpecialModifier = 0; //can't scale the dmg reduction value (and shouldn't)

		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ConditionModifier + "[/color] Durability"
		});

        if(this.m.StaminaModifier > 0)
        {
		    result.push({
			    id = 14,
			    type = "text",
			    icon = "ui/icons/fatigue.png",
			    text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.StaminaModifier + "[/color] Maximum Fatigue"
		    });
        }
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage from fire and firearms by [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage from fire and firearms by [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
	}

	function onEquip()
	{
		this.item.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().add(this.new("scripts/skills/items/firearms_resistance_skill"));
		}
	}

	function onUnequip()
	{
		this.item.onUnequip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().removeByID("items.firearms_resistance");
		}
	}

	function onAdded()
	{
		this.armor_upgrade.onAdded();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().add(this.new("scripts/skills/items/firearms_resistance_skill"));
		}
	}

	function onRemoved()
	{
		this.armor_upgrade.onRemoved();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().removeByID("items.firearms_resistance");
		}
	}
});

