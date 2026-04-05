::PandorasHobby.MH.hook("scripts/ui/screens/world/modules/world_campfire_screen/campfire_hire_dialog_module", function(q) {
    
    //overwrite the original method to add the data arg we require
    q.queryHireInformation = @() function() {

        return {
			Roster = ::World.Retinue.getFollowersForUI(this.m.CurrentSlot),
			Assets = this.m.Parent.queryAssetsInformation()
		};
    }

    q.PH_queryUpgradeInformation <- function()
    {
        return {
			Roster = ::World.Retinue.PH_getTrainersForUI(this.m.CurrentSlot),
			Assets = this.m.Parent.queryAssetsInformation()
		};
    }

    q.onHireFollower = @(__original) function( _followerID )
    {
        if(::World.Retinue.PH_getFollowerAtIndex(this.m.CurrentSlot) == null) return __original( _followerID );

        local trainer = this.World.Retinue.PH_getTrainer(_followerID);

        if(trainer == null) return __original( _followerID );

        local currentMoney = ::World.Assets.getMoney();
		local hiringCost = trainer.getCost();

        if (currentMoney < hiringCost)
		{
			return {
				Result = this.Const.UI.Error.NotEnoughMoney,
				Assets = null
			};
		}

        ::World.Retinue.upgradeFollower(this.m.CurrentSlot, trainer);
		::World.Assets.addMoney(-hiringCost);
		::World.State.updateTopbarAssets();
		return {
			Result = 0
		};
    }
});