this.ph_artificer_helmet_dropoff_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
    },
	function create()
	{
		this.m.ID = "event.ph_artificer_helmet_dropoff";
		this.m.Title = "While in town...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/ph_event_workshop2.png[/img]{While passing through %townname%, you notice a tidy shop whose sign is emblazoned with \'Gilder\'s Finest\', so much for modesty. The proprietor is, for a crasftman, rather clean and immaculately dressed. The shelves are crammed full of acids, oils, tinctures, and bits of old armor. You approach the man to inquire what services he sells, but he speaks before you can open your mouth, %SPEECH_ON%Greetings, sellsword. I am Arlo the finest artificer you'll find, well, anywhere. If you have some ancient samples to work with and the gold to purchase my services I will craft you the finest helmet you've ever seen.%SPEECH_OFF% Definitely no modesty in this one, but if he\'s as good as his shop would indicate, then it will be a fine helmet indeed. But can you spare the loot and 4000 crowns he asking for?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Deal. Show us what you do, Arlo.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "No, I think we'll pass.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/ph_event_workshop2.png[/img]{%SPEECH_ON%Excellent. Have your men haul everything into the shop. Leave your payment and then return in nine days time to claim your helmet.%SPEECH_OFF% You count out the large sack of crowns while the men haul sacks of rusty old helmets into the shop. With a curt nod and a slight bow you and your men are dismissed from the shop so the artificer can begin his work. Whatever he makes has to better than what you\'ve given him, right?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "In nine days, then.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-4000);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spent [color=" + this.Const.UI.Color.NegativeEventValue + "]4000[/color] Crown"
					}
				];

				local stash = this.World.Assets.getStash().getItems();				
				local numArmor1 = 0;
				local numArmor2 = 0;
				local numArmor3 = 0;
				
				foreach( i, item in stash )
				{
					if(item == null) continue;

					if( item.getID() == "armor.head.ancient_household_helmet" )
					{
						stash[i] = null;
						numArmor1 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( item.getID() == "armor.head.ancient_legionary_helmet" )
					{
						stash[i] = null;
						numArmor2 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( item.getID() == "armor.head.ancient_honorguard_helmet" )
					{
						stash[i] = null;
						numArmor3 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
				}

				local numSets = ::Math.min(numArmor1, ::Math.min(numArmor2, numArmor3));
				local score = 3 + numArmor1 + numArmor2 + numArmor3*2 + numSets * 10;

				//set the waiting flags
				::World.Flags.set("ph_artificer_helmet_waiting", true);
				::World.Flags.set("ph_artificer_helmet_dropoff_day", this.World.getTime().Days);
				::World.Flags.set("ph_artificer_helmet_score", score);				
			}

		});
	}

	function onUpdateScore()
	{
        if (!this.Const.DLC.Desert)
		{
			return;
		}

        if (this.World.getTime().Days <= 60)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 8000)
		{
			return;
		}

		//cannot do armor & helm at the same time!  Actually its fine.
		//if( ::World.Flags.get("ph_artificer_armor_waiting") ) return;

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

        local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.getTile().getDistanceTo(currentTile) <= 4 && t.isAlliedWithPlayer())
			{
				this.m.Town = t;
				break;
			}
		}

		if (this.m.Town == null)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();		        
        local numArmor1 = 0;
		local numArmor2 = 0;
		local numArmor3 = 0;

		foreach( item in stash )
		{
            if(item == null) continue;
            
            if( item.getID() == "armor.head.ancient_household_helmet" )
            {
                numArmor1 += 1;
            }
            else if( item.getID() == "armor.head.ancient_legionary_helmet" )
            {
                numArmor2 += 1;
            }
            else if( item.getID() == "armor.head.ancient_honorguard_helmet" )
            {
                numArmor3 += 1;
            }
		}

		//min 1 of each armor
		if(numArmor1 == 0 || numArmor2 == 0 || numArmor3 == 0)
		{
			return;
		}

		//Base = 3		
		//Armor 1 = 1 pts
		//Armor 2 = 1 pts
		//Armor 3 = 2 pts
		//Armor Sets (1,2,3) = 10 pts
		local numSets = ::Math.min(numArmor1, ::Math.min(numArmor2, numArmor3));
		local score = 3 + numArmor1 + numArmor2 + numArmor3*2 + numSets * 10;


		//need at least 25% chance!
		if(score < 25) return;

		//must set here, doesn't exist lateron
		::World.Flags.set("ph_artificer_helmet_city", this.m.Town.getNameOnly());

		::logDebug(" >> >> Helemt Event Score === " + score);		
		this.m.Score = score + 20;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{	
		this.m.Town = null;	
	}

});

