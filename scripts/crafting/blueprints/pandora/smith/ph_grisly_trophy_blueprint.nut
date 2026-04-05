this.ph_grisly_trophy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_grisly_trophy";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legendary/ph_grisly_trophy_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_alp_eye_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_ghoul_guts_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_warlock_hair_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_skele_clavicle_item",
				Num = 1
			},			
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legendary/ph_grisly_trophy_item"));
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