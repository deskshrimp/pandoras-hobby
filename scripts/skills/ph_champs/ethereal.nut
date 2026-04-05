this.ethereal <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		LastFrameUsed = 0,

        Spirit = 100,        
	},
	function isSpent()
	{
		return this.m.IsSpent;
	}

	function getLastFrameUsed()
	{
		return this.m.LastFrameUsed;
	}

	//Note: this skill reuses the barb potion effect, as the image is fitting.

	function create()
	{
		this.m.ID = "perk.nine_lives"; //keep the ID!
		this.m.Name = "Ethereal";
		this.m.Description = "This creature is a semi-solid apparation, which makes it devilishly hard to kill.";
		this.m.Icon = "skills/ph_barb_pot_effect.png";		
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function setSpent( _f )
	{
        if(::Math.rand(0,100) >= this.m.Spirit)
        {
            //Hit!            
            if(!this.m.Spent)
            {
                local effect = ::new("scripts/skills/effects/nine_lives_effect");
                effect.m.Description = "This spirit is clinging to un-life with everything its got!";
                effect.m.Icon = "skills/ph_barb_pot_effect.png";
		        effect.m.IconMini = "ph_potion_barb_effect_mini";
		        effect.m.Overlay = "ph_potion_barb_effect";
                this.getContainer().add(effect);
            }

            this.m.IsSpent = true;
            this.m.Spirit = 100;
        }
        else
        {
            //reduce spirit
            this.m.Spirit = ::Math.max(0, this.m.Spirit - ::Math.rand(5,15));
        }
		

        //we don't use this
		//this.m.LastFrameUsed = this.Time.getFrame();
	}

    function onTurnStart()
	{
        //regen spirit
        this.m.Spirit = ::Math.min(100, this.m.Spirit + 10);
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
		this.skill.onCombatFinished();
	}

	function onUpdate( _properties )
	{
		//just in case there are any that get through the immunities
		this.getContainer().removeByType(this.Const.SkillType.DamageOverTime);
	}

    function getTooltip()
	{
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignores zones fo control."	//technically set in the MakeMiniboss method, but we need to say it somewhere.
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Ethereal: [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Spirit +"%[/color] chance to ignore the next hit."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Etheral is reduced by each hit, but regenerates slightly each turn."
			}
        ];

        if(!this.m.IsSpent)
        {
            ret.push({
			    id = 11,
			    type = "text",
			    icon = "ui/icons/special.png",
			    text = "Will [color=" + this.Const.UI.Color.PositiveValue + "]ignore[/color] the next fatal blow."
		    });
        }

		return ret;
	}
});

