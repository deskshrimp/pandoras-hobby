::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/hexe", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //some simple boosts to make them even more annoying
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 20;

        //give her her own potion -- reflects all hitpoint dmg!
        this.getSkills().add(::new("scripts/skills/effects/hexe_potion_effect"));

        return true;
    }
        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_hexe_head_item"));                

                //boost regular loot as well
                ret.push(::new("scripts/items/misc/" + ::MSU.Array.rand(["witch_hair_item", "mysterious_herbs_item", "poisoned_apple_item"]) ));                
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "hexe", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
		}

		return ret;
    }
});