this.ph_dreadwolf <- this.inherit("scripts/entity/tactical/enemies/direwolf", {
    m = {
        Item = null,
		Name = "Dread Warwolf"
    },
    function setItem( _i )
	{
		if (typeof _i == "instance")
		{
			this.m.Item = _i;
		}
		else
		{
			this.m.Item = this.WeakTableRef(_i);
		}
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function getName()
	{
		return this.m.Name;
	}

    function create()
    {
        this.direwolf.create();

        this.m.AIAgent = this.new("scripts/ai/tactical/agents/wardog_agent");
		this.m.AIAgent.setActor(this);
    }

    function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(0, 100) < 50;

		if (_tile != null)
		{
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");			
			decal = _tile.spawnDetail("bust_direwolf_01_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;
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

		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.setEntity(null);

			if (this.m.Item.getContainer() != null && !this.m.Item.getContainer().isNull())
			{
				if (this.m.Item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
				{
					this.m.Item.getContainer().removeFromBag(this.m.Item.get());
				}
				else
				{
					this.m.Item.getContainer().unequip(this.m.Item.get());
				}
			}

			this.m.Item = null;
		}

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

    function generateCorpse( _tile, _fatalityType, _killer )
	{
		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = this.getName();
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
        corpse.IsResurrectable = false;

		if (_tile != null)
		{
			corpse.Tile = _tile;
		}

		return corpse;
	}

    function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);		
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);

		if (!this.Tactical.State.isScenarioMode())
		{
			local f = this.World.FactionManager.getFaction(this.getFaction());

			if (f != null)
			{
				this.getSprite("socket").setBrush(f.getTacticalBase());
			}
		}
		else
		{
			this.getSprite("socket").setBrush(this.Const.FactionBase[this.getFaction()]);
		}
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);

		if (this.getFaction() == this.Const.Faction.Player || this.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

			foreach( bro in brothers )
			{
				if (bro.getCurrentProperties().IsAllyXPBlocked)
				{
					return;
				}

				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	function setVariant( _v )
	{
		this.m.Items.getAppearance().Body = "bust_direwolf_0" + _v;
		this.getSprite("body").setBrush("bust_direwolf_0" + _v);
		this.getSprite("head").setBrush("bust_direwolf_0" + _v + "_head");
		this.setDirty(true);
	}

    function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.DreadWarWolf);
        b.TargetAttractionMult = 0.5;
        b.IsAffectedByInjuries = false;
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;		
		local variant = 2;
		this.m.Items.getAppearance().Body = "bust_direwolf_0" + variant;
        this.addSprite("socket").setBrush("bust_base_player");
		local body = this.addSprite("body");
		body.setBrush("bust_direwolf_0" + variant);

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_direwolf_0" + variant + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));

		this.m.Skills.add(this.new("scripts/skills/actives/werewolf_bite"));
		//this.m.Skills.add(this.new("scripts/skills/actives/wolf_bite"));
		
        this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));

		//need to see how squichy these dogs are, if needed bump their stats or give them on of these perks
		//they are rather expensive, so keeping them around is best	[can always nerf their bite down to wolf bite to compensate]
		//this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_poise"));
		//this.m.Skills.add(this.new("scripts/skills/perk_dodge"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium;		
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		
		//HD added this to Warwolf, might as well add it here
		if ( ::Hooks.hasMod("mod_hardened") )
		{
			this.getSkills().add(::new("scripts/skills/effects/hd_bite_reach"));
		}
	}
});