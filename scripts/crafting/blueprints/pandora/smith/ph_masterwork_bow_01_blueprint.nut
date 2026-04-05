this.ph_masterwork_bow_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_masterwork_bow_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/weapons/masterwork_bow");
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/weapons/war_bow",
				Num = 1
			},
			{
				Script = "scripts/items/trade/quality_wood_item",
				Num = 2
			},
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/weapons/masterwork_bow"));
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

