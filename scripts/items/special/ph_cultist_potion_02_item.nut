this.ph_cultist_potion_02_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_02";
		this.m.Name = "Potion of Zealotry";
        this.m.Effect = "Imbibe to slither closer to Davkul.";
        this.m.Tier = 2;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_02.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{		
		//are they a T1 Cultist?
		if( this.getCultistTier(_actor) != 1 ) return false;
		
		//call parent to handle inflicting necessary ailments (in case they removed them!)
        this.ph_cultist_potion_item.onUse(_actor);

		//Remove T1
		_actor.getSkills().removeByID("trait.cultist_fanatic");

        //Make them a T2
        _actor.getSkills().add( ::new("scripts/skills/traits/cultist_zealot_trait") );
        
		return true;
	}
});