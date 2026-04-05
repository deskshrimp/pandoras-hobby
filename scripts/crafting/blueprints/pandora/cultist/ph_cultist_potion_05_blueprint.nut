this.ph_cultist_potion_05_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_cultist_potion_05";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Cultist;
		this.m.PreviewCraftable = this.new("scripts/items/special/ph_cultist_potion_05_item");
		this.m.Cost = 999;
		local ingredients = [
			{
				Script = "scripts/items/loot/ph_bros_coin_04_item",
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
		_stash.add(this.new("scripts/items/special/ph_cultist_potion_05_item"));
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

