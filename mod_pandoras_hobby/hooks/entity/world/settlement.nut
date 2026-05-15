::PandorasHobby.MH.hook("scripts/entity/world/settlement", function(q) {

    q.getTooltip = @(__original) function()
    {
        local ret = __original();

        if (!::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Agent, ::PandorasHobby.Follower.Skill.Agent_Settlements))
        {
            return ret;
        }

        local reports = [];

        foreach (s in this.getSituations())
        {
            reports.push({
                id = 900,
                type = "text",
                icon = s.getIcon(),
                text = s.getName()
            });
        }

        foreach (c in this.getContracts())
        {
            reports.push({
                id = 901,
                type = "text",
                icon = "ui/icons/contract_scroll.png",
                text = c.getName()
            });
        }

        if (reports.len() != 0)
        {
            ret.push({
                id = 899,
                type = "hint",
                icon = "ui/icons/special.png",
                text = "Agent reports",
                children = reports
            });
        }

         return ret;
    }
});
