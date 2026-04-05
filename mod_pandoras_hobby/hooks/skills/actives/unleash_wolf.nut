::PandorasHobby.MH.hook("scripts/skills/actives/unleash_wolf", function(q) {

	q.create = @(__original) function(){
		__original();
		this.m.Name = "Unleash Wolf";
		this.m.Description = "Unleash your wolf and send him charging into the enemy. Needs a free tile adjacent.";
	}
    
    q.onUse = @(__original) function( _user, _targetTile ) {
        local entity = this.Tactical.spawnEntity(this.m.Item.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setItem(this.m.Item);
		entity.setName(this.m.Item.getName());
        
        //the variant #'s are reversed on the sprites
        if(this.m.Item.getVariant() == 1) { entity.setVariant(2); }
        else { entity.setVariant(1); }
        
		this.m.Item.setEntity(entity);

		if (this.getContainer().hasSkill("background.houndmaster"))
		{
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		if (!this.World.getTime().IsDaytime)
		{
			entity.getSkills().add(this.new("scripts/skills/special/night_effect"));
		}

		this.m.IsHidden = true;
		return true;
    }
});