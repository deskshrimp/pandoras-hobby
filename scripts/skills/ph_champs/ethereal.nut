this.ethereal <- this.inherit("scripts/skills/skill", {
	m = {},
	
	function create()
	{
		this.m.ID = "special.ethereal";
		this.m.Name = "Ethereal";
		this.m.Description = "This creature is a semi-solid apparation, which makes it devilishly hard to kill.";
		this.m.Icon = "skills/ph_barb_pot_effect.png";		
		this.m.Type = ::Const.SkillType.Special;
        this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{		
		if (_skill.getID() == "effects.holy_water")
		{
			//holy water deals (20 per turn)
			_properties.DamageReceivedTotalMult *= 1.0;
		}
		else
		{
			//otherwise, greatly reduce incoming dmg by 80%
			local dmgMult = 0.20;
			
			//boost legendary & named weapon dmg
			if(_skill.getItem() != null)
			{
				if(_skill.getItem().isItemType( ::Const.Items.ItemType.Legendary ))
				{
					dmgMult += 0.2;
				}
				else if(_skill.getItem().isItemType( ::Const.Items.ItemType.Named ))
				{
					dmgMult += 0.1;
				}
			}

			//reduced ranged dmg by 50%
			if(_skill.IsRanged) dmgMult *= 0.5;
			
			_properties.DamageReceivedTotalMult *= dmgMult;
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min( healthMissing, 5 );

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Greatly reduces all incoming damage. Receives increased damage from named & legendary weapons. Receives full damage from holy water."
		});
		ret.push({
			id = 11,
				type = "text",
				icon = "ui/icons/ph_ethereal_icon.png",
				text = "Restores up to [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] Spirit each turn"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Ignores zones of control."
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to damage reflection."
		});
		return ret;
	}
});

