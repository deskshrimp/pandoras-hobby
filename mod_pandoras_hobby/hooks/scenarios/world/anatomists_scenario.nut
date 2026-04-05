::PandorasHobby.MH.hook("scripts/scenarios/world/anatomists_scenario", function(q) {

    q.onSpawnAssets = @(__original) function()
    {
        __original();
        ::World.Statistics.getFlags().set("isConquerorPotionAcquired", false);

		//give the unarmed bro a scalpel
		local roster = this.World.getPlayerRoster();
		local bros = roster.getAll();
		bros[0].getItems().equip(this.new("scripts/items/weapons/ph_scalpel"));
    }
    

    q.onActorKilled = @(__original) function( _actor, _killer, _combatID )
    {
	
		__original( _actor, _killer, _combatID );
		
		if(_actor.getType() == ::Const.EntityType.SkeletonBoss)
		{
			::World.Statistics.getFlags().set("shouldDropConquerorPotion",true);
		}		
    }

    q.onBattleWon = @(__original) function( _combatLoot )
    {		
		local acquiredFlagName = "isConquerorPotionAcquired";
		local discoveredFlagName = "isConquerorPotionDiscovered";
		local shouldDropFlagName = "shouldDropConquerorPotion";
		local itemName = "ph_conqueror_potion_item";
	
		if (!::World.Statistics.getFlags().get(acquiredFlagName) && ::World.Statistics.getFlags().get(shouldDropFlagName))
		{
			::World.Statistics.getFlags().set(acquiredFlagName, true);
			::World.Statistics.getFlags().set(discoveredFlagName, true);
			_combatLoot.add(this.new("scripts/items/misc/ph_anatomist/" + itemName));
		}
		
		__original( _combatLoot );
    }

    q.onCombatFinished = @(__original) function()
	{
        ::World.Statistics.getFlags().set("shouldDropConquerorPotion",false);
		
		return __original();		
    }
});

//update the notebook as well
::PandorasHobby.MH.hook("scripts/items/misc/anatomist/research_notes_legendary_item", function(q) {
    q.getTooltip = @(__original) function()
    {
        local ret = __original();
        if(::World.Statistics.getFlags().get("isConquerorPotionDiscovered"))
        {
            ret.push({
			    id = 15,
			    type = "text",
			    icon = "ui/icons/special.png",
		        text = "The Conqueror: Skulltaker's Essence"
		    });
        }
        return ret;
    }
});