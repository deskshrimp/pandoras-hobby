this.ph_cultist_potion_s02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_cultist_potion_s02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Cultist;
		this.m.PreviewCraftable = this.new("scripts/items/special/ph_cultist_potion_02_item");
		this.m.Cost = 333;
		local ingredients = [
			{
				Script = "scripts/items/loot/ph_bros_coin_01_item",
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
		_stash.add(this.new("scripts/items/special/ph_cultist_potion_02_item"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist))
		{
			return false;
		}		
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist))
		{
			return false;
		}		
		return this.blueprint.isQualified();
	}

});

