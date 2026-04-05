this.ph_wailing_jar_skill <- this.inherit("scripts/skills/skill", {
	m = {
        Intensity = 0,
        WasForced = false,        
    },
	function create()
	{
		this.m.ID = "actives.horrific_scream";
		this.m.Name = "Wailing Scream";
		this.m.Description = "Shake the Wailing Jar to release a Horrific Scream.";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41_sw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;
	}

    function getTooltip()
	{
		local result = this.getDefaultTooltip();

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Intensity of the wail increases with each use during the same battle."
		});

        result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a chance to go off each time the holder takes damage."
		});

        result.push({
			id = 7,
			type = "text",
			icon = "ui/tooltips/negative.png",
			text = "Will target allies or self as the intensity increases."
		});

		return result;
	}

    function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
        //may need a higher max roll on this if incoming dmg is too high.
        if( ::Math.rand(0,200) < _damageHitpoints + _damageArmor )
        {
            this.forceUseOnSelf();
        }
	}

    function onDeath( _fatalityType )
	{       
        this.m.Intensity -= 5; //big bump
                
        this.forceUseOnSelf();

        this.skill.onDeath(_fatalityType);
	}

	function onCombatStarted()
	{
        this.m.Intensity = 0;
        this.m.WasForced = false;        

        this.skill.onCombatStarted();
	}

	function onCombatFinished()
	{
        this.m.Intensity = 0;
        this.m.WasForced = false;        

        this.skill.onCombatFinished();
	}

    function forceUseOnSelf(){
        local actor = this.getContainer().getActor();
        if(actor == null || actor.isNull()) return;

        local tile = actor.getTile();
        if( tile == null ) return;

        this.m.WasForced = true;

        this.useForFree(tile);
    }

	function onUse( _user, _targetTile )
	{
        if(this.m.WasForced)
        {
            this.m.WasForced = false;
            ::Tactical.EventLog.log("The Wailing Jar releases a Horrific Scream");
        }
        else
        {
            ::Tactical.EventLog.log( ::Const.UI.getColorizedEntityName(_user) + " shakes the Wailing Jar to release a Horrific Scream" );
        }		

        this.m.Intensity -= 1; //increase the intensity with every use!

        //Adjust the effects based on intensity
        local hitsAllies = (this.m.Intensity < -5)
        local echos = 0;
        if(this.m.Intensity < -4) echos++;
        if(this.m.Intensity < -14) echos++;
        this.performAOEWail(_user, _targetTile, this.m.Intensity+1, hitsAllies, echos);
        
		return true;
	}

    function performAOEWail(_user, _targetTile, _baseDiff, _canHitAllies, _echo, _chillOdds = 0, _witherOdds = 0)
    {
        for( local i = 0; i != 6; ++i )
        {
            if (!_targetTile.hasNextTile(i)) { continue; }
            local tile = _targetTile.getNextTile(i);

            if ( !tile.IsOccupiedByActor ) { continue; }

            local target = tile.getEntity();

            local isAlly = target.isAlliedWith(_user);            
            if( !_canHitAllies && isAlly ) { continue; }

            local diff = ::Math.abs(_targetTile.Level - tile.Level);
            if(diff > this.m.MaxLevelDifference) { continue; }

            local wailStrength = _baseDiff + diff + (isAlly ? 10 : 0);

            target.checkMorale(-1, wailStrength, ::Const.MoraleCheckType.MentalAttack);

            local chillOdds = this.m.Intensity * -5 - 15 - (isAlly ? 20 : 0) + _chillOdds; //cannot chill below Intesity 3, lower chance vs allies
                        
            if(chillOdds > 0 && ::Math.rand(0,100) < chillOdds)
            {
                target.getSkills().add(::new("scripts/skills/effects/chilled_effect"));
            }

            if(_echo > 0)
            {
                local echoDiff = ::Math.min(0, _baseDiff+5);
                local hitAllies = echoDiff < -2; //only the weakest uses don't hit allies
                this.performAOEWail(_user, tile, echoDiff, hitAllies, _echo-1, -20, -20);
            }
        }
    }
});

