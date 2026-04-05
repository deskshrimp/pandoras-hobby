this.ph_spin_to_win <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ph_spin_to_win";
		this.m.Name = "Spin to Win";
		this.m.Description = "Mow down all the targets around you, foe and friend alike, with a reckless round swing. Not hard to evade because it is not aimed at anything, but can be devastating if it connects. Be careful around your own men unless you want to relieve your payroll!";
		this.m.KilledString = "Crushed";
		this.m.Icon = "skills/ph_spin_to_win.png";
		this.m.IconDisabled = "skills/ph_spin_to_win_sw.png";
		this.m.Overlay = "ph_spin_to_win";
		this.m.SoundOnUse = [
			"sounds/combat/shatter_01.wav",
			"sounds/combat/shatter_02.wav",
			"sounds/combat/shatter_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/round_swing_hit_01.wav",
			"sounds/combat/round_swing_hit_02.wav",
			"sounds/combat/round_swing_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 66;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local hitchanceBonus = this.m.HitChanceBonus;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
		{
			hitchanceBonus = hitchanceBonus + 5;
		}

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]" + hitchanceBonus + "%[/color] chance to hit"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can hit up to 6 targets"
			},
            {
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to stagger on a hit"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to knock back on a hit"
			}
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local ret = false;
		local ownTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		this.spawnAttackEffect(ownTile, this.Const.Tactical.AttackEffectThresh);

		for( local i = 5; i >= 0; i = --i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					if (ret && soundBackup.len() == 0)
					{
						soundBackup = this.m.SoundOnHit;
						this.m.SoundOnHit = [];
					}
                    
                    local success = this.attackEntity(_user, tile.getEntity());
                    
                    if (success && tile.IsOccupiedByActor && tile.getEntity().isAlive() && !tile.getEntity().isDying())
			        {
				        this.applyEffectToTarget(_user, tile.getEntity(), tile);
			        }

					ret = success || ret;

					if (!_user.isAlive() || _user.isDying())
					{
						break;
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0)
		{
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
			_properties.DamageArmorMult -= 0.15;
		}
	}

    function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function applyEffectToTarget( _user, _target, _targetTile )
	{
		local applyEffect = this.Math.rand(1, 3);

		if (applyEffect == 1)
		{
			return;
		}
		else if (applyEffect == 2)
		{
			if (_target.getCurrentProperties().IsImmuneToKnockBackAndGrab || _target.getCurrentProperties().IsRooted)
			{
				return;
			}

			local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

			if (knockToTile == null)
			{
				return;
			}

			this.m.TilesUsed.push(knockToTile.ID);

			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has knocked back " + this.Const.UI.getColorizedEntityName(_target));
			}

			local skills = _target.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");
			_target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
			local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_target, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = _user,
					Skill = this,
					HitInfo = clone this.Const.Tactical.HitInfo
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				this.Tactical.getNavigator().teleport(_target, knockToTile, this.onKnockedDown, tag, true);
			}
		}
		else
		{
			if (_target.isNonCombatant())
			{
				return;
			}

			_target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(_target) + " for one turn");
			}
		}
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}
	}
});