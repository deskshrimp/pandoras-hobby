::PandorasHobby.MH.hook("scripts/ui/screens/world/modules/world_town_screen/town_travel_dialog_module", function(q) {

    q.fastTravelTo = @(__original) function( _dest )
    {
        __original( _dest );

        ::World.Statistics.getFlags().increment("PH_PortFastTravelUsed");
    }
});