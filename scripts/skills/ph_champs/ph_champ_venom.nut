this.ph_champ_venom <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ph_champ_venom";
		this.m.Name = "Deadly Poison";
		this.m.Description = "This creature\'s attacks inflict a deadly poison.";
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_poison_01.wav",
			"sounds/enemies/dlc2/giant_spider_poison_02.wav"
		];
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;		
		this.m.IsActive = false;
		this.m.IsStacking = false;		
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		_tooltip.push({
			id = 100,
			type = "text",
			icon = "ui/icons/damage_received.png",
			text = "This creature\'s attacks inflict a deadly poison.",
		});
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{		
		if (!_targetEntity.isAlive())
		{
			return;
		}

		if (_damageInflictedHitpoints < ::Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}

		this.spawnIcon("status_effect_54", _targetEntity.getTile());
		local poison = _targetEntity.getSkills().getSkillByID("effects.ph_champ_venom");

		if (poison == null)
		{			
			_targetEntity.getSkills().add( ::new("scripts/skills/effects/ph_champ_venom_effect") );
		}
		else
		{
			poison.resetTime();
		}
	}

});

