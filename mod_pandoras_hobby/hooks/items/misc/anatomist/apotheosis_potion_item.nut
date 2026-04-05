::PandorasHobby.MH.hook("scripts/items/misc/anatomist/apotheosis_potion_item", function(q) {    
    q.getTooltip = @() function(){
        local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/health.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1 to 5[/color] Hitpoints"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1 to 5[/color] Fatigue"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can be used to improve the effects of a previous Apotheosis potion with only minor sickness."
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
		});
		return result;
    }

    q.onUse = @() function( _actor, _item = null ){
		//if already present then improve the rolls!
		if( _actor.getSkills().hasSkill("effects.apotheosis_potion") )
		{
			_actor.getSkills().getSkillByID("effects.apotheosis_potion").improveRolls();

			//inflict regular sickness on them
			if (_actor.getSkills().hasSkill("injury.sickness"))
			{
				_actor.getSkills().getSkillByID("injury.sickness").addHealingTime(this.Math.rand(1, 3));
			}
			else
			{
				_actor.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
			}

			return true;
		}

        //roll for values and set them!
        local weights = [40,40,30]; //hp, fat, nothing!
        local totalWeight = weights[0] + weights[1] + weights[2];
        local hp = 1;
        local fat = 1;
        
        while(true)
        {
            local val = ::Math.rand(1, totalWeight);
            if(val <= weights[0])
            {
                hp++;
                weights[0] -= 10;
                weights[2] += 10;
            }
            else if(val <= weights[0] + weights[1])
            {
                fat++;
                weights[1] -= 10;
                weights[2] += 10;
            }
            else
            {
                //we're done!
                break;
            }
        }
        
        local effect = this.new("scripts/skills/effects/apotheosis_potion_effect");
        effect.m.Hitpoints = hp;
        effect.m.Fatigue = fat;
        _actor.getSkills().add(effect);

		return this.anatomist_potion_item.onUse(_actor, _item);
    }
});