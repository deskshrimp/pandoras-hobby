this.ph_named_lindwurm_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_named_lindwurm_shield";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
		this.m.PreviewCraftable = this.new("scripts/items/shields/named/ph_named_craftable_lindwurm_shield");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/shields/special/craftable_lindwurm_shield",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_wurm_scales_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/shields/named/ph_named_craftable_lindwurm_shield"));
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

