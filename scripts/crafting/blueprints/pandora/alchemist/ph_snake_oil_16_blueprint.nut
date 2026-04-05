this.ph_snake_oil_16_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_snake_oil_16";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.SnakeOil;
		this.m.PreviewCraftable = this.new("scripts/items/misc/snake_oil_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/misc/parched_skin_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_brain_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/ghoul_teeth_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/snake_oil_item"));

        if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_2x) )
        {
            if(::Math.rand(0,100) < 10)
            {
                _stash.add(this.new("scripts/items/misc/snake_oil_item"));
            }
        }
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

