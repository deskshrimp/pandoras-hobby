this.ph_cultist_potion_01_item <- this.inherit("scripts/items/special/ph_cultist_potion_item", {
	m = {},
	function create()
	{
        this.ph_cultist_potion_item.create();

		this.m.ID = "accessory.ph_cultist_potion_01";
		this.m.Name = "Potion of Fanaticism";
        this.m.Effect = "Imbibe to crawl closer to Davkul.";
        this.m.Tier = 1;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_cultist_pot_01.png";
		this.m.Value = this.m.Tier;
	}

	function onUse( _actor, _item = null )
	{	
		//are they a T0 Cultist?
		if( this.getCultistTier(_actor) != 0 ) return false;
		
		//call parent to handle inflicting necessary ailments (in case they removed them!)
        this.ph_cultist_potion_item.onUse(_actor);

        //Make them a T1
        _actor.getSkills().add( ::new("scripts/skills/traits/cultist_fanatic_trait") );
        
		return true;
	}
});