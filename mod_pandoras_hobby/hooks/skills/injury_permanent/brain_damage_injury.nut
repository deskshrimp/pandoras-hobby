::PandorasHobby.MH.hook("scripts/skills/injury_permanent/brain_damage_injury", function(q) {	
    q.PH_removeVisuals = @(__original) function()
    {
		__original();
		this.getContainer().getActor().getSprite("permanent_injury_1").Visible = false;
		this.getContainer().getActor().getSprite("permanent_injury_1").resetBrush();
    }
});