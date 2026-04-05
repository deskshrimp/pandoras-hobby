::PandorasHobby.MH.hook("scripts/entity/tactical/player", function(q) {
	
    //we cannot use isReallyKilled since the multiple hooks wont execute in the correct order.
    //so, instead we can modify this call to ensure they are flagged as dead
    
	q.kill = @(__original) function( _killer = null, _skill = null, _fatalityType = ::Const.FatalityType.None, _silent = false )
    {
        if(this.m.Skills.hasSkill("effects.ph_barb_king_potion"))
        {
            if(_fatalityType == ::Const.FatalityType.None)
            {
               _fatalityType = ::Const.FatalityType.Decapitated;
            }

            //just bypass the original method's attempt to save them to make sure the fatality sticks!
            this.actor.kill(_killer, _skill, _fatalityType, _silent);
        }
        else
        {
            __original( _killer, _skill, _fatalityType, _silent );
        }
    }

    q.PH_isCultist <- function()
    {
        return this.getBackground().PH_isCultist();
    }

    q.PH_hasMutations <- function()
    {
        return (this.getFlags().getAsInt("ActiveMutations") > 0);
    }

    q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType ) {
		//we want to make sure our drops happen, but we don't want to mess with the rest of the code
		local dropTile = _tile;
		if(dropTile == null)
		{
			dropTile = _killer.getTile();
		}

		if (!this.isGuest() && _fatalityType != ::Const.FatalityType.Unconscious && !this.Tactical.State.isScenarioMode() && dropTile != null)
		{
			//drop unique items
			//handle the cutlist blessing options
			if( ::World.Assets.getOrigin().getID() != "scenario.cultists" ) 
			{
				//refund if the prophet dies
				if( this.getSkills().hasSkill("trait.cultist_prophet") )
				{
					local loot = ::new("scripts/items/loot/ph_davkuls_favor");
		    		loot.setBrothersName(this.getName());
				    loot.drop(dropTile);
				}

				//grant if a good cultist dies
				if ( this.getLevel()>= 11 && this.getSkills().hasSkill("trait.cultist_chosen") && !::World.Flags.get("ph_DavkulsFavorReceived") )
				{
					local loot = ::new("scripts/items/loot/ph_davkuls_favor");
		    		loot.setBrothersName(this.getName());
			    	loot.drop(dropTile);
					::World.Flags.set("ph_DavkulsFavorReceived", true);
				}
			}

            //drop personal effects (only if a healer or steward follower is present)? or just let them drop?
			//if( ::World.Retinue.PH_HasFollowerOfType(::PandorasHobby.Follower.Archetype.Steward) )
			//{
            	if ( this.getLevel() >= 11 )
            	{
    				//this.logInfo("drop spoon " + this.getName() + " L=" + this.getLevel());
	    			local loot = ::new("scripts/items/loot/ph_bros_coin_04_item");
		    		loot.setBrothersName(this.getName());
			    	loot.drop(dropTile);
		    	}
		    	else if ( this.getLevel() >= 8 )
		    	{
				    //this.logInfo("drop gold coin " + this.getName() + " L=" + this.getLevel());
				    local loot = ::new("scripts/items/loot/ph_bros_coin_03_item");
				    loot.setBrothersName(this.getName());

			    	//gold coins offer special stories based on the char, determine if one applies here
			    	if(this.getBackground().getID() == "background.hedge_knight")
			    	{
				    	loot.setVariant(4444);
			    	}
			    	else if(this.getBackground().getID() == "background.thief")
			    	{
				    	loot.setVariant(3333);
			    	}
			    	else if(this.getBackground().getID() == "background.gambler")
			    	{
					    loot.setVariant(2222);
			    	}
			    	else if( this.getSkills().hasSkill("trait.arena_fighter") || this.getSkills().hasSkill("trait.arena_veteran") || this.getSkills().hasSkill("trait.pit_fighter") )
			    	{
				    	loot.setVariant(1111);
			    	}

			    	loot.drop(dropTile);
		    	}
		    	else if ( this.getLevel() >= 6 && ::Math.rand(0,100) <= 80 )
		    	{
			    	//this.logInfo("drop silver coin " + this.getNameOnly() + " L=" + this.getLevel());
			    	local loot = ::new("scripts/items/loot/ph_bros_coin_02_item");
			    	loot.setBrothersName(this.getNameOnly());
			    	loot.drop(dropTile);
		    	}
		    	else if ( this.getLevel() >= 3 && ::Math.rand(0,100) <= 50 )
		    	{
			    	//this.logInfo("drop copper coin " + this.getNameOnly() + " L=" + this.getLevel());
			    	local loot = ::new("scripts/items/loot/ph_bros_coin_01_item");
			    	loot.setBrothersName(this.getNameOnly());
			    	loot.drop(dropTile);
		    	}
		    	else if ( ::Math.rand(0,100) <= 25 )    //level 1 or 2 [not all of these should drop]
		    	{
			    	local loot = ::new("scripts/items/loot/ph_bros_coin_00_item");
			    	loot.setBrothersName(this.getNameOnly());
			    	loot.drop(dropTile);
		    	}
			//}
		}        

	    __original( _killer, _skill, _tile, _fatalityType );
    }
});