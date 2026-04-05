::PandorasHobby.MH.hook("scripts/events/events/dlc4/cultist_origin_armor_event", function(q) {
    
    //completely replace the normal score calculation
    q.onUpdateScore = @(__original) function()
    {
        __original();

        if (!this.Const.DLC.Wildmen)
		{
			return;
		}

        local hasSpook = ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist);

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists" && !hasSpook)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if ( bro.PH_isCultist() )
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = ::World.Assets.getStash().getItems();
		local numItems = 0;

		foreach( item in stash )
		{
			if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson"))
			{
				numItems = ++numItems;
			}
		}

		if (numItems == 0)
		{
			return;
		}

		this.m.Tailor = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = numItems * 5;
    }
});