this.ph_twig_liver_mash_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_twig_liver_mash_upgrade";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/named/ph_twig_liver_mash_upgrade");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_schrat_sprouts_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_unhold_liver_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/armor_upgrades/named/ph_twig_liver_mash_upgrade"));
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