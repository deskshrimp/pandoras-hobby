::PandorasHobby.MH.hook("scripts/skills/effects/apotheosis_potion_effect", function(q) {
    q.m.Hitpoints <- 1;
    q.m.Fatigue <- 1;

    q.getTooltip = @() function() {
        local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Hitpoints + "[/color] Hitpoints"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Fatigue + "[/color] Fatigue"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
    }

    q.onUpdate = @() function( _properties ) {
        _properties.Hitpoints += this.m.Hitpoints;
		_properties.Stamina += this.m.Fatigue;
    }

    q.onSerialize = @(__original) function( _out )
	{
		this.skill.onSerialize(_out);
        _out.writeU8(this.m.Hitpoints);
        _out.writeU8(this.m.Fatigue);
	}

	q.onDeserialize = @(__original) function( _in )
	{
		this.skill.onDeserialize(_in);
        this.m.Hitpoints = _in.readU8();
        this.m.Fatigue = _in.readU8();
	}

	q.improveRolls <- function()
	{
		//check for max values
		if(this.m.Hitpoints == 5 && this.m.Fatigue == 5) return false;

		//roll new values to check
		local hp = ::Math.rand(1, 5);
		local fat = ::Math.rand(1, 5);		

		//are both values the same or lower?
		if(hp <= this.m.Hitpoints && fat <= this.m.Fatigue)
		{
			//buff whichever is lower
			if(hp < fat) { hp++; }
			else { fat++; }
		}
		else if(hp <= this.m.Hitpoints)
		{
			//buff the other value
			this.m.Fatigue = fat;
		}
		else if(fat <= this.m.Fatigue)
		{
			//buff the other value
			this.m.Hitpoints = hp;
		}
		else	//Winner! They are both better!
		{
			this.m.Hitpoints = hp;
			this.m.Fatigue = fat;
		}				

		return true;
	}
});