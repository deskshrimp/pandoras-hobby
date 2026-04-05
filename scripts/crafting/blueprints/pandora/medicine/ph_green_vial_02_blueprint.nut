this.ph_green_vial_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_green_vial_02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/special/bodily_reward_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_unhold_liver_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/growth_pearls_item",
				Num = 3
			},
			{
				Script = "scripts/items/loot/ph_bros_coin_01_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
		_stash.add(this.new("scripts/items/special/bodily_reward_item"));
	}

	function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine | ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine | ::PandorasHobby.Follower.Skill.Alch_Potions_2))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}
});

