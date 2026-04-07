::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/direwolf", function(q) {
    
    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        this.getSprite("body").setBrush("ph_bust_direwolf_champ");
        this.getSprite("head").setBrush("ph_bust_direwolf_champ_head");
        if (this.isKindOf(this, "direwolf_high"))
        {
            this.getSprite("head_frenzy").setBrush("bust_direwolf_03_head_frenzy");
        }
        
        //buff base stats
        local baseProperties = this.m.BaseProperties;
	    baseProperties.Bravery += 20;        
        baseProperties.MeleeDefense += 5;
	    baseProperties.RangedDefense += 5;
        baseProperties.ArmorMax[0] += 50;
		baseProperties.ArmorMax[1] += 50;
		baseProperties.Armor = clone b.ArmorMax;

        //Add skills
        if (this.getSkills().hasSkill("perk.overwhelm"))
			this.getSkills().add(::new("scripts/skills/perks/perk_fearsome"));
		else
			this.getSkills().add(::new("scripts/skills/perks/perk_overwhelm"));

        return true;
    }
    
    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {
                //unique loot (vanilla is 70/30 for pelt/gland)
                local drops = ::MSU.Class.WeightedContainer([
                    [30, "ph_hyena_gland_item"],
                    [60, "ph_wolf_pelt_item"],
                ]);
                ret.push(::new("scripts/items/misc/" + drops.roll() ));

                //let high drop and extra item!
                if ( this.isKindOf(this, "direwolf_high") )
				{
                    ret.push(::new("scripts/items/misc/" + drops.roll() ));					
				}

                //and add some regular loot                
                ret.push(::new("scripts/items/supplies/strange_meat_item"));
                ret.push(::new("scripts/items/supplies/strange_meat_item"));

                ret.push(this.new("scripts/items/loot/sabertooth_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {                    
                    this.PH_AttemptIncompletePotionDrop( ret, "direwolf", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
        }

        return ret;
    }

    q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
    {
        if(!this.m.IsMiniboss)
        {
            __original( _killer, _skill, _tile, _fatalityType );
            return;
        }

        local flip = this.Math.rand(0, 100) < 50;

		if (_tile != null)
		{
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local head_frenzy = this.getSprite("head_frenzy");
			decal = _tile.spawnDetail("ph_bust_direwolf_champ_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;

				if (head_frenzy.HasBrush)
				{
					decal = _tile.spawnDetail("bust_direwolf_03_head_dead_frenzy", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];

				if (head_frenzy.HasBrush)
				{
					layers.push("bust_direwolf_03_head_dead_frenzy");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;

				if (head_frenzy.HasBrush)
				{
					decap[1].Scale = 0.95;
				}
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
		}

        local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null)
		{
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		}
		else
		{
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    }    
});
