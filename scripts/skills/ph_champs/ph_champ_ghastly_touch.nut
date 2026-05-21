this.ph_champ_ghastly_touch <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ph_champ_ghastly_touch";
		this.m.Name = "Withering Touch";
		this.m.Description = "Attack the very soul of an opponent, damaging them through their armor.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/active_42.png";
		this.m.IconDisabled = "skills/active_42.png";
		this.m.Overlay = "active_42";
		this.m.SoundOnUse = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 10;
		_properties.DamageRegularMax += 25;
		_properties.IsIgnoringArmorOnAttack = true;
	}

    function onUse( _user, _targetTile )
	{   		
		local success = this.attackEntity(_user, _targetTile.getEntity());		

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success && !_targetTile.IsEmpty)
		{
			local target = _targetTile.getEntity();
			if (!target.isAlive() || target.isDying())
			{
				//apply wither!
        		target.getSkills().add(::new("scripts/skills/effects/withered_effect"));
			}
		}

		return success;
    }

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageArmorMult *= 0.0;
			_properties.IsIgnoringArmorOnAttack = true;
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflicts [$ $|Skill+withered_effect] on hit")			
		});
		return ret;
	}

});