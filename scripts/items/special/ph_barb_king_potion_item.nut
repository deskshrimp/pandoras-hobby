this.ph_barb_king_potion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
        this.m.ID = "accessory.ph_barb_king_potion";
		this.m.Name = "Old God\'s Fire";
		this.m.Description = "An odd smelling liqour that burns like seven hells going down. Supposedly it contains the spirits of long dead barbarian kings.";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable | this.Const.Items.ItemType.Legendary;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_barb_pot.png";
		this.m.Value = 100;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{		
		//prevent use if already present!
		if( _actor.getSkills().hasSkill("effects.ph_barb_king_potion") ) return false;

		if (_actor.PH_isCultist() )
		{
			//give them a crisis of faith! (permanent injury)
			_actor.getSkills().add("scripts/skills/injury_permanent/ph_faith_crisis");
		}

		local effect = this.new("scripts/skills/effects/ph_barb_king_potion_effect");
		effect.m.BaseLevel = _actor.getLevel();
		_actor.getSkills().add(effect);

		//remove survivor trait if present? it is useless and misleading!
		if( _actor.getSkills().hasSkill("trait.survivor") )
		{			
			_actor.getSkills().removeByID("trait.survivor");

			if(_actor.getBackground().getID() == "background.barbarian") return;

			//convert them to being a barbarian!
			local background = ::new("scripts/skills/backgrounds/ph_converted_barbarian_background");
			_actor.getSkills().removeByID(_actor.getBackground().getID());
			_actor.getSkills().add(background);
			background.buildDescription();
			background.onSetAppearance();
		}

		return true;
	}

	function getTooltip()
	{
        local result = this.item.getTooltip();		

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The longer the fire of the old gods burns within you, the greater the blessings."
		});

        result.push({
			id = 12,
			type = "text",
			icon = "ui/tooltips/negative.png",
			text = "Called to Valhalla: This character will " + ::MSU.Text.colorNegative("always die") + " if they fall in battle."
		});

		result.push({
			id = 13,
			type = "hint",			
			text = "Bonuses are acquired for each level gained after drinking the potion. Low level bros are best!"
		});

		result.push(
			{
				id = 40,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Caution: The old gods do not approve of diluting their blessings with those of other gods!"
			}
		);

		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});

		return result;
	}
});