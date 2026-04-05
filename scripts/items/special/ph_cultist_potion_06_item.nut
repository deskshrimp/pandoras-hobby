this.ph_cultist_potion_06_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_06";
		this.m.Name = "Potion of Prophecy";
        this.m.Effect = "Imbibe to speak to Davkul.";
        this.m.Tier = 6;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_06.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{		
		//are they a T5 Cultist?
		if( this.getCultistTier(_actor) != 5 ) return false;
		
		//call parent to handle inflicting necessary ailments (in case they removed them!)
        this.ph_cultist_potion_item.onUse(_actor);

		//Remove T5
		_actor.getSkills().removeByID("trait.cultist_chosen");

        //Make them T6
        _actor.getSkills().add( ::new("scripts/skills/traits/cultist_prophet_trait") );
        
		return true;
	}
});