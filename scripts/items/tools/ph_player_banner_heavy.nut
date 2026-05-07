this.ph_player_banner_heavy <- this.inherit("scripts/items/tools/player_banner", {
	m = {},
	function create()
	{
		this.player_banner.create();

		this.m.ID = "weapon.ph_player_banner_heavy";
		this.m.Name = "Heavy Battle Standard";
		this.m.Description = "A company standard to take into battle. Held high, allies will rally around it with renewed resolve, and enemies will know well who is about to crush them. Reinforced for greater battle potential.";
		
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -15;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;

        this.m.ItemProperty = ::Const.Items.Property.PlayerBattleStandard;

        this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
		this.m.Reach = ::Reforged.Reach.WeaponTypeDefault.Polearm;
	}
	
	function onEquip()
	{
		this.player_banner.onEquip();

		//remove the default skills and add our own (info wasn't updating properly otherwise)
		while(this.m.SkillPtrs.len() > 0)
		{
			this.removeSkill(this.m.SkillPtrs[this.m.SkillPtrs.len()-1]);
		}

		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		impale.m.FatigueCost += 5;
		this.addSkill(impale);
        this.addSkill(::new("scripts/skills/actives/repel"));
	}
});