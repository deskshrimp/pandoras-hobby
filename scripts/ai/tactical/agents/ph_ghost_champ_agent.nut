this.ph_ghost_champ_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = "agent.ghost_champ";
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.0;
		this.m.Properties.TargetPriorityFleeingMult = 1.0;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 2.75;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 2.0;
		this.m.Properties.TargetPriorityMoraleMult = 0.25;
		this.m.Properties.TargetPriorityBraveryMult = 0.25;
		this.m.Properties.OverallDefensivenessMult = 0.5;
		this.m.Properties.OverallFormationMult = 0.25;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 1.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 5.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.25;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageRangeMax = 2;
		this.m.Properties.EngageRangeIdeal = 1;
		this.m.Properties.PreferCarefulEngage = true;
        this.m.Properties.EngageFlankingMult = 5.0;
	}

	function onAddBehaviors()
	{        
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_engage_melee"));

        local ai_attack = ::new("scripts/ai/tactical/behaviors/ai_attack_default");
        ai_attack.m.PossibleSkills.push("actives.ph_champ_ghastly_touch");
		this.addBehavior(ai_attack);

        local ai_terror = ::new("scripts/ai/tactical/behaviors/ai_attack_terror");
        ai_terror.m.PossibleSkills.push("actives.ph_champ_horrific_scream");
		this.addBehavior(ai_terror);
	}

});