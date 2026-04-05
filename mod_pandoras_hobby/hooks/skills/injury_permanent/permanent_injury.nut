::PandorasHobby.MH.hook("scripts/skills/injury_permanent/permanent_injury", function(q) {
    
    //Adding all the Injury fields and methods so the temple methods can work properly
    
    q.m.IsTreated <- false;
    q.m.DaysTreated <- 0;

    q.m.IsTreatable <- true;

    //heals in 3 to 6 weeks
    q.m.HealingTimeMin <- 21;
	q.m.HealingTimeMax <- 42;

	q.m.TreatmentPriceMult <- 2.0;

    q.isTreated <- function()
    {
        return this.m.IsTreated;
    }

    q.isTreatable <- function()
    {
        return this.m.IsTreatable;
    }
    
    q.onSerialize = @(__original) function( _out )
    {
        __original(_out);
        _out.writeBool(this.m.IsTreated);
        _out.writeU32(this.m.DaysTreated);
    }

    q.onDeserialize = @(__original) function( _in )
    {
        __original(_in);
        this.m.IsTreated = _in.readBool();
        this.m.DaysTreated = _in.readU32();
    }    

    q.getPrice <- function()
    {
        local mult = ::World.State.getCurrentTown().getBuyPriceMult() * ::Const.Difficulty.BuyPriceMult[::World.Assets.getEconomicDifficulty()] * this.m.TreatmentPriceMult;
        mult = mult * (1.0 + this.getContainer().getActor().getLevel() * 0.25);
        local maxt = this.m.HealingTimeMax;
        local p = maxt * mult * ::Const.World.Assets.BaseWoundTreatmentPrice;        
        p = ::Math.round(p * 0.1) * 10;
		return p;
    }

    //original method does nothing!
    q.setTreated = @() function( _f )
    {        
        this.m.IsTreated = _f;
    }

    q.getHealingTime <- function()
    {
        local mint = ::Math.max(1, this.m.HealingTimeMin - this.m.DaysTreated + this.getContainer().getActor().getCurrentProperties().AdditionalHealingDays);
        local maxt = ::Math.max(1, this.m.HealingTimeMax - this.m.DaysTreated + this.getContainer().getActor().getCurrentProperties().AdditionalHealingDays);
        
        return {
			Min = mint,
			Max = maxt
		};
    }

    q.addTooltipHint = @(__original) function( _tooltip )
    {
        if(this.m.IsTreated)
        {
            _tooltip.push({
			    id = 7,
			    type = "hint",
			    icon = "ui/icons/special.png",
			    text = "Treatment at the Temple has reduced the duration of this injury."
			});

            if (("State" in this.World) && this.World.State != null && this.World.Assets.getMedicine() <= 0 && this.m.IsHealingMentioned)
		    {
			    _tooltip.push({
				    id = 7,
				    type = "hint",
				    icon = "ui/icons/warning.png",
				    text = "Will not heal because you have no medical supplies"
			    });
		    }
		    else if (this.getContainer().getActor().getSkills().hasSkill("trait.oath_of_sacrifice") && this.m.IsHealingMentioned)
		    {
			    _tooltip.push({
				    id = 7,
				    type = "hint",
				    icon = "ui/icons/warning.png",
				    text = "Will not heal because this character has taken an oath of sacrifice"
			    });
		    }
            else
            {
                local ht = this.getHealingTime();
			    local d;
                if (ht.Max > 1 && ht.Min == ht.Max)
				{
					d = "Will heal in " + ht.Min + " days";
				}
				else if (ht.Max > 1)
				{
					d = "Will heal in " + ht.Min + " to " + ht.Max + " days";
				}
				else
				{
					d = "Will heal by tomorrow";
				}

				_tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/days_wounded.png",
					text = d
				});
            }
        }
        else
        {
            __original(_tooltip);
        }        
    }

    q.onNewDay = @() function()
    {
        //was this treated?
        if(!this.m.IsTreated) return;

        //is healing blocked by oath?
        if(this.getContainer().getActor().getSkills().hasSkill("trait.oath_of_sacrifice")) return;
        
        //is there enough medicine?
        if(::World.Assets.getMedicine() < ::Const.World.Assets.MedicinePerInjuryDay) return;

        ::World.Assets.addMedicine(-::Const.World.Assets.MedicinePerInjuryDay);
        this.m.DaysTreated++;

        local minTime = this.m.HealingTimeMin;
		local maxTime = this.m.HealingTimeMax;
        if (this.getContainer().getActor().getSkills().hasSkill("effects.nachzehrer_potion"))
		{
			minTime--;
			maxTime--;
		}

        if (this.m.DaysTreated < minTime)
		{
			return;
		}

        local chance = this.m.DaysTreated - minTime;
        local maxRoll = maxTime - minTime;
        if (::Math.rand(0, maxRoll) <= chance)
        {
            this.PH_removeVisuals();
			this.removeSelf();
			return;
        }

        //vanilla method -- has ~50% per day chance to cure after minTime
        //new method only gains a chance after exceeding the minimum days, and only gains a stacking 1/(max-min) chance per day

        /* 
		local chance = this.m.DaysTreated / (ht.Max * 1.0) * 100.0;

		if (::Math.rand(1, 100) <= chance)
		{
            this.PH_removeVisuals();
			this.removeSelf();
			return;
		}
        */
    }

    q.PH_removeVisuals <- function()
    {
    }

    q.PH_applyGreenVial <- function()
    {
        if(!this.m.IsTreated) return;
        if(!this.m.IsTreatable) return;

        //increase the days treated count by 1 to 5 days        
        this.m.DaysTreated += ::Math.rand(1,5);
    }
});