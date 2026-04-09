this.steward_11_follower <- this.inherit("scripts/retinue/ph_follower_steward", {
	m = {},
    function create()
	{
		this.ph_follower_steward.create();

        this.m.ID = "follower.ph_steward_11";
		//this.m.Name = "Gruel";
		this.m.Age = ::PandorasHobby.Follower.Age.Adult;		
		this.m.BaseCost = 3000;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Young];
		this.m.LevelsSpent = this.m.Level;;

		this.m.Skills = ::PandorasHobby.Follower.Skill.Scrap_Cook | ::PandorasHobby.Follower.Skill.Cook_Preserve | ::PandorasHobby.Follower.Skill.Cook_Recipes;

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];

		//this.m.Image = "ui/campfire/ph_steward_1";
    }

	function onEvaluate()
	{
		local numGrains = this.getGrainCount();
		this.m.Requirements[0].Text = "Have " + ::Math.min(6, numGrains) + "/6 grains or rice in your stash";
		this.m.Requirements[0].IsSatisfied = (numGrains >= 6);

		this.m.Cost = this.m.BaseCost;
		if(!this.m.Requirements[0].IsSatisfied)
		{
			this.m.Cost += 750;
			this.m.Requirements[0].Text += " [+750]";
		}
	}

	function getGrainCount()
	{
		local num = 0;
		local items = this.World.Assets.getStash().getItems();
		foreach( item in items )
		{
			if (item == null || !item.isItemType(this.Const.Items.ItemType.Food))
			{
				continue;
			}

			if( item.getID() == "supplies.ground_grains" || item.getID() == "supplies.rice" )
			{
				num++;
			}
		}

		return num;
	}

	function getBaseName()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "Gruel";
		}
		else
		{
			return "Cookie";
		}
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_steward_1";
		}
		else
		{
			return "ui/campfire/cook_0";
		}
	}

	function getDescription()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			if(this.m.Age == ::PandorasHobby.Follower.Age.Adult)
			{
				return "Gruel learned to cook during his days in the militia. Apparently they \'guarded\' a granary.";
			}
			else
			{
				return "What Gruel\'s cooking lacks in flavor it makes up for in shelf life. Gruel is a master at stretching your provisions as far as they can go.";
			}
		}	
		else
		{
			return "Cookie has a habit of turning everything in poorage, but its still better than anything the men can make.";
		}	
	}

	function updateEffects()
	{
		this.m.Effects = [
			"Each day, will turn some provisions into gruel",
			"Extends provision by 5 days and knows cooking recipes",
		];

		if(this.m.Age == ::PandorasHobby.Follower.Age.Old)
		{
			this.m.Effects[0] = "Each day, will turn some provisions into gruel or jerky";			
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_steward.updateEffects();
	}
});