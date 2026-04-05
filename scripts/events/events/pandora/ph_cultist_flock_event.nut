this.ph_cultist_flock_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_flock";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 300.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]%joiner%, a wandering devotee of Davkul, is in need of a flock. As the company approaches he gestures at the many spiraled scards about his skull. He obviously expects them to mean something to you and is clearly looking for a company to join, albeit one that's a bit odder than the company you generally like to keep. He stares at you imploringly, mumbling some rubbish about chasing shadows and death.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sure, whatever. He's not that much odder than the rest of them.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
                {
					Text = "I've got my hands full with the idiots we have already. No.",
					function getResult( _event )
					{						
						this.World.getTemporaryRoster().clear();						
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"cultist_background"
				]);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

        if (this.World.getTime().Days <= 20)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		//just scale until it happens
        this.m.Score = 5 + ::World.getTime().Days;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

