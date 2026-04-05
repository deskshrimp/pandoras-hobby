this.ph_strange_shrooms_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_strange_shrooms_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/berserker_mushrooms_item");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/supplies/pickled_mushrooms_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/spices_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
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

