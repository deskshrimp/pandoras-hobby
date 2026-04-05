this.ph_unbreakable_will_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_unbreakable_will_potion_02";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/ph_unbreakable_will_potion_item");
		this.m.Cost = 300;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_hyena_gland_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_ghoul_brain_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ph_spider_eyes_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
		_stash.add(this.new("scripts/items/accessory/ph_unbreakable_will_potion_item"));
	}

	function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine | ::PandorasHobby.Follower.Skill.Alch_Potions_1))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Medicine | ::PandorasHobby.Follower.Skill.Alch_Potions_1))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}
});

