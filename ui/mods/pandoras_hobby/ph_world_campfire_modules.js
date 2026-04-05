var ModPandora = {};


//Capture the Left & Right click events on the main campfire screen
ModPandora.WorldCampfireScreenMainDialogModule_createSlot
    = WorldCampfireScreenMainDialogModule.prototype.createSlot;

WorldCampfireScreen.prototype.ph_notifyBackendSlotClicked = function (_data)
{
    if(this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'PH_onSlotClicked', _data);
    }
};


//right click doesn't work for some reason, so lets try ctrl-click
WorldCampfireScreenMainDialogModule.prototype.createSlot = function (_data, _i, _content) {
    ModPandora.WorldCampfireScreenMainDialogModule_createSlot.call(this, _data, _i, _content);

    var self = this;
    var slot = _content.children("img").last();
    slot.off("click");
    slot.click(function (event) {
		if (event.ctrlKey)
		{
			self.mParent.notifyBackendSlotClicked(_i);
		}
		else
		{
			self.mParent.ph_notifyBackendSlotClicked(_i);
		}		
    });
}


//hijack this to swap Hire <-> Upgrade
ModPandora.WorldCampfireScreenHireDialogModule_loadFromData = WorldCampfireScreenHireDialogModule.prototype.loadFromData;
WorldCampfireScreenHireDialogModule.prototype.loadFromData = function (_data)
{
	if (_data === undefined || _data === null || !jQuery.isArray(_data))
    {
        return;
    }

    if(_data.length == 0 || _data[0].PH_Type == 0)
    {
        this.mDialogContainer.find(".title.has-no-sub-title.title-font-very-big.font-bold.font-bottom-shadow.font-color-title").text("Upgrade");
        this.mDetailsPanel.HireButton.find(".label").text("Upgrade");
    }
    else
    {
        this.mDialogContainer.find(".title.has-no-sub-title.title-font-very-big.font-bold.font-bottom-shadow.font-color-title").text("Hire Follower");
        this.mDetailsPanel.HireButton.find(".label").text("Hire");
    }

	ModPandora.WorldCampfireScreenHireDialogModule_loadFromData.call(this, _data);	
}