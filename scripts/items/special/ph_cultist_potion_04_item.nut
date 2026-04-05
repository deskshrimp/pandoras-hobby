this.ph_cultist_potion_04_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_04";
		this.m.Name = "Potion of the Disciple";
        this.m.Effect = "Imbibe to stumble closer to Davkul.";
        this.m.Tier = 4;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_04.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{		
		//are they a T3 Cultist?
		if( this.getCultistTier(_actor) != 3 ) return false;
		
		//call parent to handle inflicting necessary ailments (in case they removed them!)
        this.ph_cultist_potion_item.onUse(_actor);

		//Remove T3
		_actor.getSkills().removeByID("trait.cultist_acolyte");

        //Make them T4
        _actor.getSkills().add( ::new("scripts/skills/traits/cultist_disciple_trait") );
        
		return true;
	}
});