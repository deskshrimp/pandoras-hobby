::PandorasHobby.MH.hook("scripts/items/misc/anatomist/anatomist_potion_item", function(q) {

    /*
    //check our variant flag to see if the potion was crafted
    q.wasCrafted <- function()
    {
        return (this.m.Variant > 100);
    }
    */

    q.onUse = @(__original) function( _actor, _item = null )
    {
        //::logError("ON USE - Anatomist == " + this.m.Variant);
        
        //check our variant flag to see if the potion was crafted
        if(this.m.Variant > 100)
        {
            //set a flag on the character using the potion ID
            local effectID = this.m.Description = ::MSU.String.replace(this.m.ID, "misc.", "effects.");
            _actor.getFlags().increment(effectID);
        }

        return __original(_actor, _item);
    }
});