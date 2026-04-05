this.ph_champ_venom_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 6,
		Damage = 6,
		LastRoundApplied = 0,

        //HD mods to normal spider poison
        HitpointRecoveryMult = 0.5,
        DurationInTurns = 6,
	},
	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function create()
	{
		this.m.ID = "effects.ph_champ_venom";
		this.m.Name = "Poisoned!! (spider)";
        this.m.Description = "This character has an incurable deadly poison running through his veins.";
		this.m.KilledString = "Died from incurable poison";
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_poison_01.wav",
			"sounds/enemies/dlc2/giant_spider_poison_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;

        if ( ::Hooks.hasMod("mod_hardened") )
        {
            this.m.HD_LastsForTurns = this.m.DurationInTurns;
        }
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		_tooltip.push({
			id = 100,
			type = "text",
			icon = "ui/icons/damage_received.png",
			text = "This character has an incurable deadly poison running through his veins.",
		});
	}

    function getTooltip()
	{
		local ret = this.skill.getTooltip();
        
        if(this.getContainer().getActor().getCurrentProperties().IsImmuneToPoison)
        {
            ret.push({
	    		id = 10,
    			type = "text",
		    	icon = "ui/icons/damage_received.png",
	    		text = ::Reforged.Mod.Tooltips.parseString("Once per [round|Concept.Round], when you [wait|Concept.Wait] or end your [turn|Concept.Turn], take " + ::MSU.Text.colorNegative(this.m.Damage/2) + " [Hitpoint|Concept.Hitpoints] Damage"),
    		});
        }
        else
        {
    		ret.push({
	    		id = 10,
    			type = "text",
		    	icon = "ui/icons/damage_received.png",
	    		text = ::Reforged.Mod.Tooltips.parseString("Once per [round|Concept.Round], when you [wait|Concept.Wait] or end your [turn|Concept.Turn], take " + ::MSU.Text.colorNegative(this.m.Damage) + " [Hitpoint|Concept.Hitpoints] Damage"),
    		});
        }

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/damage_received.png",
			text = ::Reforged.Mod.Tooltips.parseString("Recover " + ::MSU.Text.colorizeMultWithText(this.m.HitpointRecoveryMult) + " [Hitpoints|Concept.Hitpoints]"),
		});

		return ret;
	}

    function onUpdate( _properties )
    {
        this.skill.onUpdate( _properties );
        _properties.HitpointRecoveryMult *= this.m.HitpointRecoveryMult;
    }

	function resetTime()
	{
        if ( ::Hooks.hasMod("mod_hardened") )
        {
            this.m.HD_LastsForTurns = ::Math.max(1, this.m.DurationInTurns + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		    if (this.getContainer().hasSkill("trait.ailing")) ++this.m.HD_LastsForTurns;
        }
        else
        {
		    this.m.TurnsLeft = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		    if (this.getContainer().hasSkill("trait.ailing"))
		    {
			    ++this.m.TurnsLeft;
		    }
        }
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();

			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;			
			hitInfo.DamageRegular = this.m.Damage;
			if(this.getContainer().getActor().getCurrentProperties().IsImmuneToPoison)
            {
                //reduce the damage! There is no immunity to this poison!
				hitInfo.DamageRegular /= 2;
            }
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
		}
	}

	function onAdded()
	{
        this.resetTime();
	}

	function onTurnEnd()
	{
		this.applyDamage();

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});