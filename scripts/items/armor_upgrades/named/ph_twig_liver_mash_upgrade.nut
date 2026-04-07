this.ph_twig_liver_mash_upgrade <- this.inherit("scripts/items/armor_upgrades/named/ph_named_armor_upgrade", {
	m = {
		StoredGrowth = 0,
	},
	function create()
	{
		this.ph_named_armor_upgrade.create();
		this.m.ID = "armor_upgrade.ph_twig_liver_mash";		
		this.m.Description = "A paste made from unhold liver and schrat sprouts, a fouler version of moss milk, but the idea is the same. Coat an armor with it and watch it grow.";
		this.m.ArmorDescription = "The inside of this armor has been coated in a liver-sprout slime that requires frequent trimming.";
        this.m.NameList = ["Schrat Liver Paste"];
		this.m.CreatureNames = ::Const.Strings.PH_TreeNames;
		this.m.Icon = "armor_upgrades/ph_twig_mash_upgrade.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = null;
		this.m.OverlayIconLarge = null;
		this.m.SpriteFront = null;
		this.m.SpriteBack = null;
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = null;
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = null;
		this.m.Value = 1300;

		this.m.ConditionModifier = 10;
		this.m.ConditionRollMin = 100;	//10
		this.m.ConditionRollMax = 250;	//25

		this.m.StaminaModifier = 0;

		//armor regen
        this.m.SpecialModifier = 20;
		this.m.SpecialRollMin = 100; //20
		this.m.SpecialRollMax = 175; //35

		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 5,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ConditionModifier + "[/color] Durability"
		});

		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Removes 1 stack of bleeding per turn, while regrowing."
		});
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Stores growth based on " + this.m.SpecialModifier + "% of hitpoint damage received and regrows up to " + this.m.ConditionModifier + " armor each turn.",
		});

		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Removes 1 stack of bleeding per turn, while regrowing."
		});
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Stores growth based on " + this.m.SpecialModifier + "% of hitpoint damage received and regrows up to " + this.m.ConditionModifier + " armor each turn.",
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		//store hitpoint damage received to fuel growth
		this.m.StoredGrowth += ::Math.floor(_hitInfo.DamageInflictedHitpoints * this.m.SpecialModifier);
	}

	function onTurnStart()
	{
		local c = this.m.Armor.getContainer();
		if(c == null) return;
		local actor = this.m.Armor.getContainer().getActor();
		if(actor == null) return;
		
		//prevent any oddness and possible crashes
		if (!actor.m.IsAlive || actor.m.IsDying)
		{
			return;
		}

		//regenerate armor
		local regen = ::Math.min(this.m.ConditionModifier, this.m.StoredGrowth);			
		if(regen > 0)
		{			
			this.m.Armor.setArmor( ::Math.min( this.m.Armor.getArmorMax(), this.m.Armor.getArmor() + regen ) );
			this.updateAppearance();
			this.m.StoredGrowth -= regen;

			local msg = "'s armor has regrown " + regen + " durability";

			//check for bleeds		(only stops bleeds when growing! -- should naturally always be true!)
        	local bleed = actor.getSkills().getSkillByID("effects.bleeding");
			if(bleed != null && bleed.m.Stacks > 0)
			{
				//remove 1 stack of bleed
        		bleed.m.Stacks -= 1;

        		if(bleed.m.Stacks == 0)
        		{
					bleed.removeSelf();            		
        		}
				msg += " and a bleeding wound has been sealed (-1 bleed stack).";
			}

			//animate and write log
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}		
	}

	function onCombatFinished()
	{
		this.m.StoredGrowth = 0;
	}
});

