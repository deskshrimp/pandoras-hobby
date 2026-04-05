::PandorasHobby.MH.hook("scripts/skills/actives/throw_net", function(q) {

    //Add everything to handle the new toothed nets

	q.m.PH_IsToothed <- false;

    q.PH_setToothed <- function( _t )
    {
        this.m.PH_IsToothed = _t;
    }

	q.dropBrokenNet <- function(_user, _targetTile)
	{
		if ( ::Hooks.hasMod("mod_hardened") )
		{
			//check for the HD kingfisher perk (it can preserve nets!)
			local fisher = _user.getSkills().getSkillByID("perk.rf_kingfisher");
			if(fisher != null && fisher.m.Temp_NetItemScript != "")
			{
				return;
			}
		}
		
		local loot = ::new("scripts/items/misc/ph_broken_net");
		loot.setToothed(this.m.PH_IsToothed);
		loot.setReinforced(this.m.IsReinforced);
		loot.drop(_targetTile);		
	}

    q.onUse  = @(__original) function( _user, _targetTile )
    {
		local targetEntity = _targetTile.getEntity();

		if(targetEntity.getCurrentProperties().IsImmuneToRoot)
		{
			return false;
		}

		//drop a broken net
		this.dropBrokenNet(_user, _targetTile);

		if (this.m.PH_IsToothed)
        {
            //handle our new net code directly

            if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			targetEntity.getSkills().add(::new("scripts/skills/effects/net_effect"));
			local breakFree = ::new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

            breakFree.setDecal("net_destroyed_02");
			breakFree.setChanceBonus(-22); //harder to escape

			targetEntity.getSkills().add(breakFree);

			local effect = this.Tactical.spawnSpriteEffect("ph_bust_net_03", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.PH_onToothedNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,				
			});
        }
        else
        {
            __original( _user, _targetTile );
        }

		//vanilla code never returns a success value in onUse for throwNet? (only false on miss)
		return true;
    }


    q.PH_onToothedNetSpawn <- function(_data)
    {
        //do the reforge crash catch
        if (!_data.TargetEntity.isAlive() || !_data.TargetEntity.isPlacedOnMap())
		{
			return;
		}

        local rooted = _data.TargetEntity.getSprite("status_rooted");
		rooted.setBrush("ph_bust_net_03");
		rooted.Visible = true;
		local rooted_back = _data.TargetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush("ph_bust_net_back_03");
		rooted_back.Visible = true;
		_data.TargetEntity.setDirty(true);
    }
});
