this.ph_rc_ancient_amber_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_rc_ancient_amber_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
		this.m.PreviewCraftable = this.new("scripts/items/loot/ancient_amber_item");
		this.m.Cost = 200;
		local ingredients = [
			{
				Script = "scripts/items/trade/amber_shards_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/acidic_saliva_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/loot/ancient_amber_item"));
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

