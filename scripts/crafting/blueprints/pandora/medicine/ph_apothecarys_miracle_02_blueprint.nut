this.ph_apothecarys_miracle_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_apothecarys_miracle_02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/misc/miracle_drug_item");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/adrenaline_gland_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/growth_pearls_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
		_stash.add(this.new("scripts/items/misc/miracle_drug_item"));
	}

	function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}
});

