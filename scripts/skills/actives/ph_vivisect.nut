this.ph_vivisect <- this.inherit("scripts/skills/skill", {
	m = 
    {
        AccMod = -30,
    },
	function create()
	{
		this.m.ID = "actives.ph_vivisect";
		this.m.Name = "Vivisect";
		this.m.Description = "One can only learn so much from a cadaver. Unfortunately, the living.. they simply do not apreciate science..";
		this.m.KilledString = "Vivisected";
		this.m.Icon = "skills/ph_vivisect.png";
		this.m.IconDisabled = "skills/ph_vivisect_sw.png";
		this.m.Overlay = "ph_vivisect";
        this.m.SoundOnUse = [
			"sounds/combat/slash_01.wav",
			"sounds/combat/slash_02.wav",
			"sounds/combat/slash_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/slash_hit_01.wav",
			"sounds/combat/slash_hit_02.wav",
			"sounds/combat/slash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;

		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
        this.m.ChanceDecapitate = 25;
        this.m.ChanceDisembowel = 90;		
		this.m.HitChanceBonus = this.m.AccMod;
	}

	function getTooltip()
	{
		local result = this.getDefaultTooltip();

        result.push({
			id = 6,
			type = "text",
			icon = "ui/tooltips/positive.png",
			text = "Deals significantly increased damage but cannot pierce armor."
		});

        result.push({
			id = 7,
			type = "text",
			icon = "ui/tooltips/positive.png",
			text = "Inflicts multiple bleed based on damage dealt to hitpoints."
		});

        result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::MSU.Text.colorNegative(this.m.HitChanceBonus) + " hit chance."
		});

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has " + ::MSU.Text.colorNegative(this.m.AccMod) + " hit chance. Dagger Mastery & Anatomists increase hit chance by " + ::MSU.Text.colorPositive("5%") + " each."
		});

		return result;
	}

	function onAfterUpdate( _properties )
	{	
        this.m.HitChanceBonus = this.m.AccMod;
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;            
			this.m.ActionPointCost = 4;
			this.m.HitChanceBonus += 5;
		}

		local _actor = this.getContainer().getActor();
		if(_actor.getSkills().hasSkill("background.anatomist"))
		{
			this.m.HitChanceBonus += 5;
		}
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);		
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			//apply the dmg boost and acc reduction!
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 30;
            _properties.DamageArmorMult = 0.10;

            local accPenalty = this.m.AccMod;
            if( this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers ) accPenalty += 5;
            if( this.getContainer().getActor().getSkills().hasSkill("background.anatomist") ) accPenalty += 5;
			_properties.MeleeSkill -= accPenalty;
		}
	}

	function inflictBleeds(_targetEntity, _damage){
		//first bleed @5dmg, each subsecquent bleed requires +1dmg
		local dmgReq = 5;
		while(_damage >= dmgReq)
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
			_damage -= dmgReq;
			dmgReq++;			
		}
	}

    function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
        if (_skill == this)
        {
			if(_targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
				this.inflictBleeds(_targetEntity, _damageInflictedHitpoints);
			}
        }
	}

	function onShieldHit( _info )
	{		
		//take injury
		this.getItem().inflictCutOnSelf(50);
	}
});