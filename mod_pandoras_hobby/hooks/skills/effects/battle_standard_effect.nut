::PandorasHobby.MH.hook("scripts/skills/effects/battle_standard_effect", function(q) {
    
    //update the loop to check for the new banner types by property instead of ID
	
    q.getBonus = @() function( _properties )
    {
        local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local bestBravery = 0;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) > 4)
			{
				continue;
			}

			if (_properties.Bravery * _properties.BraveryMult >= ally.getBravery())
			{
				continue;
			}
            
            //use our new property to check instead of checkking IDs
			if (ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).hasProperty(::Const.Items.Property.PlayerBattleStandard) )
			{
				if (ally.getBravery() > bestBravery)
				{
					bestBravery = ally.getBravery();
				}
			}
		}

		if (bestBravery != 0)
		{
			bestBravery = this.Math.min(bestBravery * 0.1, bestBravery - _properties.Bravery * _properties.BraveryMult);
		}

		return bestBravery;
    }
});