::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/necromancer", function(q) {

    q.m.PH_isUber <- false;

    q.makeMiniboss = @(__original) function()
    {
        //necromancer has a vanilla method (natural ability to become a champion)
        if( !__original() ) return false;
        
        local odds = ::Math.max(::World.getTime().Days - 60, 10);

        if( ::Math.rand(0,100) > odds) return true;

        //Create an uber necromancer!
        this.m.PH_isUber = true;

        //Better Equips
        this.m.Items.equip(this.new("scripts/items/armor/wanderers_coat"));
        this.m.Items.equip(this.new("scripts/items/helmets/physician_mask"));
        //vanilla gives them a named dagger

        //buff base stats
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 25;
	    baseProperties.Stamina += 15;
        baseProperties.MeleeSkill += 10;
        baseProperties.MeleeDefense += 10;
        baseProperties.RangedDefense += 10;         

        //add skills
        this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
        this.m.Skills.add(::new("scripts/skills/ph_champs/uber_necro_raise_dead"));
        
        return true;
    }

    
    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.PH_isUber)
            {
                //unique loot (only for the uber version? yes, base version gives the dagger!)
                ret.push(::new("scripts/items/misc/ph_warlock_hair_item"));
                
                //he is bit of an anatomist, studying things, so he can drop other items!
                //drop something random and related                
                local drops = ::MSU.Class.WeightedContainer([
                    [50, "ph_zombie_blood_item"],                    
                    [20, "ph_zombie_ring_item"],
                    [10, "ph_ghost_blood_item"],
                    [20, "ph_skele_clavicle_item"],                                     
                    [10, "ph_skele_sternum_item"],
                    [5, "ph_skele_skull_item"],
                    [5, "ph_vamp_skull_item"],
                ]);
                ret.push(::new("scripts/items/misc/" + drops.roll() ));

                if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/misc/" + drops.roll() ));

                if(::Math.rand(0,100) < 10) ret.push(::new("scripts/items/loot/ph_ancient_tome_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "necromancer", ::Const.Items.PH_ReducedPotionDropRate );           
                }
            }
            else if(this.m.IsMiniboss && ::Math.rand(0,100) < 50 )
            {
                //should the regular champ drop anything? they are still a rare fight to have...
                //vanilla already gives them the named dagger to drop, so they have a base reward already
                //so make the drops conditional

                ret.push(::new("scripts/items/misc/ph_warlock_hair_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {                    
                    this.PH_AttemptIncompletePotionDrop( ret, "necromancer", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
        }

        return ret;
    }
});