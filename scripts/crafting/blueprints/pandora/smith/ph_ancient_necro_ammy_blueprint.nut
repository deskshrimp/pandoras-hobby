this.ph_ancient_necro_ammy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_ancient_necro_ammy";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legendary/ph_ancient_necro_ammy_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_skele_skull_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/ph_skele_jewelry_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_skele_sternum_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_skele_clavicle_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_warlock_hair_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legendary/ph_ancient_necro_ammy_item"));
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