::PandorasHobby.MH.hook("scripts/events/events/come_across_ritual_event", function(q) {
    
	//completely replace the normal score calculation
    q.onUpdateScore = @() function()
    {
		if (::World.getTime().IsDaytime)
		{
			return;
		}

		if (::World.getTime().Days <= 200)
		{
			return;
		}

		local playerTile = ::World.State.getPlayer().getTile();
		local towns = ::World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d >= 4 && d <= 10)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		if (!::World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();
		local candidates = [];
		local maxLevel = 0;

		foreach( bro in brothers )
		{
			if ( bro.getLevel() >= 11 && bro.PH_isCultist() )
			{
				candidates.push(bro);
				if(bro.getLevel() > maxLevel) maxLevel = bro.getLevel();
			}
		}

		local numCultists = candidates.len();
		if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist) ) numCultists++;

		if(numCultists < 2)
		{
			return;
		}

		if (candidates.len() != 0)
		{
			this.m.Cultist = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		//default 3 is really really low! (even this score of 15-20 will be quite rare to trigger)
		this.m.Score = numCultists + maxLevel;
    }
});