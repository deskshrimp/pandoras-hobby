::PandorasHobby.MH.hook("scripts/entity/world/settlements/buildings/weaponsmith_building", function(q) {

    q.fillStash = @(__original) function( _list, _stash, _priceMult, _allowDamagedEquipment = false )
    {
        if(this.m.ID == "building.weaponsmith_oriental")
        {
            _list.push({
				R = 50,
				P = 1.1,
				S = "weapons/ph_scalpel_grip"
			});
        }        
        else if(this.m.ID == "building.weaponsmith")
        {
            _list.push({
				R = 50,
				P = 1.1,
				S = "weapons/ph_scalpel"
			});
			_list.push({
				R = 85,
				P = 1.1,
				S = "weapons/ph_scalpel_grip"
			});
        }
        else if(this.m.ID == "building.armorsmith_oriental")
        {
            _list.push({
				R = 75,
				P = 1.0,
				S = "helmets/ph_adventurers_headgear"
			});
             _list.push({
				R = 75,
				P = 1.0,
				S = "armor/ph_adventurers_carapace"
			});
        }
        else if(this.m.ID == "building.armorsmith")
        {
            _list.push({
				R = 80,
				P = 1.1,
				S = "helmets/ph_adventurers_headgear"
			});
            _list.push({
				R = 80,
				P = 1.1,
				S = "armor/ph_adventurers_carapace"
			});
        }
        else if(this.m.ID == "building.marketplace")
        {
            _list.push({
				R = 75,
				P = 0.9,
				S = "weapons/ph_scalpel"
			});
            _list.push({
				R = 90,
				P = 0.9,
				S = "weapons/ph_scalpel_grip"
			});
        }		

        __original(_list, _stash, _priceMult, _allowDamagedEquipment = false);
    }
});