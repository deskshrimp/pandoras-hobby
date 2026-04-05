::PandorasHobby.MH.hook("scripts/items/special/spiritual_reward_item", function(q) {    
    q.updateVariant = @() function(){
        __original();

        if(this.m.Variant > 100)
        {
            this.m.Description = "A special potion made using secret methods of extracting knowledge and memories from the dead. It is said to impart the wisdom of the fallen to those who imbide it.";
        }
    }
});