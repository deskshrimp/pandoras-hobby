this.ph_conqueror_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{		
		this.anatomist_potion_item.create();
		this.m.ID = "misc.ph_conqueror_potion";
		this.m.Name = "Skulltaker\'s Essence";
        this.m.Description = "This rather dangerous tincture contains a distillate extracted from the bones of an ancient emporer. Those who imbibe this concentrated extract will find themselves driven to conquest, domination, ...and to the collecting of skulls for their throne...";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_potion_conq.png";
		this.m.Value = 0;
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
			text = "+7% chance to hit the head. +21% chance to decapitate with any weapon."
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
		//prevent use if already present!
		if( _actor.getSkills().hasSkill("effects.ph_conqueror_potion") ) return false;

		_actor.getSkills().add(this.new("scripts/skills/effects/ph_conqueror_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

