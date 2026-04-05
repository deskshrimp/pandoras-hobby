this.ph_banner_heavy_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_banner_heavy_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/tools/ph_player_banner_heavy");        
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/tools/player_banner",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{        
		_stash.add(this.new("scripts/items/tools/ph_player_banner_heavy"));		
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