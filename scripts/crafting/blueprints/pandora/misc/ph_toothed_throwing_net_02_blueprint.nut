this.ph_toothed_throwing_net_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_toothed_throwing_net_02";
		this.m.PreviewCraftable = this.new("scripts/items/tools/ph_toothed_throwing_net");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/tools/reinforced_throwing_net",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_teeth_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/ph_toothed_throwing_net"));
	}

	function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Net_Master))
		{
			return false;
		}
		if( ::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Steward).getAge() != ::PandorasHobby.Follower.Age.Old )
		{
			return false;
		}
		return this.blueprint.isCraftable();		
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Net_Master))
		{
			return false;
		}
		if( ::World.Retinue.PH_getFollowerAtIndex(::PandorasHobby.Follower.Archetype.Steward).getAge() != ::PandorasHobby.Follower.Age.Old )
		{
			return false;
		}
		return this.blueprint.isQualified();
	}
});

