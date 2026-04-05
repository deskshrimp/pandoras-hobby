this.ph_blue_vial_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_blue_vial_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
		this.m.PreviewCraftable = this.new("scripts/items/special/spiritual_reward_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/loot/ph_bros_coin_04_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/ph_bros_coin_03_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/ph_bros_coin_02_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/ph_bros_coin_01_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/ph_bros_coin_00_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/snake_oil_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
		local item = this.new("scripts/items/special/spiritual_reward_item");
		item.setVariant(100);
		_stash.add(item);
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine | ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine | ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

