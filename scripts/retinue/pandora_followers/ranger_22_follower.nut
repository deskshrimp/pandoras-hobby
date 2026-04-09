this.ranger_22_follower <- this.inherit("scripts/retinue/ph_follower_ranger", {
	m = {},
    function create()
	{
		this.ph_follower_ranger.create();

        this.m.ID = "follower.ph_ranger_22";
		//this.m.Name = "Old Bear";
		this.m.Age = ::PandorasHobby.Follower.Age.Old;
		this.m.BaseCost = 6000;
		this.m.Cost = this.m.BaseCost;
		
		this.m.Level = ::PandorasHobby.Follower.AgeThreshold[::PandorasHobby.Follower.Age.Adult];
		this.m.LevelsSpent = this.m.Level - 3; //has unspent levels!

		this.m.Skills = ::PandorasHobby.Follower.Skill.OldBear_Ammo | ::PandorasHobby.Follower.Skill.Raider_Snow_1 | ::PandorasHobby.Follower.Skill.Raider_Snow_2;

		//this.m.Description = "A retired barbarian raider is a rare bird, but Old Bear wasn't in a hurry to see Valahlla.";

        this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Raider's Spirit.... and a bucket of gold."
			}
		];

		//this.m.Image = "ui/campfire/ph_ranger_2";
    }

    function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = true;
	}

	function getBaseName()
	{
		return "Old Bear";
	}

	function getImagePath()
	{
		if (::PandorasFollowers.PACK_ID == "AI" )
		{
			return "ui/campfire/ph_ranger_2";
		}
		else
		{
			return "ui/campfire/brigand_0";
		}
	}

	function getDescription()
	{
		return "A retired barbarian raider is a rare bird, but Old Bear wasn't in a hurry to see Valahlla.";
	}

	function updateEffects()
	{
		this.m.Effects = [
			"+5 Ammo Capacity per man on your Roster",
			"+15% speed on snow & tundra"
		];

		if(::World != null && ::World.getPlayerRoster() != null)
		{
			local val = ::World.getPlayerRoster().getSize() * 5;
			this.m.Effects[0] += " [+" + val + "]";
		}

		local used = this.m.LevelsSpent;
		local free = this.m.Level - this.m.LevelsSpent;
		this.m.Effects.push("Has learned " + used + " skills & has " + free + " unused points");

		this.m.TooltipEffects = [
			this.m.Effects[0],
		];

		this.ph_follower_ranger.updateEffects();
	}
});