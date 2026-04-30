::PandorasHobby.MH.hook("scripts/retinue/retinue_manager", function(q) {
	q.m.PH_Flags <- null;

	q.m.PH_Trainers <- [];

	q.PH_getFlags <- function(){
		return this.m.PH_Flags;
	}

    //reroute the loading system to use our new followers folder
    q.create = @() function() {
        if (!this.Const.DLC.Desert)
		{
			return;
		}

		this.m.PH_Flags = this.new("scripts/tools/tag_collection");

		local scriptFiles = this.IO.enumerateFiles("scripts/retinue/pandora_followers/");

		foreach( scriptFile in scriptFiles )
		{
			local f = ::new(scriptFile);

			//if(f == null) ::logError("Failed to load File: " + scriptFile);

			if (f.isValid())
			{
				this.m.Followers.push(f);
				f.updateBasicInfo(this.PH_getFlags());				
			}
		}

		scriptFiles = this.IO.enumerateFiles("scripts/retinue/pandora_trainers/");
		foreach( scriptFile in scriptFiles )
		{
			local t = ::new(scriptFile);

			//::logWarning("Load: " + scriptFile);

			if (t.isValid())
			{
				this.m.PH_Trainers.push(t);				
			}
		}

		this.m.Slots.resize(5);
    }

	q.getNumberOfUnlockedSlots = @() function() {
		return this.m.Slots.len();
	}

	q.getCurrentFollowersForUI = @(__original) function()
	{
		foreach(f in this.m.Slots)
		{
			if(f == null) continue;

			f.updateEffects();
		}

		return __original();
	}

    //modify the menu list to filter for the specific slot being clicked!
    q.getFollowersForUI  = @() function( _slot = 99 ) {
        local ret = [];

		    foreach( p in this.m.Followers )
		    {
			    if (this.hasFollower(p.getID()) || !p.isVisible())
			    {
				    continue;
			    }
								
                //apply class filters for the menu
				if(p.getArchetype() != _slot)
				{
				    continue;
			    }
				
			    p.evaluate();
				p.updateEffects();
			    ret.push({
				    ImagePath = p.getImage() + ".png",
				    ID = p.getID(),
				    Name = p.getName(),
				    Description = p.getDescription(),
				    IsUnlocked = p.isUnlocked(),
				    Cost = p.getCost(),
					Effects = p.getEffects(),
				    Requirements = p.getRequirements(),
					PH_Type = ::PandorasHobby.Follower.Type.Follower
			    });
		    }

		    ret.sort(this.onFollowerCompare);
	    return ret;
    }

	q.PH_getTrainersForUI <- function( _slot = 99 ) {
		//if the slot is empty redirect to the hire dialog
		if(this.m.Slots[_slot] == null)
		{
			return this.getFollowersForUI(_slot);
		}

        local ret = [];

		    foreach( p in this.m.PH_Trainers )
		    {
				if(p.getArchetype() != _slot)
				{
					continue;
				}

			    if (!p.isVisible())
				{
					continue;
				}

			    p.evaluate();
			    ret.push({
				    ImagePath = p.getImage() + ".png",
				    ID = p.getID(),
				    Name = p.getName(),
				    Description = p.getDescription(),
				    IsUnlocked = p.isUnlocked(),
				    Cost = p.getCost(),
					Effects = p.getEffects(),
				    Requirements = p.getRequirements(),
					PH_Type = ::PandorasHobby.Follower.Type.Trainer
			    });
		    }

		    ret.sort(this.PH_onTrainerCompare);
	    return ret;
    }

	q.setFollower = @(__original) function( _slot, _follower ) {
		_follower.onHired(); //initialize their flags and settings!
		__original(_slot, _follower);
	}

	q.upgradeFollower <- function( _slot, _follower ) {
		//upgrade the matching follower!
		this.m.Slots[_follower.getArchetype()].learnSkill(_follower.getSkill());
		
		//same call made when hiring to force an update
		this.World.Assets.resetToDefaults();
	}

	q.getFollower = @(__original) function( _id ) {
		if(_id == "follower.cartographer")
		{
			return this.m.Slots[::PandorasHobby.Follower.Archetype.Ranger];
		}
		else if(_id == "follower.bounty_hunter")
		{
			return this.m.Slots[::PandorasHobby.Follower.Archetype.Officer];
		}

		return __original( _id );
	}

	q.PH_getTrainer <- function( _id ) {
		if (_id.len() == 0)
		{
			return null;
		}

		foreach( a in this.m.PH_Trainers )
		{
			if (a.getID() == _id)
			{
				return a;
			}
		}

		return null;
	}

	q.hasFollower = @(__original) function( _id ) {
		//handle some of the old follower present checks
		if(_id == "follower.drill_sergeant")
		{
			//Used for bonus experience check
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Officer, ::PandorasHobby.Follower.Skill.Drill_BoostXP);
		}
		else if(_id == "follower.agent")
		{
			//Used for showing settlement info (checked on hover?)
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Agent, ::PandorasHobby.Follower.Skill.Agent_Settlements);
		}
		else if(_id == "follower.scout")
		{
			//this is used in the sickness event and many terrain hazard events (desert, mountains, etc)
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Ranger, ::PandorasHobby.Follower.Skill.Guide_Move);
		}
		else if(_id == "follower.cartographer")
		{
			//only used in the check for payment
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Ranger, ::PandorasHobby.Follower.Skill.Carto_Pay);
		}
		else if(_id == "follower.alchemist")
		{
			//Used for the 25% refund and vanilla Unlocking Snake Oil recipes
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Snake_Oil_All);
		}
		else if(_id == "follower.cook")
		{
			//Used for rotten food event
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Steward, ::PandorasHobby.Follower.Skill.Cook_Recipes);
		}
		else if(_id == "follower.bounty_hunter"){
			//this is called everytime a champion is killed! (can track here -- or hook Actor.Kill() )
			//tracking here means it was already verified as a player kill etc
			::World.Statistics.getFlags().increment("PH_ChampionsKilled");
			
			//only the collector pays for champions
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Officer, ::PandorasHobby.Follower.Skill.Collector_Pay);
		}
		else if(_id == "follower.paymaster")
		{
			//Used for various pay raise events & the desertion check
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Officer, ::PandorasHobby.Follower.Skill.Paymaster_Disc_2);
		}
		else if(_id == "follower.trader")
		{
			//Used for stocking shops
			return this.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Agent, ::PandorasHobby.Follower.Skill.Trader_Trade);
		}
		else if(_id == "follower.surgeon"){
			//only used in injury check (disabled by Hardened), but I'll add the check here anyways
			return this.PH_HasFollowerTypeWithExactSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Medic_Survive | ::PandorasHobby.Follower.Skill.Medic_Heal_Rate);
		}

		//there are no vanilla checks for "follower.blacksmith", "follower.brigand", "follower.lookout", "follower.minstrel", "follower.negotiator", "follower.quartermaster", "follower.recruiter", "follower.scavenger"

		return __original( _id );
	}

	q.PH_HasFollowerOfType <- function(_type)
	{
		return (this.PH_getFollowerAtIndex(_type) != null);
	}

	q.PH_HasFollowerTypeWithSkill <- function(_type, _skill){
		local f = this.PH_getFollowerAtIndex(_type);
		if(f == null) return false;

		return f.hasSkill(_skill);
	}

	q.PH_HasFollowerTypeWithExactSkill <- function(_type, _skill){
		local f = this.PH_getFollowerAtIndex(_type);
		if(f == null) return false;

		return f.hasExactSkill(_skill);
	}

	q.PH_getFollowerAtIndex <- function(_ind)
	{
		if(_ind >= this.m.Slots.len()) return null;

		return this.m.Slots[_ind];
	}

	q.onSerialize = @(__original) function( _out ){
		__original(_out);
		this.m.PH_Flags.onSerialize(_out);
	}

	q.onDeserialize = @(__original) function( _in ){
		__original(_in);
		this.m.PH_Flags.onDeserialize(_in);

		foreach(f in this.m.Followers)
		{
			f.updateBasicInfo(this.PH_getFlags());
		}
	}

	q.PH_onTrainerCompare <- function ( _f1, _f2 )
	{
		if (_f1.IsUnlocked && !_f2.IsUnlocked)
		{
			return -1;
		}
		else if (!_f1.IsUnlocked && _f2.IsUnlocked)
		{
			return 1;
		}		
		else if (_f1.ID < _f2.ID)
		{
			return -1;
		}
		else if (_f1.ID > _f2.ID)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
});