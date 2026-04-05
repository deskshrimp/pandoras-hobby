this.ph_rc_thick_white_fur_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_rc_thick_white_fur_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
		this.m.PreviewCraftable = this.new("scripts/items/misc/frost_unhold_fur_item");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/misc/werewolf_pelt_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/acidic_saliva_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/frost_unhold_fur_item"));
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}

});

