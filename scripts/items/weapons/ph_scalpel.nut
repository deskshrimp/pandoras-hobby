this.ph_scalpel <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ph_scalpel";
		this.m.Name = "Bistoury";
		this.m.Description = "A common tool of the trade. Poorly suited for battle, but one must be remiss to forgo the collection of precious samples.";
		this.m.Categories = "Dagger, One-Handed";
		this.m.IconLarge = "weapons/melee/ph_scalpel_01.png";
		this.m.Icon = "weapons/melee/ph_scalpel_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ph_scalpel_01";
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.Value = 250;
        this.m.ShieldDamage = 0;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.25;
		this.m.DirectDamageMult = 0.25;

        this.m.WeaponType = ::Const.Items.WeaponType.Dagger;
		this.m.Reach = ::Reforged.Reach.WeaponTypeDefault.Dagger;
        this.m.IsChangeableInBattle = true;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/ph_scalpel_stab"));
		this.addSkill(::new("scripts/skills/actives/ph_vivisect"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

    function getTooltip()
	{
		local result = this.weapon.getTooltip();

        result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The perfect tool for inflicting cuts and bleeds."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Can inflict cuts and bleeds on the wielder as well. Dagger Mastery reduces the odds."
		});		

		return result;
	}

    function onDamageDealt( _target, _skill, _hitInfo )
	{
		//if(_skill.getID() == "actives.ph_scalpel_stab")
		//if(_skill.getID() == "actives.ph_vivisect")
				
		//MUCH GREATER CHANCE TO BLEED WHEN HITTING ARMOR!
		if (_skill.getID() == "actives.ph_scalpel_stab")
		{
			this.inflictCutOnSelf(10 + (_hitInfo.DamageInflictedArmor * 5), true);
		}
		else if(_skill.getID() == "actives.ph_vivisect")
		{			
			this.inflictCutOnSelf( _target.getArmorMax(_hitInfo.BodyPart) >= 10 ? 50 : 10);
		}
		else
		{
			//using some other dmg dealing skill like shield bash, can still get cut.	
			this.inflictCutOnSelf(10);
		}

		this.weapon.onDamageDealt( _target, _skill, _hitInfo );
	}

    function inflictCutOnSelf(_odds, _stab = false)
	{	
		local _actor = this.getContainer().getActor();

        if(_actor==null || _actor.isNull()) return;

		//adjust the odds for mastery and roll for the odds!
		if(_actor.getCurrentProperties().IsSpecializedInDaggers)
		{
			_odds = ::Math.floor(_odds*0.5);
		}

        if(this.Math.rand(0, 100) > _odds) return;

        //injur self or inflict a bleed on self!
        local odds = _stab ? 60 : 40;
        if( ::Math.rand(0,100) < odds )
        {
            _actor.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
        }
        else
        {
            _actor.setHitpoints(::Math.max(1, _actor.getHitpoints() - ::Math.rand(1, 7)));
        }
	}
});

