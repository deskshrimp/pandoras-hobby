::PandorasHobby.MH.hook("scripts/crafting/blueprint", function(q) {
    
    //add a new type field
    q.m.PH_Type  <- ::PandorasHobby.Blueprint.Type.Misc;

    //hook the crafting method to include new stat tracking for types
    q.craft = @(__original) function()
    {
        __original();

        if(this.m.PH_Type == ::PandorasHobby.Blueprint.Type.Misc) return;

        switch(this.m.PH_Type)
        {
            case ::PandorasHobby.Blueprint.Type.SnakeOil:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_SnakeOil");
            break;
            case ::PandorasHobby.Blueprint.Type.Alchemy:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Alchemy");
            break;

            case ::PandorasHobby.Blueprint.Type.Equip:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Equips");
            break;
            case ::PandorasHobby.Blueprint.Type.Upgrade:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Upgrades");
            break;

            case ::PandorasHobby.Blueprint.Type.Medicine:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Medicine");
            break;

            case ::PandorasHobby.Blueprint.Type.Anatomist:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Anatomist");
            break;
            case ::PandorasHobby.Blueprint.Type.Cultist:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Cultist");
            break;

            case ::PandorasHobby.Blueprint.Type.Food:
                ::World.Statistics.getFlags().increment("PH_ItemsCrafted_Food");
            break;
        };     
    }

    q.create = @(__original) function()
    {
        __original();

        if (this.m.ID.find("upgrade") != null)
        {
            //this will include all armor attachments and dog armor
            this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Upgrade;
        }
        else if (this.m.ID.find("shield") != null || this.m.ID.find("trophy") != null)
        {
            //all shields & trophy necklaces
            this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Equip;
        }
        else if (this.m.ID.find("potion") != null || this.m.ID.find("elixir") != null || this.m.ID.find("flask") != null || this.m.ID.find("pot") != null)
        {
            //all the buff potions (lionheart, night owl, etc)
            //also all the pots and flasks (fire, smoke, etc)
            this.m.PH_Type = ::PandorasHobby.Blueprint.Type.Alchemy;
        }
    }
});
