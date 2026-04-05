::PandorasHobby.MH.hook("scripts/ui/screens/world/modules/world_town_screen/town_tavern_dialog_module", function(q)
{
    q.onQueryRumor = @(__original) function()
    {
         ::World.Statistics.getFlags().increment("PH_RumorsBought");

         return __original();
    }
});
