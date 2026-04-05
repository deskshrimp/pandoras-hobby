this.ph_artificer_armor_dropoff_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
    },
	function create()
	{
		this.m.ID = "event.ph_artificer_armor_dropoff";
		this.m.Title = "While in town...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/ph_event_workshop.png[/img]{As the company navigates the sun-bleached alleys of %townname%, an ill-kept old man emerges from a cluttered shop and approaches your cart. His grease-stained clothing and burn-scarred hands mark him as some sort of metalworker or craftsman of sorts. The men are cautious and you see them tensing to push the troublemaker away. You speak up to delay any unecessary violence, %SPEECH_ON%Hail friend. What in our cart has taken your interest? We may be willing to sell it.%SPEECH_OFF% Following your lead the men relax, and you even hear a few chuckles. The tinker's eyes never leaver the cart as he replies, %SPEECH_ON%I'll take all the ancient mail & plates, some acids to scour it, a couple thousand crowns, and a week to work.%SPEECH_OFF% This may be a case of mistaken identity (or just a damned eccentric who forgot how to speak), but his offer may be worth the risk. Ancient armor is mostly rusted trash anyways.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Lads, haul it all into the shop.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "I'll pass.",
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
			Text = "[img]gfx/ui/events/ph_event_workshop.png[/img]{The men glance at each other in confusion for a moment, but surprisingly they don't waste any time arguing and get to work. It doesn't take them long to be haul everything into the small shop. You pull out a sack of crowns to hand the tinker and extend a hand to shake on the deal. As he turns towards the sound of your approach you see his eyes have been bleached white from acid burns. Regardless his grip is firm as he confidently reaffirms %SPEECH_ON%One week.%SPEECH_OFF%. He mumbles something about the Gilder as he returns to his shop, but your thoughts are too loud to hear it.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "One week.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-2000);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spent [color=" + this.Const.UI.Color.NegativeEventValue + "]2000[/color] Crown"
					}
				];

				local stash = this.World.Assets.getStash().getItems();
				local numAcids = 0;
				local numArmor1 = 0;
				local numArmor2 = 0;
				local numArmor3 = 0;
				local numArmor4 = 0;
				
				foreach( i, item in stash )
				{
					if(item == null) continue;

					if( numAcids < 6 && (item.getID() == "weapon.acid_flask" || item.getID() == "misc.lindwurm_blood") )
					{
						stash[i] = null;
						numAcids += 3;

						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( numAcids < 6 && item.getID() == "misc.acidic_saliva" )
					{
						stash[i] = null;
						numAcids += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( item.getID() == "armor.body.ancient_scale_harness" )
					{
						stash[i] = null;
						numArmor1 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( item.getID() == "armor.body.ancient_double_layer_mail" )
					{
						stash[i] = null;
						numArmor2 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( item.getID() == "armor.body.ancient_plated_mail_hauberk" )
					{
						stash[i] = null;
						numArmor3 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
					else if( item.getID() == "armor.body.ancient_breastplate" || item.getID() == "armor.body.ancient_scale_coat" || item.getID() == "armor.body.ancient_plated_scale_hauberk" || item.getID() == "armor.body.ancient_mail" || item.getID() == "armor.body.ancient_plate_harness" )
					{
						stash[i] = null;
						numArmor4 += 1;
						
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
				}

				local numSets = ::Math.min(numArmor1, ::Math.min(numArmor2, numArmor3));
				local score = 3 + ::Math.min(6, numAcids) + numArmor1*2 + numArmor2*2 + numArmor3 + numArmor4 + numSets * 10;

				//set the waiting flags
				::World.Flags.set("ph_artificer_armor_waiting", true);
				::World.Flags.set("ph_artificer_armor_dropoff_day", ::World.getTime().Days);
				::World.Flags.set("ph_artificer_armor_score", score);
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

		if (this.World.Assets.getMoney() < 5000)
		{
			return;
		}

		//cannot do armor & helm at the same time! Actually its fine.
		//if( ::World.Flags.get("ph_artificer_helmet_waiting") ) return;

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
        local numAcids = 0;
		local numArmor1 = 0;
		local numArmor2 = 0;
		local numArmor3 = 0;
		local numArmor4 = 0;

		foreach( item in stash )
		{
            if(item == null) continue;

            if( item.getID() == "misc.acidic_saliva" )
            {
                numAcids+=1;
            }
            else if( item.getID() == "weapon.acid_flask" || item.getID() == "misc.lindwurm_blood" )
            {
                numAcids+=3;
            }
            else if( item.getID() == "armor.body.ancient_scale_harness" )
            {
                numArmor1+=1;
            }
            else if( item.getID() == "armor.body.ancient_double_layer_mail" )
            {
                numArmor2+=1;
            }
            else if( item.getID() == "armor.body.ancient_plated_mail_hauberk" )
            {
                numArmor3+=1;
            }
            else if( item.getID() == "armor.body.ancient_breastplate" || item.getID() == "armor.body.ancient_scale_coat" || item.getID() == "armor.body.ancient_plated_scale_hauberk" || item.getID() == "armor.body.ancient_mail" || item.getID() == "armor.body.ancient_plate_harness")
            {
                numArmor4+=1;
            }
		}

		//min 3 acids
        if(numAcids < 3)
        {
            return;
        }

		//min 1 of each armor
		if(numArmor1 == 0 || numArmor2 == 0 || numArmor3 == 0)
		{
			return;
		}

		//Base = 3
		//Acids = 1pt, max 6
		//Armor 1 & 2 = 2pts
		//Armor 3 & 4 = 1 pts
		//Armor Sets (1,2,3) = 10 pts
		local numSets = ::Math.min(numArmor1, ::Math.min(numArmor2, numArmor3));
		local score = 3 + ::Math.min(6, numAcids) + numArmor1*2 + numArmor2*2 + numArmor3 + numArmor4 + numSets * 10;
				
		//need at least 25% chance!
		if(score < 25) return;

		//must set here, doesn't exist lateron
		::World.Flags.set("ph_artificer_armor_city", this.m.Town.getNameOnly());
		
		::logDebug(" >> >> Armor Event Score === " + score);
		this.m.Score = score + 15;
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

