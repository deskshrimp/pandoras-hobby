::PandorasHobby.MH.hook("scripts/skills/injury_permanent/missing_ear_injury", function(q) {
    q.PH_removeVisuals = @(__original) function()
    {
        __original();
		this.getContainer().getActor().getSprite("permanent_injury_2").Visible = false;
		this.getContainer().getActor().getSprite("permanent_injury_2").resetBrush();
    }
});