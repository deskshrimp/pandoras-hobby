::PandorasHobby.MH.hook("scripts/events/events/dlc4/cultist_origin_finale_event", function(q) {
    
    q.onUpdateScore = @() function()
    {
        if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 150)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 12)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local sacrifice_candidates = [];
		local cultist_candidates = [];
		local bestCultist;

        local hasSpook = ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist);

		foreach( bro in brothers )
		{
			if ( bro.PH_isCultist() )
			{
				cultist_candidates.push(bro);

				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && (bro.getBackground().getID() == "background.cultist" || hasSpook))
				{
					bestCultist = bro;
				}

				if (bro.getLevel() >= 11)
				{
					sacrifice_candidates.push(bro);
				}
			}
		}

        local numCultists = cultist_candidates.len() + (hasSpook ? 1: 0);

		if (numCultists <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() < 2)
		{
			return;
		}

		for( local i = 0; i < sacrifice_candidates.len(); i = ++i )
		{
			if (bestCultist.getID() == sacrifice_candidates[i].getID())
			{
				sacrifice_candidates.remove(i);
				break;
			}
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[::Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = numCultists + bestCultist.getLevel(); 
		this.m.Score += numCultists; //extra boost for being the origin-specific version
    }
});