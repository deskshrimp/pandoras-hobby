::PandorasHobby.MH.hook("scripts/ui/screens/world/modules/world_campfire_screen/campfire_main_dialog_module", function(q) {

        //modify the data return to use our images instead
        q.queryData = @(__original) function() {
            local ret = __original();
            ret.Cart = "ui/campfire/ph_cart_0" + this.World.Retinue.getInventoryUpgrades();
            return ret;
        }
});