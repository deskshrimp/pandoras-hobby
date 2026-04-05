this.ph_bro_slap <- this.inherit("scripts/skills/skill", {
	m = 
    {
        HasHelmet = false,
        HasArmor = false,
    },
	function create()
	{
		this.m.ID = "actives.ph_bro_slap";
		this.m.Name = "Bro Slap";
		this.m.Description = "Get their attention with an open palm.";
		this.m.KilledString = "Slapped";
		this.m.Icon = "skills/ph_slap.png";
		this.m.IconDisabled = "skills/ph_slap_sw.png";
		this.m.Overlay = "ph_slap";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/whip_hit_01.wav",
			"sounds/combat/whip_hit_02.wav",
			"sounds/combat/whip_hit_03.wav",
			"sounds/combat/whip_hit_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
        this.m.IsIgnoredAsAOO = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = false;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 7;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
        this.m.MaxLevelDifference = 1;

        //this.m.HitChanceBonus = -15;

        this.m.IsVisibleTileNeeded = true;
	}

	function getTooltip()
	{
		local result = this.getDefaultTooltip();
		
        result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Causes a morale check (2x on hitpoint damage). Improves ally morale, decreases enemy morale."
		});

        result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Small chance to Distract the target and do an additional morale check."
		});

		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Accuracy is significatnly reduced if used without an empty hand. Accuracy is increased greatly when targeting an ally."
		});

        result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Guaranteed to strike the head."
		});

		return result;
	}

	function isHidden()
	{
        return !this.m.HasHelmet || !this.m.HasArmor;
	}

    function onVerifyTarget( _originTile, _targetTile )
	{
		if (this.m.IsTargetingActor && (_targetTile.IsEmpty || !_targetTile.getEntity().isAttackable() || !_targetTile.getEntity().isAlive() || _targetTile.getEntity().isDying()))
		{
			return false;
		}

		if (this.Math.abs(_targetTile.Level - _originTile.Level) > this.m.MaxLevelDifference)
		{
			return false;
		}		

		return true;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

    function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{	
            //must hit head
            _properties.HitChanceMult[::Const.BodyPart.Head] = 1.0;
			_properties.HitChanceMult[::Const.BodyPart.Body] = 0.0;
			
            //deals low fixed dmg, almost nothing vs armor
			_properties.DamageRegularMin = 5;
			_properties.DamageRegularMax = 10;
			_properties.DamageArmorMult = 0.2;

			local actor = this.m.Container.getActor();
			if(actor == null) return;
			local mainhand = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
			local offhand = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
            local isDisarmed = this.getContainer().hasSkill("effects.disarmed")
            
            if(mainhand != null)
            {
                if(isDisarmed || offhand == null)
                {
                    _properties.MeleeSkill += 5;
                }
                else if(offhand != null)
                {                    
                    if(offhand.getStaminaModifier() < -5) _properties.MeleeSkill -= 15;
                    //light off hand items do not harm aim
                }
                else if(mainhand.isItemType(::Const.Items.ItemType.TwoHanded))
                {                    
                    _properties.MeleeSkill -= 10;
                }
            }
            else //mainhand is empty
            {
                _properties.MeleeSkill += 10;
            }
			
			if(_targetEntity != null && actor.isAlliedWith(_targetEntity))
			{
				_properties.MeleeSkill += 50;
			}
		}
	}

    function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
        if (_skill == this)
        {            
            local actor = this.getContainer().getActor();
            local isAlly = actor.isAlliedWith(_targetEntity);
            
            //apply distraction?
            local wasDistracted = false;
            if(::Math.rand(1,100) <= (isAlly ? _damageInflictedHitpoints : _damageInflictedHitpoints*2) )
            {
                _targetEntity.getSkills().add(::new("scripts/skills/effects/distracted_effect"));
                wasDistracted = true;

                this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " distracted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " with a bro slap to the face.");
            }

            //Morale check formula
            //Positive Check: rand(100) > resolve + difficult - numAdjOpponents - threat; then fail
            //Negative Check: rand(100) < resolve + difficult - numAdjOpponents + numAdjAllies - threat; then fail

            local dealtDmg = _damageInflictedHitpoints > 0;

            //inflict morale check
            local magnitude = (isAlly ? 1 : -1);
            if(dealtDmg && ::Math.rand(0,10) < _damageInflictedHitpoints) magnitude *= 2;
			if(isAlly && _targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing) magnitude = 2; //boost vs fleeing allies
            local difficulty = (isAlly ? ::Math.floor(actor.getCurrentProperties().getBravery() * 0.2) : ::Math.floor(actor.getCurrentProperties().getBravery() * -0.3)); 
            
            local success = _targetEntity.checkMorale(magnitude, difficulty, ::Const.MoraleCheckType.MentalAttack );
            if(dealtDmg) success = success || _targetEntity.checkMorale(magnitude, difficulty, ::Const.MoraleCheckType.MentalAttack );
            if(wasDistracted) success = success || _targetEntity.checkMorale(magnitude, difficulty, ::Const.MoraleCheckType.MentalAttack );

            if(isAlly)
            {
                if(success)
                {
                    this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " boosted " + this.Const.UI.getColorizedEntityName(_targetEntity) + "'s morale with a bro slap to the face.");
                }
                else
                {
                    this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " failed to improve " + this.Const.UI.getColorizedEntityName(_targetEntity) + "'s morale.");
                }
            }
            else
            {
                if(success)
                {
                    this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " intimidated " + this.Const.UI.getColorizedEntityName(_targetEntity) + " with a bro slap to the face.");
                }
                else
                {
                    this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " failed to intimidate " + this.Const.UI.getColorizedEntityName(_targetEntity) + ".");
                }
            }
        }
	}
});

