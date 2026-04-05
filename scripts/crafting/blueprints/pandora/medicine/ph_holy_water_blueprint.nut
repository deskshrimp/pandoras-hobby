this.ph_holy_water_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_holy_water";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Misc; //not actually crafting
		this.m.PreviewCraftable = this.new("scripts/items/tools/holy_water_item");
		this.m.Cost = 777;
		local ingredients = [
			{
				Script = "scripts/items/supplies/wine_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

    function getName()
	{
		return this.m.PreviewCraftable.getName() + " x3";
	}

	function getDescription()
	{
		return "For a tithe plus a small service fee, I can get all the blessed water you need. Great against the undead.";
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/holy_water_item"));
		_stash.add(this.new("scripts/items/tools/holy_water_item"));
		_stash.add(this.new("scripts/items/tools/holy_water_item"));		
	}

	function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Holywater))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Holywater))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

