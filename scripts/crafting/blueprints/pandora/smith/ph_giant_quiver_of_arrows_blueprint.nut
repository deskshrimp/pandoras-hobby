this.ph_giant_quiver_of_arrows_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_giant_quiver_of_arrows";
		this.m.PreviewCraftable = this.new("scripts/items/ammo/ph_giant_quiver_of_arrows");
		this.m.Cost = 600;
		local ingredients = [
			{
				Script = "scripts/items/ammo/large_quiver_of_arrows",
				Num = 1
			},
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/ammo/ph_giant_quiver_of_arrows"));
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

