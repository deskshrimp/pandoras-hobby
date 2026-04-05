this.ph_fangshire_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_fangshire_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/helmets/legendary/fangshire");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_vamp_skull_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/werewolf_pelt_item",
				Num = 2
			},
			{
				Script = "scripts/items/accessory/night_vision_elixir_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/helmets/legendary/fangshire"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Smith_Recipes))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Smith_Recipes))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

