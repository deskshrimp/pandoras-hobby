::PandorasHobby.MH.hook("scripts/skills/backgrounds/cultist_background", function(q) {

    //add our new equips to the pool of options
    q.onAddEquipment = @(__original) function()
    {
        __original();

        //add chance to start with a scalpel
        if(::Math.rand(0,100) < 20)
        {
            local items = this.getContainer().getActor().getItems();
            items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
            items.equip(this.new("scripts/items/weapons/ph_scalpel"));
        }
    }
});
