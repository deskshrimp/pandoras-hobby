::PandorasHobby.MH.hook("scripts/states/tactical_state", function(q) {

    q.onBattleEnded = @(__original) function()
	{
		local isVictory = this.Tactical.Entities.getCombatResult() == this.Const.Tactical.CombatResult.EnemyDestroyed || this.Tactical.Entities.getCombatResult() == this.Const.Tactical.CombatResult.EnemyRetreated;
        if (!this.isScenarioMode() )
        {
            if(isVictory)
            {
                ::World.Statistics.getFlags().increment("PH_BattlesWon");
            }
            else
            {
                ::World.Statistics.getFlags().increment("PH_BattlesLost");
            }
        }

		__original();
	}

    q.gatherLoot = @(__original) function () {
        local isArena = !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode;
        local isLootBlocked = (!isArena && !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsLootingProhibited);

        if ( !isArena && !this.isScenarioMode() && !isLootBlocked )
        {
            //do they have boosted scavenging?
            if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Scav_Scavenge_2))
            {
                //add some extra recovery (variable 25% to 100% boost)

                local te = this.Tactical.Entities;

                //increase ammo available for recovery
                local ammo = te.getAmmoSpent();
                ammo = ::Math.floor( ammo * (::Math.rand(25,100)*0.01) );
                te.spendAmmo(ammo);

                //the cap on armor parts blocks mods, must duplicate the code (with our own variable cap)
                local amount = ::Math.min(::Math.rand(15,60), ::Math.max(1, this.Tactical.Entities.getArmorParts() * ::Const.World.Assets.ArmorPartsPerArmor * 0.15));
				    amount = ::Math.rand(amount / 2, amount);

			    if (amount > 0)
			    {
				    local parts = ::new("scripts/items/supplies/armor_parts_item");
				    parts.setAmount(amount);
				    //loot.push(parts);
                    this.m.CombatResultLoot.add(parts);
			    }
            }
        }

        //::logError("DEBUG: REMOVE THIS --- Scav Loot");

        __original();
    }
});