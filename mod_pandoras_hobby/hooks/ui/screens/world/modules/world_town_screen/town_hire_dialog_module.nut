::PandorasHobby.MH.hook("scripts/ui/screens/world/modules/world_town_screen/town_hire_dialog_module", function(q)
{
    q.onTryoutRosterEntry = @(__original) function( _entityID )
    {
         local ret = __original( _entityID );

         if(ret.Result == 0)
         {
            ::World.Statistics.getFlags().increment("PH_TryoutsBought");
         }

         return ret;
    }
});
