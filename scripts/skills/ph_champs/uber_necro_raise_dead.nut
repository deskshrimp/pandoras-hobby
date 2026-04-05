this.uber_necro_raise_dead <- this.inherit("scripts/skills/skill", {
	m = {
		Sounds = [
			"sounds/enemies/zombie_hurt_01.wav",
			"sounds/enemies/zombie_hurt_02.wav",
			"sounds/enemies/zombie_hurt_03.wav",
			"sounds/enemies/zombie_hurt_04.wav",
			"sounds/enemies/zombie_hurt_05.wav",
			"sounds/enemies/zombie_hurt_06.wav",
			"sounds/enemies/zombie_hurt_07.wav",
            "sounds/enemies/zombie_death_01.wav",
			"sounds/enemies/zombie_death_02.wav",
			"sounds/enemies/zombie_death_03.wav",
			"sounds/enemies/zombie_death_04.wav",
			"sounds/enemies/zombie_death_05.wav",
			"sounds/enemies/zombie_death_06.wav",
            "sounds/enemies/zombie_idle_01.wav",
			"sounds/enemies/zombie_idle_02.wav",
			"sounds/enemies/zombie_idle_03.wav",
			"sounds/enemies/zombie_idle_04.wav",
			"sounds/enemies/zombie_idle_05.wav",
			"sounds/enemies/zombie_idle_06.wav",
			"sounds/enemies/zombie_idle_07.wav",
			"sounds/enemies/zombie_idle_08.wav",
			"sounds/enemies/zombie_idle_09.wav",
			"sounds/enemies/zombie_idle_10.wav",
			"sounds/enemies/zombie_idle_11.wav",
			"sounds/enemies/zombie_idle_12.wav",
			"sounds/enemies/zombie_idle_13.wav",
			"sounds/enemies/zombie_idle_14.wav",
			"sounds/enemies/zombie_idle_15.wav",
			"sounds/enemies/zombie_idle_16.wav",
            "sounds/enemies/zombie_rise_01.wav",
			"sounds/enemies/zombie_rise_02.wav",
			"sounds/enemies/zombie_rise_03.wav",
			"sounds/enemies/zombie_rise_04.wav"
		],
		Spirit = 0,
		Scripts = [],
	},
	function create()
	{
		this.m.ID = "special.uber_necro_raise_dead";
		this.m.Name = "Rise!!";
		this.m.Description = "Through an unknown pact with fark only knows what, this one has gained the ability to raise an endless army of zombies.";
		this.m.Icon = "skills/status_effect_07.png";
		this.m.IconMini = ""; //there is no mini icon for 07
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.SoundOnUse = [
			"sounds/enemies/zombie_rise_01.wav",
			"sounds/enemies/zombie_rise_02.wav",
			"sounds/enemies/zombie_rise_03.wav",
			"sounds/enemies/zombie_rise_04.wav"
		];

		this.m.Scripts = ::MSU.Class.WeightedContainer([
			[20, "scripts/entity/tactical/zombie"],
			[40, "scripts/entity/tactical/zombie_yeoman"],
			[30, "scripts/entity/tactical/zombie_nomad"],
			[10, "scripts/entity/tactical/zombie_knight_bodyguard"],
		]);
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.Sounds )
		{
			this.Tactical.addResource(r);
		}
	}

	function onCombatStarted()
	{
		this.m.Spirit = 0; //start each battle at zero
	}

	function onTurnEnd()
	{
		this.m.Spirit += ::Math.rand(15,35);

		while(::Math.rand(0,100) < this.m.Spirit)
		{
			if(!this.raiseTheDead() ) break;
		}
	}

    function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
        this.m.Spirit += _damageHitpoints;
	}

	function raiseTheDead()
	{
		local tile = this.findEmptyTile();
		if( tile == null ) return false;

		this.useForFree(tile);

        return true;
	}

	function onUse( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(this.m.Scripts.roll(), tile.Coords.X, tile.Coords.Y);
		entity.setFaction(::Const.Faction.Undead);

		//consume spirit
		this.m.Spirit = ::Math.max(0, this.m.Spirit - 50);
	}

	function findEmptyTile()
	{
		local actor = this.getContainer().getActor();
		if( actor == null || actor.isNull() ) return null;

		local tile = actor.getTile();
        if( tile == null ) return null;

        local possibleTiles = [];

		for( local i = 0; i != 6; ++i )
        {
            if (!tile.hasNextTile(i)) { continue; }
            local targetTile = tile.getNextTile(i);

            if ( targetTile.IsOccupiedByActor ) { continue; }

			possibleTile.push(targetTile);

            //distance of 2
            for( local i = 0; i != 6; ++i )
            {
                if (!targetTile.hasNextTile(i)) { continue; }
                local targetTile2 = targetTile.getNextTile(i)

                if ( targetTile2.IsOccupiedByActor ) { continue; }

                possibleTile.push(targetTile2);
            }
		}

        if(possibleTiles.len() == 0) return null;

		return ::MSU.Array.rand(possibleTiles);
	}
});