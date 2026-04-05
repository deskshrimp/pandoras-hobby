::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/goblin_shaman", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //some simple boosts to make them even more annoying
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 10;

        this.getSkills().add(::new("scripts/skills/perks/perk_nimble"));

        return true;
    }
        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_goblin_fetish_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "goblin_shaman", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
		}

		return ret;
    }
});