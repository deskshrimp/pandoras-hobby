this.chilling_aura <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.chilling_aura";
		this.m.Name = "Chilling Aura";
		this.m.Description = "This creature is so cold its snowing!";
		this.m.Icon = "skills/status_effect_109.png";
		this.m.Type = this.Const.SkillType.Special;
        this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnEnd()
	{
        local user = this.getContainer().getActor();
        if( user == null || user.isNull() ) return;

        //make some snow!
        local myTile = _user.getTile();
		for( local i = 0; i < 6; i = ++i )
		{
			if ( !myTile.hasNextTile(i) )
			{
			}
			else
			{
				local nextTile = myTile.getNextTile(i);

                //apply chill!
				if (nextTile.IsOccupiedByActor)
				{
					nextTile.getEntity().getSkills().add( ::new("scripts/skills/effects/chilled_effect") );
				}

				if ( nextTile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && nextTile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow )
				{
					this.Time.scheduleEvent( this.TimeUnit.Virtual, 350, function ( _data )
					{
						_data.Tile.clear();
						_data.Tile.Type = 0;
						_data.Skill.m.SnowTiles[this.Math.rand(0, _data.Skill.m.SnowTiles.len() - 1)].onFirstPass({
							X = _data.Tile.SquareCoords.X,
							Y = _data.Tile.SquareCoords.Y,
							W = 1,
							H = 1,
							IsEmpty = true,
							SpawnObjects = false
						});
					}, {
						Tile = nextTile,
						Skill = this
					});
				}
			}
		}

		if (myTile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && myTile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow)
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 350, function ( _data )
			{
				_data.Tile.clear();
				_data.Tile.Type = 0;
				_data.Skill.m.SnowTiles[this.Math.rand(0, _data.Skill.m.SnowTiles.len() - 1)].onFirstPass({
					X = _data.Tile.SquareCoords.X,
					Y = _data.Tile.SquareCoords.Y,
					W = 1,
					H = 1,
					IsEmpty = true,
					SpawnObjects = false
				});
			}, {
				Tile = myTile,
				Skill = this
			});
		}

        this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SpiritWalkEndParticles[i].Brushes, _entity.getTile(), this.Const.Tactical.SpiritWalkEndParticles[i].Delay, this.Const.Tactical.SpiritWalkEndParticles[i].Quantity, this.Const.Tactical.SpiritWalkEndParticles[i].LifeTimeQuantity, this.Const.Tactical.SpiritWalkEndParticles[i].SpawnRate, this.Const.Tactical.SpiritWalkEndParticles[i].Stages);
	}
});

