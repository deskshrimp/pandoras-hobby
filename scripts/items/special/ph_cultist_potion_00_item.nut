this.ph_cultist_potion_00_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_00";
		this.m.Name = "Potion of Devotion";
        this.m.Effect = "Imbibe to begin your journey with Davkul.";
        this.m.Tier = 0;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_00.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{
		//can they become a cultist?
        if ( !this.canBecomeCultist(_actor) ) return false;
		
		//call parent to handle inflicting necessary ailments
        this.ph_cultist_potion_item.onUse(_actor);

        //Make them a Cultist (convert!)
        local background = ::new("scripts/skills/backgrounds/converted_cultist_background");
        _actor.getSkills().removeByID(_actor.getBackground().getID());
        _actor.getSkills().add( background );
		background.buildDescription();
		background.onSetAppearance();
        
		return true;
	}
});