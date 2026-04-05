::PandorasHobby.MH.hook("scripts/events/events/cultist_finale_event", function(q) {
    
    //completely replace the normal score calculation
    q.onUpdateScore = @() function()
    {
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 200)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
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

				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && (bro.getBackground().getID() == "background.cultist" || hasSpook) )
				{
					bestCultist = bro;
				}
			}
			else if (bro.getLevel() >= 11 && !bro.getSkills().hasSkill("trait.player") && !bro.getFlags().get("IsPlayerCharacter") && !bro.getFlags().get("IsPlayerCharacter"))
			{
				sacrifice_candidates.push(bro);
			}
		}

		local numCultists = cultist_candidates.len();
		if( hasSpook ) numCultists++;

		if (numCultists <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[::Math.rand(0, sacrifice_candidates.len() - 1)];

		//default 3 is really really low! (even this score of 15-20 will be quite rare to trigger)
		this.m.Score = numCultists + bestCultist.getLevel();
	}
});