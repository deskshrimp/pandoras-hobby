this.ph_toothed_throwing_net_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_toothed_throwing_net_01";
		this.m.PreviewCraftable = this.new("scripts/items/tools/ph_toothed_throwing_net");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_broken_net",
				Num = 2
			},
			{
				Script = "scripts/items/misc/spider_silk_item",
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
		if( !::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Net_Master) )
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

