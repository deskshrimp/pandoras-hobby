this.ph_champ_horrific_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ph_champ_horrific_scream";
		this.m.Name = "Banshee Wail";
		this.m.Description = "";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Horrific Scream");
		}

		//make huge aoe around self!
        //this skill will naturally cause overlaps as it rings around each tile!

        _targetTile = _user.getTile(); //grab own tile
        for( local i = 0; i != 6; ++i )
        {
            if (!_targetTile.hasNextTile(i)) { continue; }
            local tile = _targetTile.getNextTile(i);

            local diff = ::Math.abs(_targetTile.Level - tile.Level);

            //scream at the tile
            this.screamAtTile(tile, diff, -10);
            
            //now echo out again from there!
            this.echoScreamAOE(_user, tile);
        }

		return true;
	}

    function echoScreamAOE ( _user, _targetTile)
    {
        for( local i = 0; i != 6; ++i )
        {
            if (!_targetTile.hasNextTile(i)) { continue; }
            local tile = _targetTile.getNextTile(i);

            local diff = ::Math.abs(_targetTile.Level - tile.Level);

            //scream at the tile
            this.screamAtTile(tile, diff, -5);
        }
    }

    function screamAtTile(_tile, _heightDiff, _diff)
    {
        //ensure there is someone there and that they are within the height allowance

        if (!tile.IsOccupiedByActor || tile.getEntity().isAlliedWith(_user)) { return; }
        
        if(_heightDiff > this.m.MaxLevelDifference) { return; }

        //then scream at them
        tile.getEntity().checkMorale(-1, _diff + _heightDiff, ::Const.MoraleCheckType.MentalAttack);
    }
});

