this.ph_necro_ammy_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Sounds = [
			"sounds/enemies/skeleton_death_01.wav",
			"sounds/enemies/skeleton_death_02.wav",
			"sounds/enemies/skeleton_death_03.wav",
			"sounds/enemies/skeleton_death_04.wav",
			"sounds/enemies/skeleton_death_05.wav",
			"sounds/enemies/skeleton_death_06.wav",
			"sounds/enemies/skeleton_hurt_01.wav",
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav",			
			"sounds/enemies/skeleton_hurt_06.wav",
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_02.wav",
			"sounds/enemies/skeleton_idle_03.wav",
			"sounds/enemies/skeleton_idle_04.wav",
			"sounds/enemies/skeleton_idle_05.wav",
			"sounds/enemies/skeleton_idle_06.wav",
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav",
		],
		Spirit = 0,
		Scripts = [			
			"scripts/entity/tactical/enemies/skeleton_light",
			"scripts/entity/tactical/enemies/skeleton_medium",
			"scripts/entity/tactical/enemies/skeleton_medium_polearm",
		]
	},
	function create()
	{
		this.m.ID = "special.ph_necro_ammy";
		this.m.Name = "Ancient Necromancer\'s Gift";
		this.m.Description = "Occasionally raise skeletal minions at uncontrollable intervals.";
		this.m.Icon = "skills/status_effect_07.png";
		this.m.IconMini = ""; //there is no mini icon for 07
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.SoundOnUse = [
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav",
		];
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.Sounds )
		{
			this.Tactical.addResource(r);
		}
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		this.m.Spirit += 5;
	}

	function onCombatStarted()
	{
		this.m.Spirit = 0; //start each battle at zero
	}

	function onTurnEnd()
	{
		this.m.Spirit += 5;

		if(::Math.rand(0,100) < this.m.Spirit)
		{
			this.raiseTheDead();
		}
	}

	function raiseTheDead()
	{
		local tile = this.findEmptyTile();
		if( tile == null ) return;

		this.useForFree(tile);
	}

	function onUse( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(::MSU.Array.rand(this.m.Scripts), _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(::Const.Faction.PlayerAnimals);
		entity.getSprite("socket").setBrush("bust_base_player");
		entity.assignRandomEquipment();

		//consume spirit
		this.m.Spirit -= 50;	//let it go negative
	}

	function findEmptyTile()
	{
		local actor = this.getContainer().getActor();
		if( actor == null || actor.isNull() ) return null;

		local tile = actor.getTile();
        if( tile == null ) return null;

		for( local i = 0; i != 6; ++i )
        {
            if (!tile.hasNextTile(i)) { continue; }
            local targetTile = tile.getNextTile(i);

            if ( targetTile.IsOccupiedByActor ) { continue; }

			return targetTile;
		}

		return null;
	}
});