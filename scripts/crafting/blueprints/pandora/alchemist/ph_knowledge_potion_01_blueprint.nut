this.ph_knowledge_potion_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_knowledge_potion_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
		this.m.PreviewCraftable = this.new("scripts/items/misc/potion_of_knowledge_item");
		this.m.Cost = 300;
		local ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/petrified_scream_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/glowing_resin_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/potion_of_knowledge_item"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Potions_1))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Potions_1))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

