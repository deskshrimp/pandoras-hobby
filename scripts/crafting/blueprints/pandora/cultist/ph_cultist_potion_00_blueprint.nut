this.ph_cultist_potion_00_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_cultist_potion_00";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Cultist;
		this.m.PreviewCraftable = this.new("scripts/items/special/ph_cultist_potion_00_item");
		this.m.Cost = 42;
		local ingredients = [
			{
				Script = "scripts/items/supplies/wine_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/poison_gland_item",
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
		_stash.add(this.new("scripts/items/special/ph_cultist_potion_00_item"));
	}

	function isCraftable()
	{
		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist))
		{
			return false;
		}
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Cultist))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist))
		{
			return false;
		}
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Cultist))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

