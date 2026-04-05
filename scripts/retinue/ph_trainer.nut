this.ph_trainer <- this.inherit("scripts/retinue/follower", {
    m = {
        Type = ::PandorasHobby.Follower.Type.Trainer,
        Archetype = ::PandorasHobby.Follower.Archetype.Ranger,

        Skill = ::PandorasHobby.Follower.Skill.None,
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

    function getSkill()
    {
        return this.m.Skill;
    }

    function checkRequiredSkill(_skill)
    {
        return ::World.Retinue.PH_HasFollowerTypeWithExactSkill(this.m.Archetype, _skill);        
    }

    function getAvailableSkillPoints()
    {
        local f = ::World.Retinue.PH_getFollowerAtIndex(this.m.Archetype);
        if(f == null) return 0;

        return f.getAvailableSkillPoints();
    }

    function isVisible()
	{
        return !(::World.Retinue.PH_HasFollowerTypeWithSkill(this.m.Archetype, this.m.Skill));
	}
});