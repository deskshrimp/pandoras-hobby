this.ph_follower <- this.inherit("scripts/retinue/follower", {
    m = {
        Type = ::PandorasHobby.Follower.Type.Follower,
        Archetype = ::PandorasHobby.Follower.Archetype.Agent,
        Age = ::PandorasHobby.Follower.Age.Young,
        XP = 0,        
        Level = 1,
        LevelsSpent = 1,
        BaseCost = 0,
        Skills = ::PandorasHobby.Follower.Skill.None,
        
        DailyOdds = 0,
        DailyMax = 0,

        TooltipEffects = [],
    },
    function create()
	{
        this.follower.create();
	}

    function getType()
    {
       return this.m.Type;
    }

    function getArchetype()
    {
       return this.m.Archetype;
    }

    function getAge()
    {
        return this.m.Age;
    }

    function getName()
	{
        if (::PandorasFollowers.PACK_ID == "AI" )
        {
            return this.getBaseName() + " (" + ::PandorasHobby.Follower.ArchetypeStrings[this.m.Archetype] + ": lvl " + this.m.Level + ")";
        }
        else
        {            
            return this.getBaseName() + " (" + ::PandorasHobby.Follower.ArchetypeStrings[this.m.Archetype] + ": lvl " + this.m.Level + ") R" + (this.m.Age+1);
        }		
	}

    function getBaseName()
    {
        return this.m.Name;
    }

    function getImage()
    {
        local age = (::PandorasFollowers.PACK_ID == "AI" ) ? this.m.Age : 1;

        if(this.m.LevelsSpent < this.m.Level && !this.isMaxLevel()) return this.getImagePath() + age + "_u";
        return this.getImagePath() + age;
    }

    function getImagePath()
    {
        return this.m.Image;
    }

    function isMaxLevel()
    {
        return false;
    }

    function getKeyName(_key)
    {
        return this.m.ID + _key;
    }

    function setFlag(_key, _val)
	{
		::World.Retinue.PH_getFlags().set(this.getKeyName(_key), _val);
	}

	function getFlag(_key)
	{		
		return ::World.Retinue.PH_getFlags().getAsInt(this.getKeyName(_key));
	}

    function hasSkill( _skill )
    {
        return (this.m.Skills & _skill) != 0;
    }

    function hasExactSkill( _skill )
    {
        return (this.m.Skills & _skill) == _skill;
    }

    function isUnlocked()
    {
        //always unlocked!
        return true;
    }

    function updateBasicInfo(_flags)
    {
        local key = this.getKeyName("Age");
        local val = this.updateAge(_flags.getAsInt(key));
        _flags.set(key, val);

        key = this.getKeyName("XP");
        val = this.updateXP(_flags.getAsInt(key));
        _flags.set(key, val);

        key = this.getKeyName("LVL");
        val = this.updateLevel(_flags.getAsInt(key));
        _flags.set(key, val);

        key = this.getKeyName("LVLSpent");
        val = this.updateLevelsSpent(_flags.getAsInt(key));
        _flags.set(key, val);

        key = this.getKeyName("Skills");
        val = this.updateSkills(_flags.getAsInt(key));
        _flags.set(key, val);

        //this is called during load and causing issues, global vars aren't ready yet.
        //this.updateEffects();
    }

    function updateAge(_age)
    {
        if(_age > this.m.Age) this.m.Age = _age;
        return this.m.Age;
    }

    function updateXP(_xp)
    {
        if(_xp > this.m.XP) this.m.XP = _xp;
        return this.m.XP;
    }

    function updateLevel(_level)
    {
        if(_level > this.m.Level) this.m.Level = _level;
        return this.m.Level;
    }

    function updateLevelsSpent(_levelsSpent)
    {
        if(_levelsSpent > this.m.LevelsSpent) this.m.LevelsSpent = _levelsSpent;
        return this.m.LevelsSpent;
    }

    function updateSkills(_skills)
    {
        if(_skills > this.m.Skills) this.m.Skills = _skills;
        return this.m.Skills;
    }

    function getAvailableSkillPoints()
    {
        return this.m.Level - this.m.LevelsSpent;
    }

    function learnSkill(_skill)
    {
        this.m.Skills = this.m.Skills | _skill;         
        this.setFlag("Skills", this.m.Skills);

        this.m.LevelsSpent++;
        this.setFlag("LVLSpent", this.m.LevelsSpent);

        this.updateEffects();
    }

    function onHired()
    {
		this.wasHired();
		
		this.updateEffects();
		this.updateValueTrackers();
    }

	function wasHired()
    {
    }

    function onNewDay()
	{	
        //::logInfo( ::PandorasHobby.Follower.ArchetypeStrings[this.m.Archetype] + " -> earnDailyXP" );
        //earn DailyXP (must be handled by each follower class)
        this.earnDailyXP();

        //::logInfo( ::PandorasHobby.Follower.ArchetypeStrings[this.m.Archetype] + " -> wasNewDay" );
        //let followers do any daily tasks they need to like Hunting
        this.wasNewDay();
	}

    function earnDailyXP()
    {
        /*  //No, we do not want generic free XP, onyl thematic things for the various faollower types.
        //provide a source of daily xp
        //will be less reliable as they gain levels
        if(::Math.rand(1,10) >= this.m.Level)
        {
            this.m.XP += 1;
        }
        //each archetype could have their own criteria to boost daily xp (to set the max roll to increased the odds)
        //is this for the base point? or a second point? (could lower the odds for the base point a little -- eg 8 vs 10 to compensate)
        //Ranger [11] - legendary locations [~15]
        //Healer [13] - # men [12 to 27 depending on the scenario]
        //Steward [11] - cart upgrades [8]
        //Officer [11] - # men
        //Agent [10] - # active alliances [~22 locations usually, but unlikely to have more than 5 or so]
        //or this may all simply overcomplicate things. We want to reward actions, not waiting! Look at the core xp gain instead of here!
        */
    }

    function wasNewDay()
	{
	}

    function updateEffects()
	{
	}

	function updateValueTrackers()
	{
	}

    function getXPForNextLevel()
    {
        //10 + 5 per level after 1 (any other modifiers?)
        //this requires 385 total xp to reach lvl 11
        return 10 + (this.m.Level-1)*5;
    }

    function checkForLevelAge()
    {
        local threshold = getXPForNextLevel();

        if(this.m.XP < threshold)
        {
            this.setFlag("XP", this.m.XP);
            return false;
        }

        this.m.XP -= threshold;
        this.m.Level++;

        this.setFlag("LVL", this.m.Level);
        this.setFlag("XP", this.m.XP);
        
        if(this.m.Age == ::PandorasHobby.Follower.Age.Old) return false;
        if(this.m.Level < ::PandorasHobby.Follower.AgeThreshold[this.m.Age]) return false;

        this.m.Age++;
        this.setFlag("Age", this.m.Age);

        return true;
    }

    function getXPHintText()
    {        
    }

    function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 4,
				type = "description",
				text = this.getDescription()
			}
		];

        ret.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/level.png",
			value = this.m.XP,
			valueMax = this.getXPForNextLevel(),
			text = "" + this.m.XP + " / " + this.getXPForNextLevel() + "",
			style = "armor-body-slim"
		});

        ret.push({
			id = 5,
			type = "hint",
			icon = "ui/icons/xp_received.png",
			text = this.getXPHintText()
		});

        if(this.m.DailyMax > 0)
        {
            ret.push({
			    id = 6,
			    type = "hint",
			    icon = "ui/icons/xp_received.png",
                text = "Daily XP Odds: (" + this.m.DailyOdds + "/" + this.m.DailyMax + ") = " + ::Math.round(this.m.DailyOdds * 100.0 / this.m.DailyMax) + "%"
		    });
        }

		foreach( i, e in this.m.TooltipEffects )
		{
			ret.push({
				id = i + 10,
				type = "text",
				icon = (i==0 ? "ui/icons/perks.png" : "ui/icons/special.png"),
				text = e
			});
		}		
		
		ret.push({
			id = 42,
			type = "hint",
			icon = "ui/icons/action_points.png",
			text = "Followers update XP & levels daily."
		});
        
		ret.push({
			id = 43,
			type = "hint",
			icon = "ui/icons/mouse_left_button.png",
			text = "Open Upgrade Screen to spend available levels"
		});

        ret.push({
			id = 43,
			type = "hint",
			icon = "ui/icons/ph_mouse_left_button_ctrl.png",
			text = "Open Hiring Screen to replace"
		});

		return ret;
	}
});