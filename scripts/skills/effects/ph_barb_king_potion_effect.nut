this.ph_barb_king_potion_effect <- this.inherit("scripts/skills/skill", {
	m = 
	{		
		BaseLevel = 0,
		LevelsGained = 0,

		BonusAttribs = [],

		IsAffectedByInjuries = true,
		IsAffectedByFreshInjuries = true,
		IsAffectedByFleeingAllies = true,
		IsAffectedByDyingAllies = true,
		IsAffectedByLosingHitpoints = true,
				
		MentalMoraleMult = 0,

		//only for Wildmen and Barb backgrounds!
		InitiativeForTurnOrderMult = 0,

		Excluded = [],
	},
	function create()
	{
		this.m.ID = "effects.ph_barb_king_potion";
		this.m.Name = "Old God\'s Fire";
		this.m.Icon = "skills/ph_barb_pot_effect.png";
		this.m.IconMini = "ph_potion_barb_effect_mini";
		this.m.Overlay = "ph_potion_barb_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 1000;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;

		this.m.BonusAttribs.resize(::Const.Attributes.COUNT, 0);

		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
	}

	function getDescription()
	{
		return "This character has received the blessing of the old gods. They will receive boons to enhance their battle prowess, however, they also feel an irresistable tug that beckons them to the beyond.";
	}	

	function onUpdate( _properties )
	{
		//cannot survive with an injury! (redundant backup with the player hook)		
		_properties.SurviveWithInjuryChanceMult = 0.0;

		//check for any changes
		this.ph_UpdatePotionEffects();

		//apply bonuses!
		_properties.Hitpoints += this.m.BonusAttribs[::Const.Attributes.Hitpoints];
		_properties.Bravery += this.m.BonusAttribs[::Const.Attributes.Bravery];
		_properties.Stamina += this.m.BonusAttribs[::Const.Attributes.Fatigue];
		_properties.Initiative += this.m.BonusAttribs[::Const.Attributes.Initiative];
		_properties.MeleeSkill += this.m.BonusAttribs[::Const.Attributes.MeleeSkill];
		_properties.RangedSkill += this.m.BonusAttribs[::Const.Attributes.RangedSkill];
		_properties.MeleeDefense += this.m.BonusAttribs[::Const.Attributes.MeleeDefense];
		_properties.RangedDefense += this.m.BonusAttribs[::Const.Attributes.RangedDefense];

		_properties.MoraleCheckBraveryMult[::Const.MoraleCheckType.MentalAttack] += (this.m.MentalMoraleMult * 0.01);

		_properties.IsAffectedByInjuries = _properties.IsAffectedByInjuries && this.m.IsAffectedByInjuries;
		_properties.IsAffectedByFreshInjuries = _properties.IsAffectedByFreshInjuries && this.m.IsAffectedByFreshInjuries;
		_properties.IsAffectedByFleeingAllies = _properties.IsAffectedByFleeingAllies && this.m.IsAffectedByFleeingAllies;
		_properties.IsAffectedByDyingAllies = _properties.IsAffectedByDyingAllies && this.m.IsAffectedByDyingAllies;
		_properties.IsAffectedByLosingHitpoints = _properties.IsAffectedByLosingHitpoints && this.m.IsAffectedByLosingHitpoints;

		_properties.InitiativeForTurnOrderMult += this.m.InitiativeForTurnOrderMult;
	}

	function ph_UpdatePotionEffects()
	{
		if( this.getContainer() == null || this.getContainer().isNull() ) return;

		local actor = this.getContainer().getActor();
        if( actor == null || actor.isNull() ) return;
		
		//this shouldn't ever happen, but some ghost calls with 0s are happening....?
		//::logDebug("CHECK (" + actor.getID() +  "): " + actor.getLevel() + " >? " + this.m.BaseLevel + " + " + this.m.LevelsGained);		
		if( this.m.BaseLevel == 0 ) return;

		//gain bonus stats with each level
		while(actor.getLevel() > this.m.BaseLevel + this.m.LevelsGained)
		{
			this.PurgeWeakness(actor);			
			this.RollForBonusStats();
			this.m.LevelsGained++;
		}

		//apply other bonuses based on Levels Gained		
		this.m.MentalMoraleMult = ::Math.floor(this.m.LevelsGained*1.5)

		this.m.IsAffectedByFleeingAllies 	= (this.m.LevelsGained < 3);
		this.m.IsAffectedByLosingHitpoints	= (this.m.LevelsGained < 6);
		this.m.IsAffectedByDyingAllies 		= (this.m.LevelsGained < 9);
		this.m.IsAffectedByFreshInjuries	= (this.m.LevelsGained < 12);
		this.m.IsAffectedByInjuries			= (this.m.LevelsGained < 15);

		//Wildmen and Barbs only
		this.m.InitiativeForTurnOrderMult = 0;
		if (actor.getBackground().getID() == "background.barbarian" || actor.getBackground().getID() == "background.converted_barbarian")
		{
			this.m.InitiativeForTurnOrderMult = this.m.LevelsGained * 0.02;
		}
		else if (actor.getBackground().getID() == "background.wildman")
		{
			this.m.InitiativeForTurnOrderMult = this.m.LevelsGained * 0.01;
		}
	}

	function PurgeWeakness(_actor)
	{
		if(this.m.LevelsGained < 5 || ::Math.rand(0,100) < 50) return;
		
		local ind = ::Math.rand(0, this.m.Excluded.len()-1);
		_actor.getSkills().removeByID(this.m.Excluded[ind]);

		if (_actor.getBackground().getID() == "background.barbarian" || _actor.getBackground().getID() == "background.converted_barbarian")
		{
			ind = ::Math.rand(0, this.m.Excluded.len()-1);
			_actor.getSkills().removeByID(this.m.Excluded[ind]);
		}
	}

	function RollForBonusStats()
	{
		//::logInfo("Barb King potion is rolling for stats!")		

		local weights = [];
		weights.resize(::Const.Attributes.COUNT, 0);
		weights[::Const.Attributes.Hitpoints]	= 50;
		weights[::Const.Attributes.Bravery] 	= 70;
		weights[::Const.Attributes.Fatigue] 	= 50;
		weights[::Const.Attributes.Initiative] 	= 60;
		weights[::Const.Attributes.MeleeSkill] 	= 40;
		weights[::Const.Attributes.RangedSkill] = 25;
		weights[::Const.Attributes.MeleeDefense] = 25;
		weights[::Const.Attributes.RangedDefense] = 30;

		local totalWeight = 0;
		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			totalWeight += weights[i];
		}

		//we want this to scale so that levels make stats more likely!		
		local chanceToGain = ::Math.min(300, 30 * this.m.LevelsGained);

		//always gain at least 1 stat!
		do
		{
			local roll = ::Math.rand(0, totalWeight);

			for(local i = 0; i<::Const.Attributes.COUNT; i++)
			{
				if( roll < weights[i] )
				{
					//::logInfo("gained " + i);

					chanceToGain -= (150-weights[i]);

					this.m.BonusAttribs[i]++;
					break;
				}
				roll -= weights[i];
			}
		}while(::Math.rand(0,totalWeight) <= chanceToGain)
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName() + " (level " + this.m.LevelsGained + ")"
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			           
		];

		local attribIcons = [
			"health",
			"bravery",
			"fatigue",
			"initiative",
			"melee_skill",
			"ranged_skill",
			"melee_defense",
			"ranged_defense"
		];
		local attribText = [
			"Hitpoints",
			"Resolve",
			"Max Fatigue",
			"Initiative",
			"Melee Skill",
			"Ranged Skill",
			"Melee Defense",
			"Ranged Defense"
		];
		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			if(this.m.BonusAttribs[i] > 0)	
			{
				ret.push({
					id = 10 + i,
					type = "text",
					icon = "ui/icons/" + attribIcons[i] + ".png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.BonusAttribs[i] + "[/color] " + attribText[i]
					
				});	
			}
		}

		if(!this.m.IsAffectedByFleeingAllies)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon allies fleeing"
			});	
		}

		if(!this.m.IsAffectedByDyingAllies)
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon allies dying"
			});	
		}

		if(!this.m.IsAffectedByLosingHitpoints)
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			});	
		}

		if(!this.m.IsAffectedByInjuries)		
		{
			ret.push({
				id = 23,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is not affected by injuries"
			});	
		}
		else if(!this.m.IsAffectedByFreshInjuries)		
		{
			ret.push({
				id = 23,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is not affected by fresh injuries sustained during the current battle"
			});	
		}

		if(this.m.MentalMoraleMult > 0)
		{
			ret.push({
				id = 24,
				type = "text",
				icon = "ui/icons/morale.png",
				text = ::MSU.Text.colorPositive("+" + this.m.MentalMoraleMult + "%") + " resistance to mental morale checks"
			});
		}

		if(this.m.InitiativeForTurnOrderMult > 1.0)
		{
			ret.push({
				id = 25,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Northern Piety: " + ::MSU.Text.colorPositive("+" + this.m.InitiativeForTurnOrderMult + "%") + " turn order initiative"				
			});
		}

		
		ret.push(
			{
				id = 40,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Old God\'s Fire will increase in effect for each level gained through battle since it was applied."
			}
		);
		ret.push(
			{
				id = 40,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The old gods do not approve of Cultists or Grand Diviners or their potions!"
			}
		);
		ret.push(
			{
				id = 41,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Called to Valhalla: This character " + ::MSU.Text.colorNegative("will always die") + " if they fall in battle."
			}
		);
        
		return ret;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);

		_out.writeU8(this.m.BaseLevel);
		_out.writeU8(this.m.LevelsGained);

		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			_out.writeU8(this.m.BonusAttribs[i]);
		}
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		
		this.m.BaseLevel = _in.readU8();
		this.m.LevelsGained = _in.readU8();

		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			this.m.BonusAttribs[i] = _in.readU8();
		}
	}
});