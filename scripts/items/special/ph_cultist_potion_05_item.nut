this.ph_cultist_potion_05_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_05";
		this.m.Name = "Potion of Selection";
        this.m.Effect = "Imbibe to writhe for Davkul.";
        this.m.Tier = 5;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_05.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{		
		//are they a T4 Cultist?
		if( this.getCultistTier(_actor) != 4 ) return false;
		
		//call parent to handle inflicting necessary ailments (in case they removed them!)
        this.ph_cultist_potion_item.onUse(_actor);

		//Remove T4
		_actor.getSkills().removeByID("trait.cultist_disciple");

        //Make them T5
        _actor.getSkills().add( ::new("scripts/skills/traits/cultist_chosen_trait") );
        
		return true;
	}
});