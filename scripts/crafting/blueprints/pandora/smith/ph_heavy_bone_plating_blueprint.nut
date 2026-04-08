this.ph_heavy_bone_plating_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_heavy_bone_plating";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Upgrade;
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/legendary/ph_champ_bone_plating_upgrade");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_unhold_bones_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/armor_upgrades/legendary/ph_champ_bone_plating_upgrade"));
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