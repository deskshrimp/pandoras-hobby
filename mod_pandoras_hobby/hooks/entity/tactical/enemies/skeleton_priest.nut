::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/skeleton_priest", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //Upgrade equipment
        this.m.Items.equip(::new("scripts/items/armor/ancient/ancient_lich_attire"));
		this.m.Items.equip(::new("scripts/items/helmets/named/ph_named_ancient_diadem"));

        //add skills
        this.m.Skills.add(::new("scripts/skills/perks/perk_rf_soul_link")); //transfer dmg to nearby guards!
        this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives")); //one extra hit

        this.m.Skills.add(::new("scripts/skills/actives/raise_undead"));
		this.m.Skills.add(::new("scripts/skills/actives/possess_undead_skill"));

        //change AI
        this.m.AIAgent = ::new("scripts/ai/tactical/agents/ph_skeleton_priest_champ_agent");
		this.m.AIAgent.setActor(this);

        //buff base stats
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 15;
        baseProperties.MeleeDefense += 5;
        
        return true;
    }

    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {                
                ret.push(::new("scripts/items/misc/ph_skele_skull_item"));                
                ret.push(::new("scripts/items/loot/ph_skele_jewelry_item"));

                if(::Math.rand(0,100) < 33) ret.push(::new("scripts/items/loot/ph_ancient_tome_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "ancient_priest", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
        }

        return ret;
    }
});