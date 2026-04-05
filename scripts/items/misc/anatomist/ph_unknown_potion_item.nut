this.ph_unknown_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{		
		this.anatomist_potion_item.create();
		this.m.ID = "misc.ph_unknown_potion";
		this.m.Name = "Experimental Potion";
        this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_research_potion.png";
		this.m.Value = 0;
		
		this.m.Variant = 0;	//this will be used to save the potion roll!
		this.rollPotionType();
	}

	function getTooltip()
	{
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
			icon = "ui/icons/special.png",
			text = "Will cause an unknown anatomical mutation. Rare. Profound. Unpredictable."
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

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		//hanlde the checks
		//the array holds the core name like: "geist_potion"
		//we need to build the other names: "effects.geist_potion" vs "geist_potion_effect"

		local entry = ::Const.Items.PH_AP_Type[this.m.Variant];
		local effectID = "effects." + entry[1]

		if( _actor.getSkills().hasSkill(effectID) ) return false;

		//eh, let them be, they won the farking lottery.
		//Barb cannot have the grand diviner potion (very unlikely to roll, but need to block it)
		//if( effectID == "effects.grand_diviner_potion" && _actor.getSkills().hasSkill("effects.ph_barb_king_potion") ) return false;

		_actor.getSkills().add(this.new("scripts/skills/effects/" + entry[1] + "_effect"));

		//set the flag here (the main anatomist call won't be able to)
		_actor.getFlags().increment(effectID);
		
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

	function rollPotionType()
	{
		//each entry in the PH_AP_Type array is a weighted array entry [#, text]
		//we roll it ourself, since we require the index to be saved

		local total = 0;
		for(local j = 0; j < ::Const.Items.PH_AP_Type.len(); j++)
		{
			total += ::Const.Items.PH_AP_Type[j][0];
		}

		local roll = ::Math.rand(0, total);
		total = 0; //reset
		for(local i = 0; i < ::Const.Items.PH_AP_Type.len(); i++)
		{
			total += ::Const.Items.PH_AP_Type[i][0];

			if(roll < total)
			{
				this.m.Variant = i;
				return;
			}
		}
	}
});

