// ********** Must add checks to every potion effect to prevent incomplete potions from messing with scenario flags! ***********************


::PandorasHobby.MH.hook("scripts/skills/effects/alp_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/ancient_priest_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/direwolf_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/fallen_hero_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/geist_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/goblin_grunt_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/goblin_overseer_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/goblin_shaman_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/hexe_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/honor_guard_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/hyena_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/ifrit_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/ijirok_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/kraken_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/lindwurm_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/lorekeeper_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/nachzehrer_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/necromancer_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/necrosavant_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/orc_berserker_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/orc_warlord_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/orc_warrior_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/orc_young_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/rachegeist_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/schrat_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/serpent_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/skeleton_warrior_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/unhold_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/webknecht_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/wiederganger_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original( _fatalityType );
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});




//The three new legendary pots do not include the arg for fatalityType?
//Fixed in latest version of the game, but older versions have this bug
//Using a flag to detect when no value is being sent

::PandorasHobby.MH.hook("scripts/skills/effects/lesser_flesh_golem_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType = 9999 )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {  
            if(_fatalityType != 9999)
            {
                __original( _fatalityType );                
            }
            else
            {
                __original();
            }
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/greater_flesh_golem_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType = 9999 )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            if(_fatalityType != 9999)
            {
                __original( _fatalityType );                
            }
            else
            {
                __original();
            }
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});

::PandorasHobby.MH.hook("scripts/skills/effects/grand_diviner_potion_effect", function(q) {
    q.onDeath = @(__original) function( _fatalityType = 9999 )
	{
        if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            if(_fatalityType != 9999)
            {
                __original( _fatalityType );                
            }
            else
            {
                __original();
            }
        }
        //else block it
	}

	q.onDismiss = @(__original) function()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
        {            
            __original();
        }
        //else block it
	}
});