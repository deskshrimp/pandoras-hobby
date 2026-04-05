this.ph_magic_bonk <- this.inherit("scripts/skills/skill", {
	m = {
        MagicSounds_Insects = [
            "sounds/status/insect_swarm_effect_01.wav",
			"sounds/status/insect_swarm_effect_02.wav",
			"sounds/status/insect_swarm_effect_03.wav"
        ],
        MagicSounds_Roots = [
            "sounds/enemies/goblin_roots_01.wav",
			"sounds/enemies/goblin_roots_02.wav"
        ],
        MagicSounds_RootsBreak = [
            "sounds/combat/break_free_roots_00.wav",
			"sounds/combat/break_free_roots_01.wav",
			"sounds/combat/break_free_roots_02.wav",
			"sounds/combat/break_free_roots_03.wav"
        ],
        MagicSounds_Miasma_Use = [
            "sounds/enemies/miasma_spell_01.wav",
			"sounds/enemies/miasma_spell_02.wav",
			"sounds/enemies/miasma_spell_03.wav"
        ],
        MagicSounds_Miasma_Hit = [
            "sounds/humans/human_coughing_01.wav",
			"sounds/humans/human_coughing_02.wav",
			"sounds/humans/human_coughing_03.wav",
			"sounds/humans/human_coughing_04.wav"
        ],
        MagicSounds_Hex_Use = [
            "sounds/enemies/dlc2/hexe_hex_01.wav",
			"sounds/enemies/dlc2/hexe_hex_02.wav",
			"sounds/enemies/dlc2/hexe_hex_03.wav",
			"sounds/enemies/dlc2/hexe_hex_04.wav",
			"sounds/enemies/dlc2/hexe_hex_05.wav"
        ],
        MagicSounds_Hex_Hit = [
            "sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
        ],
        MagicSounds_Charm_Use = [
            "sounds/enemies/dlc2/hexe_charm_kiss_01.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_02.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_03.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_04.wav"
        ],
        MagicSounds_Charm_Hit = [
            "sounds/enemies/dlc2/hexe_charm_chimes_01.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_02.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_03.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_04.wav"
        ],
        MagicSounds_Grant_Vision = [
            "sounds/enemies/shaman_skill_nightvision_01.wav",
			"sounds/enemies/shaman_skill_nightvision_02.wav",
			"sounds/enemies/shaman_skill_nightvision_03.wav"
        ],
        MagicSounds_Sleep_Use = [
            "sounds/enemies/dlc2/alp_sleep_01.wav",
			"sounds/enemies/dlc2/alp_sleep_02.wav",
			"sounds/enemies/dlc2/alp_sleep_03.wav",
			"sounds/enemies/dlc2/alp_sleep_04.wav",
			"sounds/enemies/dlc2/alp_sleep_05.wav",
			"sounds/enemies/dlc2/alp_sleep_06.wav",
			"sounds/enemies/dlc2/alp_sleep_07.wav",
			"sounds/enemies/dlc2/alp_sleep_08.wav",
			"sounds/enemies/dlc2/alp_sleep_09.wav",
			"sounds/enemies/dlc2/alp_sleep_10.wav",
			"sounds/enemies/dlc2/alp_sleep_11.wav",
			"sounds/enemies/dlc2/alp_sleep_12.wav"
        ],
    },

	function create()
	{
		this.m.ID = "actives.ph_magic_bonk";
		this.m.Name = "Bonk";
		this.m.Description = "A brute force attack that inflicts additional fatigue with every hit.";
		this.m.KilledString = "Clubbed to death";
		this.m.Icon = "skills/active_02.png";
		this.m.IconDisabled = "skills/active_02_sw.png";
		this.m.Overlay = "active_02";
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav",
			"sounds/combat/bash_02.wav",
			"sounds/combat/bash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
		];        
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

    function addResources()
    {
        foreach( r in this.m.MagicSounds_Insects )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Roots )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_RootsBreak )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Miasma_Hit )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Miasma_Use )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Hex_Hit )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Hex_Use )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Charm_Hit )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Charm_Use )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Grant_Vision )
		{
			this.Tactical.addResource(r);
		}
        foreach( r in this.m.MagicSounds_Sleep_Use )
		{
			this.Tactical.addResource(r);
		}
    }

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 2 + "[/color] extra fatigue"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInMaces ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;
		}
	}

    function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{            
            //Chance to trigger a magical effect
            if(::Math.rand(0,100) > 33) return;

			//::logError("BONK -- TIME TO MAKE SOME MAGIC!");

            local user = this.getContainer().getActor();

            local magic = ::MSU.Class.WeightedContainer([
                [10, this.triggerSpell_Insect],                    
                [10, this.triggerSpell_Roots],
                [10, this.triggerSpell_Miasma],
                [5, this.triggerSpell_Hex],
                [5, this.triggerSpell_Charm],
                [10, this.triggerSpell_NightVision],
                [10, this.triggerSpell_Sleep],
            ]);
            magic.roll()(user, _targetEntity);
		}
	}

    function triggerSpell_Insect(_user, _target)
    {
        ::Sound.play(::MSU.Array.rand(this.m.MagicSounds_Insects), ::Const.Sound.Volume.Skill, _user.getPos());

	//::logError("BONK -- Insects");

        local effect = _target.getSkills().getSkillByID("effects.insect_swarm");

		if (effect != null)
		{
			effect.resetTime();
		}
		else
		{
			_target.getSkills().add(::new("scripts/skills/effects/insect_swarm_effect"));
		}
    }

    function triggerSpell_Roots(_user, _target)
    {
	//::logError("BONK -- Roots");

        if (_target.getCurrentProperties().IsRooted)
		{
			return false;
		}

		if (_target.getCurrentProperties().IsImmuneToRoot)
		{
			return false;
		}

	//::logError("BONK -- Roots APPLY");

        ::Sound.play(::MSU.Array.rand(this.m.MagicSounds_Roots), ::Const.Sound.Volume.Skill, _user.getPos());

        _target.getSkills().add(::new("scripts/skills/effects/rooted_effect"));
		local breakFree = ::new("scripts/skills/actives/break_free_skill");
		breakFree.setDecal("roots_destroyed");
		breakFree.m.Icon = "skills/active_75.png";
		breakFree.m.IconDisabled = "skills/active_75_sw.png";
		breakFree.m.Overlay = "active_75";
		breakFree.m.SoundOnUse = this.m.MagicSounds_RootsBreak;
		_target.getSkills().add(breakFree);
		_target.raiseRootsFromGround("bust_roots", "bust_roots_back");
    }

    function triggerSpell_Miasma(_user, _target)
    {
	//::logError("BONK -- Miasma");
        ::Sound.play(::MSU.Array.rand(this.m.MagicSounds_Miasma_Use), ::Const.Sound.Volume.Skill, _user.getPos());

        local _targetTile = _target.getTile();

        local targets = [];
		targets.push(_targetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		local p = {
			Type = "miasma",
			Tooltip = "Miasma lingers here, harmful to any living being",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = false,
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyMiasma,
			function Applicable( _a )
			{
				return !_a.getFlags().has("undead");
			}

		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "miasma")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
			}
			else
			{
				if (tile.Properties.Effect != null)
				{
					this.Tactical.Entities.removeTileEffect(tile);
				}

				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.MiasmaParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.MiasmaParticles[i].Brushes, tile, this.Const.Tactical.MiasmaParticles[i].Delay, this.Const.Tactical.MiasmaParticles[i].Quantity, this.Const.Tactical.MiasmaParticles[i].LifeTimeQuantity, this.Const.Tactical.MiasmaParticles[i].SpawnRate, this.Const.Tactical.MiasmaParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
			}
		}
    }

    function triggerSpell_Hex(_user, _target)
    {
	//::logError("BONK -- Hex");
        if (_target.getCurrentProperties().IsImmuneToDamageReflection) return false;
		
		if (_target.getSkills().hasSkill("effects.hex_slave")) return false;

        local tag = {
			User = _user,
			TargetTile = _target.getTile()
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedHexEffect.bindenv(this), tag);
    }

    function onDelayedHexEffect( _tag )
    {
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
        if(target == null) return;

		if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
		{
			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being hexed thanks to his unnatural physiology");
			}

			return false;
		}

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " hexes " + this.Const.UI.getColorizedEntityName(target));

			if (this.m.MagicSounds_Hex_Use.len() != 0)
			{
				this.Sound.play(this.m.MagicSounds_Hex_Use[this.Math.rand(0, this.m.MagicSounds_Hex_Use.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, _user.getPos());
			}
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, function ( _tag )
		{
			local color;

			do
			{
				color = this.createColor("#ff0000");
				color.varyRGB(0.75, 0.75, 0.75);
			}
			while (color.R + color.G + color.B <= 150);

			this.Tactical.spawnSpriteEffect("effect_pentagram_02", color, _targetTile, !target.getSprite("status_hex").isFlippedHorizontally() ? 10 : -5, 88, 3.0, 1.0, 0, 400, 300);
			local slave = this.new("scripts/skills/effects/hex_slave_effect");
			local master = this.new("scripts/skills/effects/hex_master_effect");
			slave.setMaster(master);
			slave.setColor(color);
			target.getSkills().add(slave);
			master.setSlave(slave);
			master.setColor(color);
			_user.getSkills().add(master);
			slave.activate();
			master.activate();
		}.bindenv(this), null);
    }

    function triggerSpell_Charm(_user, _target)
    {
	//::logError("BONK -- Charm");
        if (_target.isAlliedWith(_user)) return false;		

		if (_target.getMoraleState() == this.Const.MoraleState.Ignore || _target.getMoraleState() == this.Const.MoraleState.Fleeing) return false;
		
		if (_target.getCurrentProperties().MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] >= 1000.0) return false;		

		if (_target.getSkills().hasSkill("effects.charmed")) return false;        
		
        local tag = {
			User = _user,
			TargetTile = _target.getTile()
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedCharmEffect.bindenv(this), tag);		
    }    

    function onDelayedCharmEffect( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
        if(target == null) return;

			if (target.checkMorale(0, -30, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
				}

				return false;
			}

			if (target.checkMorale(0, -30, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
				}

				return false;
			}

			if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his unnatural physiology");
				}

				return false;
			}

            ::Sound.play(::MSU.Array.rand(this.m.MagicSounds_Charm_Use), ::Const.Sound.Volume.Skill, _user.getPos());

			local charmed = this.new("scripts/skills/effects/charmed_effect");
			charmed.setMasterFaction(_user.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : _user.getFaction());
			charmed.setMaster(null);
			target.getSkills().add(charmed);

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " is charmed");
			}
	}

    function triggerSpell_NightVision(_user, _target)
    {
	//::logError("BONK -- Night Vision");
        if (!_target.getCurrentProperties().IsAffectedByNight || !_target.getSkills().hasSkill("special.night")) return false;

        ::Sound.play(::MSU.Array.rand(this.m.MagicSounds_Grant_Vision), ::Const.Sound.Volume.Skill, _user.getPos());

        this.spawnIcon("status_effect_98", target.getTile());
		target.getSkills().removeByID("special.night");
    }

    function triggerSpell_Sleep(_user, _target)
    {
	//::logError("BONK -- Sleep");
		local _targetTile = _target.getTile();
        if (_targetTile.getEntity().getCurrentProperties().IsStunned) return false;

        if (_targetTile.getEntity().isNonCombatant()) return false;

        if (_target.getCurrentProperties().MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] >= 1000.0) return false;

        ::Sound.play(::MSU.Array.rand(this.m.MagicSounds_Sleep_Use), ::Const.Sound.Volume.Skill, _user.getPos());

        local tag = {
			User = _user,
			TargetTile = _target.getTile()
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedSleepEffect.bindenv(this), tag);
    }

    function onDelayedSleepEffect( _tag )
	{		
		local _user = _tag.User;        
        local target = _tag.TargetTile.getEntity();
        if(target == null) return;
        
		if (target.checkMorale(0, -35, this.Const.MoraleCheckType.MentalAttack))
		{
			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists the urge to sleep thanks to his resolve");
			}

            return;
        }

		target.getSkills().add(this.new("scripts/skills/effects/sleeping_effect"));

		if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " falls to sleep");
		}
	}
});