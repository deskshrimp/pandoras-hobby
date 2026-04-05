this.ph_small_med_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.ph_small_med_01";
		this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Medicine;
		this.m.PreviewCraftable = this.new("scripts/items/supplies/medicine_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function getName()
	{
		return "Small bundle of medical supplies";
	}

	function getDescription()
	{
		return "Produces a small bundle of 10 to 25 medical supplies.";
	}

	function onCraft( _stash )
	{
		local meds = this.new("scripts/items/supplies/medicine_item");
		meds.setAmount(::Math.rand(10, 25));
		_stash.add(meds);
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

