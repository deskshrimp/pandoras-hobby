::PandorasHobby.MH.hook("scripts/ui/screens/world/modules/world_town_screen/town_temple_dialog_module", function(q) {

    //overwrite the original to add in the option to treat permanent injuries!
    q.queryRosterInformation = @() function() 
	{        
        local brothers = ::World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			local injuries = [];

			//check for a discount
			local priceMult = 1.0;
			//we have no discount skills atm

			//set the filter
			local filter = ::Const.SkillType.TemporaryInjury;
			if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Temple_PInj) )
			{
				filter = filter | ::Const.SkillType.PermanentInjury;
			}

			local allInjuries = b.getSkills().query(filter);

			//can we treat sickness?
			if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_2) )
			{
				local sick = b.getSkills().getSkillByID("injury.sickness");
				if(sick != null) allInjuries.push(sick);
			}

			for( local i = 0; i != allInjuries.len(); i = ++i )
			{
				local inj = allInjuries[i];

				if (!inj.isTreated() && inj.isTreatable() )
				{
					injuries.push({
						id = inj.getID(),
						icon = inj.getIconColored(),
						name = inj.getNameOnly(),
						price = (inj.getPrice() * priceMult)
					});
				}
			}

			if (injuries.len() == 0)
			{
				continue;
			}

			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				Injuries = injuries
			};
			roster.push(e);
		}

		return {
			Title = "Temple",
			SubTitle = "Have your wounded treated and prayed for by priests",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};
    }

	//overwrite the check to include permanent injuries!
	q.onTreatInjury = @() function( _data )
	{
		local entityID = _data[0];
		local injuryID = _data[1];
		local entity = this.Tactical.getEntityByID(entityID);
		local injury = entity.getSkills().getSkillByID(injuryID);
		injury.setTreated(true);
		this.World.Assets.addMoney(-injury.getPrice());
		entity.updateInjuryVisuals();

		local injuries = [];
		local filter = ::Const.SkillType.TemporaryInjury;
		if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Temple_PInj) )
		{
			filter = filter | ::Const.SkillType.PermanentInjury;
		}
		local allInjuries = entity.getSkills().query(filter);

		if( ::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_2) )
		{
			local sick = entity.getSkills().getSkillByID("injury.sickness");
			if(sick != null) allInjuries.push(sick);
		}

		//check for a discount
		local priceMult = 1.0;
		//none atm

		foreach( inj in allInjuries )
		{
			if (!inj.isTreated() && inj.isTreatable())
			{
				injuries.push({
					id = inj.getID(),
					icon = inj.getIconColored(),
					name = inj.getNameOnly(),
					price = (inj.getPrice() * priceMult)					
				});
			}
		}

		local background = entity.getBackground();
		local e = {
			ID = entity.getID(),
			Name = entity.getName(),
			ImagePath = entity.getImagePath(),
			ImageOffsetX = entity.getImageOffsetX(),
			ImageOffsetY = entity.getImageOffsetY(),
			BackgroundImagePath = background.getIconColored(),
			BackgroundText = background.getDescription(),
			Injuries = injuries
		};
		local r = {
			Entity = e,
			Assets = this.m.Parent.queryAssetsInformation()
		};
		if(injury.isType(::Const.SkillType.PermanentInjury))
		{
			::World.Statistics.getFlags().increment("PermInjuriesTreatedAtTemple");
		}
		::World.Statistics.getFlags().increment("InjuriesTreatedAtTemple");
		this.updateAchievement("PatchedUp", 1, 1);
		return r;
	}
});