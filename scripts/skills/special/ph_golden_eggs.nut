this.ph_golden_eggs <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ph_golden_eggs";
		this.m.Name = "Golden Eggs";
		this.m.Description = "Stores and drops gold earned by Golden Whacker";		
		this.m.Icon = "";
		this.m.IconDisabled = "";
		this.m.Overlay = "";
		this.m.SoundOnUse = [
			"sounds/coins_01.wav",
			"sounds/coins_02.wav",
            "sounds/coins_03.wav"
		];
		this.m.Type = ::Const.SkillType.Special;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
        this.m.IsAttack = false;
        this.m.IsHidden = true;
        this.m.IsSerialized = false;       
	}

    //gold on kill!
    function onTargetKilled( _targetEntity, _skill )
	{    
        //The Golden Whacker generates gold on kill with all skills it uses
        //It can be complicated to check for specific skills given that reforged adds extras like Pummel

        //Is it one of our skills? (anything equipped with the hammer will have the item set!)
        local item = _skill.getItem();
		if(item == null) return;
        if(item.getID() != "weapon.ph_golden_whacker") return;
        

        item.generateGold(_targetEntity);
        this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, this.getContainer().getActor().getPos());
	}
});