this.ph_unknown_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_unknown_potion";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Anatomist;
		this.m.PreviewCraftable = this.new("scripts/items/misc/anatomist/ph_unknown_potion_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/ph_generic_sample_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/snake_oil_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{		
		local item = ::new("scripts/items/misc/anatomist/ph_unknown_potion_item");
		item.setVariant(101); //set a flag to indicate the potion was crafted!
		_stash.add(item);
	}

    function isCraftable()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
		{
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if(!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
		{
			return false;
		}
		return this.blueprint.isQualified();
	}
});