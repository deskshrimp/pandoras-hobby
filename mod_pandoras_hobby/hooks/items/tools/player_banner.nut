::PandorasHobby.MH.hook("scripts/items/tools/player_banner", function(q) {    
    q.create = @(__original) function(){
        __original();

        this.m.ItemProperty = ::Const.Items.Property.PlayerBattleStandard;
    }
});