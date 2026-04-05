this.ph_cultist_potion_03_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_03";
		this.m.Name = "Potion of the Acolyte";
        this.m.Effect = "Imbibe to wriggle closer to Davkul.";
        this.m.Tier = 3;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_03.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{		
		//are they a T2 Cultist?
		if( this.getCultistTier(_actor) != 2 ) return false;
		
		//call parent to handle inflicting necessary ailments (in case they removed them!)
        this.ph_cultist_potion_item.onUse(_actor);

		//Remove T2
		_actor.getSkills().removeByID("trait.cultist_zealot");

        //Make them T3
        _actor.getSkills().add( ::new("scripts/skills/traits/cultist_acolyte_trait") );
        
		return true;
	}
});