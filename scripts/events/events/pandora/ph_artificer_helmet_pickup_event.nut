this.ph_artificer_helmet_pickup_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ph_artificer_helmet_pickup";
		this.m.Title = "While in town...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/ph_event_workshop2.png[/img]{You slowly navigate the narrow alleys that lead to the tinker's small shop. The men haven't said it to your face, but you know the've been taking bets on how badly you were swindled. As you near the small shop you see the old tinker, looking even more dishevelled if that's possible, tilt head in your direction before turning to rummage through a crate wedged under his workbench. By the time the company reaches the shop, the tinker has walked out to meet you. He hands you a fresh suit of mail and merely says %SPEECH_ON%It is done,%SPEECH_OFF% before returning to his shop. You call after him in thanks:}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The work of a master craftsman.",
					function getResult( _event )
					{
						return 0;
					}
				},
				{
					Text = "Great work, artificer.",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "The Gilder bless you and your shop.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local odds = ::World.Flags.getAsInt("ph_artificer_helmet_score");

				local roll = ::Math.rand(0,100);

				if(roll <= odds + 5)
				{
					local item = this.new("scripts/items/helmets/legendary/ph_artificer_helm");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
				else if(roll <= odds * 2 + 10)
				{
					local item = this.new("scripts/items/helmets/oriental/turban_helmet");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
				else
				{
					local item = this.new("scripts/items/helmets/oriental/heavy_lamellar_helmet");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}

				//remove all the flags
				::World.Flags.remove("ph_artificer_helmet_waiting");
				::World.Flags.remove("ph_artificer_helmet_dropoff_day");
				::World.Flags.remove("ph_artificer_helmet_score");
				::World.Flags.remove("ph_artificer_helmet_city");
			}

		});
	}

	function onUpdateScore()
	{
        if (!this.Const.DLC.Desert)
		{
			return;
		}

		//must be waiting on the helmet!
		if( ! ::World.Flags.get("ph_artificer_helmet_waiting") )
		{
			return;
		}

		//must have space!
		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		//was the drop off long enough ago?
        if (this.World.getTime().Days - ::World.Flags.getAsInt("ph_artificer_helmet_dropoff_day") < 9)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		//must return to the same town!
        local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();
		local town = null;
		foreach( t in towns )
		{
			if (t.isSouthern() && t.getTile().getDistanceTo(currentTile) <= 4 && t.isAlliedWithPlayer())
			{
				town = t;
				break;
			}
		}

		if (town == null)
		{
			return;
		}
		if( town.getNameOnly() != ::World.Flags.get("ph_artificer_helmet_city") )
		{
			return;
		}

		this.m.Score = 2000;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{		
	}

	function onClear()
	{			
	}

});

