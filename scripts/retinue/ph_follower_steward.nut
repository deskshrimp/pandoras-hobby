this.ph_follower_steward <- this.inherit("scripts/retinue/ph_follower", {
    m = {},
    function create()
	{
        this.ph_follower.create();
        this.m.Archetype = ::PandorasHobby.Follower.Archetype.Steward;
    }

    function wasHired()
    {
        //clear all class-related flags
    }

    function isMaxLevel()
    {
        return this.hasExactSkill(::PandorasHobby.Follower.SkillMasks.Steward_MAX);
    }

    function getXPHintText()
    {        
        //HD mod adds the tracking for painting and attachments

        if ( ::Hooks.hasMod("mod_hardened") ){
            return "Earn 1 XP: Craft gear, attachments, or food, Repair in town, Paint 5 items, or Use 5 attachments. Daily Bonus XP based on # of cart upgrades.";
        }

        return "Earn 1 XP: Craft gear, attachments, or food, or Repair an item in town. Daily Bonus XP based on # of cart upgrades.";
    }

    function earnDailyXP()
    {
        this.ph_follower.earnDailyXP();

        //bonus XP from cart upgrades
        this.m.XP += this.getXP_CartUpgradesBonus();
        
        //collect XP from trackers
        this.m.XP += this.getXP_Crafting();
                
        //check for level up and aging
        if(this.checkForLevelAge()) this.updateEffects();
    }

    function getXP_CartUpgradesBonus()
    {   
        local xp = 0;     
        local maxRoll = this.m.Level + 3;
        local odds = ::World.Retinue.getInventoryUpgrades(); //max of 8
        //Steward max level is ~12  [so 15 vs 8 max odds]

        this.m.DailyOdds = odds;
        this.m.DailyMax = maxRoll;

        while( xp < ::PandorasHobby.Follower.MaxDailyXP && ::Math.rand(0, maxRoll) < odds )
        {
            xp += 1;
        }        
        return xp;
    }

    function getXP_Crafting()
    {
        local xp = 0;
        local key = "";
        local num = 0;
        local stat = 0;

        //Crafting & Repairs xp (all 1 per item?)
        //Battles 1xp
        //Painting or Attaching are 1xp per 5
        key = "Num_Equips";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Equips");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;
        
        key = "Num_Upgrades";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Upgrades");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;        

        key = "Num_Food";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Food");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;

        key = "Num_Repairs";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("ItemsRepaired");
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 1;

        key = "Num_UpgradesUsed";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("ArmorAttachementsApplied");
        while(stat >= num + 5)
        {
            num += 5;
            xp += 1;
            this.setFlag(key, num);
        }

        key = "Num_Painted";
        num = this.getFlag(key);
        stat = ::World.Statistics.getFlags().getAsInt("PaintUsedOnHelmets") +::World.Statistics.getFlags().getAsInt("PaintUsedOnShields");
        while(stat >= num + 5)
        {
            num += 5;
            xp += 1;
            this.setFlag(key, num);
        }

        /*
        key = "Num_CartUpgrades";
        num = this.getFlag(key);
        stat = ::World.Retinue.getInventoryUpgrades();
        if(stat > num) this.setFlag(key, stat);
        xp += (stat - num) * 5;
        */

        return xp;
    }

    function updateValueTrackers()
	{
        this.setFlag("Num_Equips", ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Equips"));
        this.setFlag("Num_Upgrades", ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Upgrades"));
        this.setFlag("Num_Food", ::World.Statistics.getFlags().getAsInt("PH_ItemsCrafted_Food"));

        this.setFlag("Num_Repairs", ::World.Statistics.getFlags().getAsInt("ItemsRepaired"));        

        //DO NOT UPDATE TRACKER FOR CART UPGRADES, LET IT GIVE XP

        this.setFlag("Num_UpgradesUsed", ::World.Statistics.getFlags().getAsInt("ArmorAttachementsApplied"));

        local num = ::World.Statistics.getFlags().getAsInt("PaintUsedOnHelmets") +::World.Statistics.getFlags().getAsInt("PaintUsedOnShields");
        this.setFlag("Num_Painted", num);
	}

    function wasNewDay()
	{        
        //Repair Nets
        this.attemptNetRepair();

        //Cook Gruel & Jerky
        this.attemptToCook();
	}

    function attemptNetRepair()
    {
        if( !this.hasSkill(::PandorasHobby.Follower.Skill.Net_Master) ) return;

        //repairs cost ammo/tools + web and/or teeth depending on the tier
        //Ammo is 2g and Tools are 10g, need to keep this fairly cheap to be worth it!
        //we could mimmic the crafting recipe and combine broken nets, but that leads to losing nets over time....        
        //can also upgrade existing nets in the stash

        local brokenNets = [];
        local throwingNets = [];
        local reinforcedNets = [];
        local spiderSilk = [];
        local ghoulTeeth = [];

        local items = ::World.Assets.getStash().getItems();
        foreach( item in items )
        {
            if (item == null || !item.isItemType(::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Tool)) continue;

            if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
            {
                //only Old can make Toothed Nets
                //needs teeth and reinforced nets
                if(item.getID() == "misc.ghoul_teeth")
                {
                    ghoulTeeth.push(item);
                    continue;
                }
                else if(item.getID() == "tool.reinforced_throwing_net")
                {
                    reinforcedNets.push(item);
                    continue;
                }
            }
            
            if(this.m.Age >= ::PandorasHobby.Follower.Age.Adult)
            {
                //Adult can upgrade nets
                //so grab regular nets & spider silk
                if(item.getID() == "misc.spider_silk")
                {
                    spiderSilk.push(item);
                    continue;
                }
                else if(item.getID() == "tool.throwing_net")
                {
                    throwingNets.push(item);
                    continue;
                }
            }

            //Grab broken nets
            if(item.getID() == "misc.ph_broken_net")
            {
                brokenNets.push(item);
                continue;
            }
        }

        //::logInfo( "Net Repair => [" + brokenNets.len() + "," + throwingNets.len() + "," + reinforcedNets.len() + "] {" + spiderSilk.len() + "," + ghoulTeeth.len() + "}");

        //now attempt to repair a net
        if(brokenNets.len() > 0)
        {
            //Toothed: costs 6 ammo + 2 tool
            //Reinforced: costs 4 ammo + 1 tool
            //Basic: costs 4 ammo
            if(brokenNets[0].isToothed() && ::World.Assets.getArmorParts() > 2 && ::World.Assets.getAmmo() > 6)
            {
                ::World.Assets.addAmmo( -6 );
	            ::World.Assets.addArmorParts( -2 );

                this.removeItemsFromStash( [ brokenNets[0] ] );
                ::World.Assets.getStash().add(::new("scripts/items/tools/ph_toothed_throwing_net"));
            }
            else if(brokenNets[0].isReinforced() && ::World.Assets.getArmorParts() > 1 && ::World.Assets.getAmmo() > 4)
            {
                ::World.Assets.addAmmo( -4 );
	            ::World.Assets.addArmorParts( -1 );

                this.removeItemsFromStash( [ brokenNets[0] ] );
                local net = ::new("scripts/items/tools/reinforced_throwing_net");
                ::World.Assets.getStash().add(net);

                //add it to the list for potential upgrade
                if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
                {
                    reinforcedNets.push(net);
                }
            }
            else if(brokenNets[0].isBasic() &&::World.Assets.getAmmo() > 4)
            {
                ::World.Assets.addAmmo( -4 );

                this.removeItemsFromStash( [brokenNets[0]] );
                local net = ::new("scripts/items/tools/throwing_net");
                ::World.Assets.getStash().add(net);

                //add it to the list for potential upgrade
                if(this.m.Age >= ::PandorasHobby.Follower.Age.Adult)
                {
                    throwingNets.push(net);
                }
            }
        }
        
        //now attempt to upgrade a net
        if(throwingNets.len() > 0 && spiderSilk.len() > 0 && ghoulTeeth.len() > 0)
        {
            this.removeItemsFromStash( [throwingNets[0], spiderSilk[0], ghoulTeeth[0]] );
            ::World.Assets.getStash().add(::new("scripts/items/tools/ph_toothed_throwing_net"));
        }        
        else if(reinforcedNets.len() > 0 && ghoulTeeth.len() > 0)
        {
            this.removeItemsFromStash( [reinforcedNets[0], ghoulTeeth[0]] );
            ::World.Assets.getStash().add(::new("scripts/items/tools/ph_toothed_throwing_net"));
        }
        else if(throwingNets.len() > 0 && spiderSilk.len() > 0)
        {
            this.removeItemsFromStash( [throwingNets[0], spiderSilk[0]] );
            ::World.Assets.getStash().add(::new("scripts/items/tools/reinforced_throwing_net"));
        }        
    }

    function removeItemsFromStash(_list)
    {
        local items = ::World.Assets.getStash().getItems();
        for( local i = 0; i < _list.len();  )
		{
			foreach( j, item in items )
			{
				if (item == _list[i])
				{
					items[j] = null;
					break;
				}
			}

			_list.remove(i);
		}
    }

    function attemptToCook()
    {
        if( !this.hasSkill(::PandorasHobby.Follower.Skill.Scrap_Cook) ) return;

        //turns grains into gruel
        //turns strange meat into jerky
        //combines multiple stacks, extends duration, slight bonus to food?
        local foods = [];
        local items = ::World.Assets.getStash().getItems();
		foreach( item in items )
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Food))
			{
				foods.push(item);
			}
        }
        foods.sort(this.sortFoodByFreshness);

        //::logInfo("Steward > Cook Gruel > Foods = " + foods.len());

        local grains = [];
        local totalGrain = 0;
        local meats = [];
        local totalMeat = 0;
        local other = null;
        foreach(food in foods)
        {
            if( this.m.Age == ::PandorasHobby.Follower.Age.Old && meats.len() < 2 && food.getID() == "supplies.strange_meat"){
                meats.push(food);
                totalMeat += food.getAmount();
            }
            else if( grains.len() < 2 && (food.getID() == "supplies.ground_grains" || food.getID() == "supplies.rice") )
            {
                grains.push(food);
                totalGrain += food.getAmount();
            }
            else if(other == null && food.getID() != "supplies.ph_gruel" && food.getID() != "supplies.ph_jerky")
            {
                other = food;
            }

            if((meats.len() >= 2 || totalMeat >= 40) && other != null )
            {
                this.cookFood("ph_jerky_item", meats, other, totalMeat);
                return;
            }
            if((grains.len() >= 2 || totalGrain >= 40) && other != null )
            {
                this.cookFood("ph_gruel_item", grains, other, totalGrain);
                return;
            }
        }

        //::logInfo("Steward > Cook Gruel > Foods = " + meats.len() + " / " + grains.len() );

        if(meats.len() >= grains.len())
        {
            this.cookFood("ph_jerky_item", meats, other, totalMeat);
        }
        else if(grains.len() > 0)
        {
            this.cookFood("ph_gruel_item", grains, other, totalGrain);
        }
    }

    function cookFood(_result, _foods, _other, _amount)
    {
        //::logInfo("Steward > Cook Foods = " + _result );

        if(_other != null)
        {
            _foods.push(_other);
            _amount += _other.getAmount();
        }

        local cookedFood = ::new("scripts/items/supplies/" + _result);
        cookedFood.setAmount(_amount); //any small bonus like amount/10? no need its about preservation        
        
        //remove all the food that was used!
        this.removeItemsFromStash(_foods);
        
        //and deposit the new food
        ::World.Assets.getStash().add(cookedFood);
    }

    function sortFoodByFreshness( _f1, _f2 )
	{	
        //strange meat is the only food marked as undesirable and we want it!
        if (!_f1.isDesirable() && _f2.isDesirable())
		{
			return -1;
		}
		else if (_f1.isDesirable() && !_f2.isDesirable())
		{
			return 1;
		}	
		else if (_f1.getBestBeforeTime() > _f2.getBestBeforeTime())
		{
			return 1;
		}
		else if (_f1.getBestBeforeTime() < _f2.getBestBeforeTime())
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}

    function onUpdate()
    {        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Smith_Repair_Speed))
        {
            ::World.Assets.m.RepairSpeedMult *= 1.2;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Smith_SaveTools))
        {
            ::World.Assets.m.ArmorPartsPerArmor *= 0.8;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Cook_Preserve))
        {
            ::World.Assets.m.FoodAdditionalDays = 5;
        }

        local storageSize = 0;
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Quart_Storage_3))
        {
            //20 per upgrade + 40   [200 total]
            storageSize = (40 + ::World.Retinue.getInventoryUpgrades() * 20);
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Quart_Storage_2))
        {
            //15 per upgrade + 30   [150 total]
            storageSize = (30 + ::World.Retinue.getInventoryUpgrades() * 15);
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Quart_Storage_1))
        {
            //10 per upgrade + 20   [100 total]
            storageSize = (20 + ::World.Retinue.getInventoryUpgrades() * 10);
        }
        ::World.Assets.m.AmmoMaxAdditional += storageSize;
		::World.Assets.m.MedicineMaxAdditional += storageSize;
		::World.Assets.m.ArmorPartsMaxAdditional += storageSize;

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scav_RecoverAll))
        {
            ::World.Assets.m.IsBlacksmithed = true;
        }

        //same check for tier 2 (must be handled elsewhere)
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scav_Scavenge_1))
        {
            ::World.Assets.m.IsRecoveringAmmo = true;
		    ::World.Assets.m.IsRecoveringArmor = true;
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Tool_Storage))
        {
            //Tinker gives 50 tool storage            
		    ::World.Assets.m.ArmorPartsMaxAdditional += 50;
        }
    }

    function updateEffects()
	{
        //follower has already included thier unique skill
        //append a summary of all the common ones
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Smith_Repair_Speed))
        {
            this.m.TooltipEffects.push("Increases repair speed by 20%");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Smith_SaveTools))
        {
            this.m.TooltipEffects.push("Reduces tool consumption by 20%");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Smith_Recipes))
        {
            this.m.TooltipEffects.push("Unlocks crafting recipes for champion gear");
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Cook_Preserve))
        {
            this.m.TooltipEffects.push("Makes all provisions last 5 extra days");
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Cook_Recipes))
        {
            this.m.TooltipEffects.push("Unlocks all cooking recipes + prevents rotten food event");
        }
        
        if(this.hasSkill(::PandorasHobby.Follower.Skill.Quart_Storage_1))
        {
            //this method is sometimes called during creation so global vars don't exist
            local num = 0;
            local flat = 20;
            local scale = 10;
            if(::World != null && ::World.Retinue != null)
            {
                if(this.hasSkill(::PandorasHobby.Follower.Skill.Quart_Storage_3))
                {            
                    flat = 40;
                    scale = 20;
                }
                else if(this.hasSkill(::PandorasHobby.Follower.Skill.Quart_Storage_2))
                {            
                    flat = 40;
                    scale = 20;
                }            
                num = ::World.Retinue.getInventoryUpgrades() * scale + flat;
            }

            this.m.TooltipEffects.push("Increases Ammo, Tool, & Medicine storage by " + flat + " plus " + scale + " per cart upgrade [+" + num + "]");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scav_RecoverAll))
        {
            this.m.TooltipEffects.push("Recovers all equipment worn by your men even if broken or lost because of death");
        }

        if(this.hasSkill(::PandorasHobby.Follower.Skill.Scav_Scavenge_2))
        {
            this.m.TooltipEffects.push("Recovers a part of all ammo you use during battle (boosted)");
            this.m.TooltipEffects.push("Recovers tools and supplies from every armor destroyed by you during battle (boosted)");
        }
        else if(this.hasSkill(::PandorasHobby.Follower.Skill.Scav_Scavenge_1))
        {
            this.m.TooltipEffects.push("Recovers a part of all ammo you use during battle");
            this.m.TooltipEffects.push("Recovers tools and supplies from every armor destroyed by you during battle");
        }
	}
});