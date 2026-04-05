::PandorasHobby.MH.hook("scripts/ui/screens/world/world_campfire_screen", function(q) {

	q.PH_onSlotClicked <- function( _data )
	{
		//our custom left click catcher
		//open the upgrade menu if possible
	
		//::logError("PH CLICK");
		
		if (this.isAnimating())
		{
			return;
		}
		
		this.m.HireDialogModule.setCurrentSlot(_data);
		this.PH_showUpgradeDialog();
	}
	
	/*
	//let vanilla do vanilla things
	q.onSlotClicked = @(__original) function( _data )
	{
	
		::logError("VANILLA CLICK");
		
		__original(_data);
	}
	*/

	q.PH_showUpgradeDialog <- function()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.HireDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showHireDialog", this.m.HireDialogModule.PH_queryUpgradeInformation());
		}
	}
});