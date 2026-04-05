::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/goblin_leader", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //give a named crossbow
        this.m.Items.equip(::new("scripts/items/weapons/named/ph_named_goblin_crossbow"));

        //buff base stats
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 10;
        
        //give new skill
        this.getSkills().add(::new("scripts/skills/perks/perk_coup_de_grace"));
        this.getSkills().add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));        

        return true;
    }
        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_goblin_champ_ear_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "goblin_overseer", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
		}

		return ret;
    }
});