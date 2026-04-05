this.ph_potion_of_oblivion_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_potion_of_oblivion_02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
		this.m.PreviewCraftable = this.new("scripts/items/misc/potion_of_oblivion_item");
		this.m.Cost = 7500;
		local ingredients = [
			{
				Script = "scripts/items/supplies/wine_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/acidic_saliva_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/poison_gland_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/soul_splinter_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/snake_oil_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/potion_of_oblivion_item"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

