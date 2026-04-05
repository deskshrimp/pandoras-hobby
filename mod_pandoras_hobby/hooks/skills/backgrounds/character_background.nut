::PandorasHobby.MH.hook("scripts/skills/backgrounds/character_background", function(q) {

        //add a new method
        q.PH_isCultist <- function()
        {
            return (this.getID() == "background.cultist" || this.getID() == "background.converted_cultist")
        }
});