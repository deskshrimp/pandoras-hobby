this.chilling_aura <- this.inherit("scripts/skills/skill", {
	m = {
		SnowTiles = []
	},
	function create()
	{
		this.m.ID = "special.chilling_aura";
		this.m.Name = "Chilling Aura";
		this.m.Description = "This creature drains the all the warmth from its surroundings.";
		this.m.Icon = "skills/status_effect_109.png";
		this.m.Type = ::Const.SkillType.Special;
        this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;

		for( local i = 1; i <= 3; i = ++i )
		{
			this.m.SnowTiles.push(this.MapGen.get("tactical.tile.snow" + i));
		}
	}

	function onTurnEnd()
	{
        local user = this.getContainer().getActor();
        if( user == null || user.isNull() ) return;

        //make some snow!
        local myTile = user.getTile();
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

				if ( nextTile.Subtype != ::Const.Tactical.TerrainSubtype.Snow && nextTile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow )
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

		if (myTile.Subtype != ::Const.Tactical.TerrainSubtype.Snow && myTile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow)
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

        if (::Const.Tactical.SpiritWalkStartParticles.len() != 0)
		{
			for( local i = 0; i < ::Const.Tactical.SpiritWalkStartParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, ::Const.Tactical.SpiritWalkStartParticles[i].Brushes, user.getTile(), ::Const.Tactical.SpiritWalkStartParticles[i].Delay, ::Const.Tactical.SpiritWalkStartParticles[i].Quantity, ::Const.Tactical.SpiritWalkStartParticles[i].LifeTimeQuantity, ::Const.Tactical.SpiritWalkStartParticles[i].SpawnRate, ::Const.Tactical.SpiritWalkStartParticles[i].Stages);
			}
		}
	}
});

