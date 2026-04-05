this.ph_strange_shrooms_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_strange_shrooms_02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/berserker_mushrooms_item");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/misc/ancient_wood_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_brain_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function getName()
	{
		return this.m.PreviewCraftable.getName() + " x3";
	}

	function onCraft( _stash )
	{		
		_stash.add(this.new("scripts/items/accessory/berserker_mushrooms_item"));
		_stash.add(this.new("scripts/items/accessory/berserker_mushrooms_item"));
		_stash.add(this.new("scripts/items/accessory/berserker_mushrooms_item"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

