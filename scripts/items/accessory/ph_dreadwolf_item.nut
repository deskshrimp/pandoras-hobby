this.ph_dreadwolf_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "scripts/entity/tactical/ph_dreadwolf",
		UnleashSounds = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_04.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav"
		]
	},
	function isAllowedInBag()
	{
		return false;
	}

	function getScript()
	{
		return this.m.Script;
	}

	function isUnleashed()
	{
		return this.m.Entity != null;
	}

	function getName()
	{
		if (this.m.Entity == null)
		{
			return this.item.getName();
		}
		else
		{
			return "Dreadwolf Collar";
		}
	}

	function getDescription()
	{
		if (this.m.Entity == null)
		{
			return this.item.getDescription();
		}
		else
		{
			return "The collar of a Dreadwolf that has been unleashed onto the battlefield. The old gods take them.";
		}
	}

	function create()
	{
		this.accessory.create();
		this.m.Variant = this.Math.rand(1, 3);
		this.updateVariant();
		this.m.ID = "accessory.ph_dreadwolf";
		this.m.Name = ::Const.Strings.DreadwolfNames[this.Math.rand(0, ::Const.Strings.DreadwolfNames.len() - 1)] + " the Dreadwolf";
        this.m.Description = "A blood thirsty beast created through experiments to unlock the ancestral powers of wolves. Excels at cutting down routed enemies.";		
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Value = 1800;
	}

	function playInventorySound( _eventType )
	{
		if (this.Math.rand(1, 100) <= 50)
		{			
			this.Sound.play(this.m.UnleashSounds[this.Math.rand(0, this.m.UnleashSounds.len() - 1)], ::Const.Sound.Volume.Inventory);
		}
	}

	function updateVariant()
	{
		this.setEntity(this.m.Entity);
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/hound_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/ph_dreadwolf_0" + this.m.Variant + "_70x70.png";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();
		local unleash = this.new("scripts/skills/actives/ph_unleash_dreadwolf");
		unleash.setItem(this);
		this.m.Skill = this.WeakTableRef(unleash);
		this.addSkill(unleash);
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onActorDied( _onTile )
	{
		if (_onTile == null)
		{
			return;
		}

		if (!this.isUnleashed())
		{
			if (!_onTile.IsEmpty)
			{
				for( local i = 0; i < 6; i = ++i )
				{
					if (!_onTile.hasNextTile(i))
					{
					}
					else
					{
						local t = _onTile.getNextTile(i);

						if (t.IsEmpty)
						{
							_onTile = t;
							break;
						}
					}
				}

				if (!_onTile.IsEmpty)
				{
					return;
				}
			}

			local entity = this.Tactical.spawnEntity(this.getScript(), _onTile.Coords.X, _onTile.Coords.Y);
			entity.setItem(this);
			entity.setName(this.getName());
			entity.setVariant(this.getVariant());
			this.setEntity(entity);
			entity.setFaction(this.Const.Faction.PlayerAnimals);

			if (this.m.ArmorScript != null)
			{
				local item = this.new(this.m.ArmorScript);
				entity.getItems().equip(item);
			}

			this.Sound.play(this.m.UnleashSounds[this.Math.rand(0, this.m.UnleashSounds.len() - 1)], this.Const.Sound.Volume.Skill, _onTile.Pos);
		}
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onSerialize( _out )
	{
		this.accessory.onSerialize(_out);
		_out.writeString(this.m.Name);
	}

	function onDeserialize( _in )
	{
		this.accessory.onDeserialize(_in);
		this.m.Name = _in.readString();
	}

});

