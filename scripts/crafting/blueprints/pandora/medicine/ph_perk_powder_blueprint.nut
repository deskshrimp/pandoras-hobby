this.ph_perk_powder_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_perk_powder";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/special/ph_perk_powder_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_unhold_heart_item",
				Num = 7
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/special/ph_perk_powder_item"));
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

