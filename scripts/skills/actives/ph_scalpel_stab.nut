this.ph_scalpel_stab <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ph_scalpel_stab";
		this.m.Name = "Perforate";
		this.m.Description = "Deliberate and rather inefficient misuse of a medical instrument in a potentially misguided attempt to inflict greater bodily harm on the opponent than thyself.";
		this.m.KilledString = "Perforated";
		this.m.Icon = "skills/ph_scalpel_stab.png";
		this.m.IconDisabled = "skills/ph_scalpel_stab_sw.png";
		this.m.Overlay = "ph_scalpel_stab";
		this.m.SoundOnUse = [
			"sounds/combat/stab_01.wav",
			"sounds/combat/stab_02.wav",
			"sounds/combat/stab_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/stab_hit_01.wav",
			"sounds/combat/stab_hit_02.wav",
			"sounds/combat/stab_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 7;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local result = this.getDefaultTooltip();

        result.push({
			id = 6,
			type = "text",
			icon = "ui/tooltips/positive.png",
			text = "+10 maximum damage."
		});

        result.push({
			id = 7,
			type = "text",
			icon = "ui/tooltips/positive.png",
			text = "Inflicts 1 bleed for every 10 damage dealt to HP."
		});

        if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
        {
            result.push({
			    id = 8,
			    type = "text",
			    icon = "ui/tooltips/positive.png",
			    text = "Dagger mastery guarantees at least 5 damage to HP."
		    });
        }

		return result;
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

    function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{	
            _properties.DamageRegularMax += 10;
			_properties.DamageArmorMult = 0.25;

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
			{
				_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 5);                
			}
		}
	}

    function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
        if (_skill == this)
        {
			if(_targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
            	local numBleeds = ::Math.floor( _damageInflictedHitpoints / 10 );
                for(local i=0; i<numBleeds; i++)
                {
                    _targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
                }
			}
        }
	}

    function onShieldHit( _info )
	{		
		//take injury even if you have mastery!
		this.getItem().inflictCutOnSelf(200);
	}
});

