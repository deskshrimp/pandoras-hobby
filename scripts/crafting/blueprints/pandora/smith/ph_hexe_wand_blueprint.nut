this.ph_hexe_wand_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_hexe_wand";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/weapons/legendary/ph_hexe_wand");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/weapons/greenskins/goblin_staff",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_goblin_fetish_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_hexe_head_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_alp_eye_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/ph_ancient_tome_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/weapons/legendary/ph_hexe_wand"));
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