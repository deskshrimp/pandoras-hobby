this.ph_rations_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_rations_02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Food;
		this.m.PreviewCraftable = this.new("scripts/items/supplies/cured_rations_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/supplies/dried_fish_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/dried_fruits_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/cured_venison_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/spices_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function getName()
	{
		return this.m.PreviewCraftable.getName() + " x5";
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/cured_rations_item"));
		_stash.add(this.new("scripts/items/supplies/cured_rations_item"));
		_stash.add(this.new("scripts/items/supplies/cured_rations_item"));
		_stash.add(this.new("scripts/items/supplies/cured_rations_item"));
		_stash.add(this.new("scripts/items/supplies/cured_rations_item"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Cook_Recipes))
		{
			return false;
		}		
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Cook_Recipes))
		{
			return false;
		}		
		return this.blueprint.isQualified();
	}

});

