::PandorasHobby.MH.hook("scripts/items/special/bodily_reward_item", function(q) {    
    q.updateVariant = @(__original) function(){
        __original();

        if(this.m.Variant > 100)
        {
            this.m.Description = "A recipe that has been fiercely gaurded by northern hags for a century. A potent elixir of regeneration that instantly heals anything that would heal on its own. ";
        }
    }

    q.getTooltip = @(__original) function(){
        local ret = __original();

        ret.insert(ret.len()-1, 
            {
                id = 7,
			    type = "text",
			    icon = "ui/icons/special.png",
			    text = "Tends \'permanent\' injuries that have been treated at the Temple."
            }
        );

        return ret;
    }

    q.onUse = @(__original) function( _actor, _item = null ){
        local allInjuries = _actor.getSkills().query(::Const.SkillType.PermanentInjury);
        foreach( inj in allInjuries )
		{
            inj.PH_applyGreenVial();
		}

        return __original( _actor, _item);
    }
});