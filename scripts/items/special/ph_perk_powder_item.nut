this.ph_perk_powder_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
        this.item.create();
		this.m.ID = "accessory.ph_perk_powder";
		this.m.Name = "The Trickster God\'s Blessings";
		this.m.Description = "A powder made from the ground hearts of especially powerful giants. It conveys a powerful blessing, but nothing is gained for free.";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_perk_powder.png";
		this.m.Value = 100;
	}

	function getTooltip()
	{
        local result = this.item.getTooltip();

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
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants a perk point"
		});

        result.push({
			id = 12,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "There will be a cost."
		});

        result.push({
			id = 13,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Cost increases with the number of blessings received."
		});

		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to consume. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
        this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);

        //give them a perk point
        _actor.m.PerkPoints += 1;
		this.Const.Tactical.Common.checkDrugEffect(_actor);

        _actor.getFlags().increment("PH_Blessings");
        local cost = _actor.getFlags().getAsInt("PH_Blessings");
        cost += (cost - 1); //don't get greedy
        local injuries = clone ::Const.Injury.Permanent;

        //Note: should these injuries start with the treated flag already set? So, they will resolve themselves in 30days or so?
        
        local i = 3;
        while (cost > 0 && injuries.len() > 0 ){
            if( !_actor.getSkills().hasSkill(injuries[i].ID) )
            {
                local injury = ::new("scripts/skills/" + injuries[i].Script);
                //set them to start treated? or just let them deal with it at the temple?                
                _actor.getSkills().add(injury);
                cost--;                
            }
            injuries.remove(i);            
            i = ::Math.rand(0, injuries.len()-1);
        }

        if(cost > 0)
        {
            if (_actor.getSkills().hasSkill("injury.sickness"))
		    {
			    _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(this.Math.rand(1, 3));
		    }
		    else
		    {
			    _actor.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
		    }

		    _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(cost * 10);
        }

        return true;
	}
});

