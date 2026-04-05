this.ph_davkuls_favor_event <- this.inherit("scripts/events/event", {
	m = {		
		Sacrifice = null
	},
	function create()
	{
		this.m.ID = "event.ph_davkuls_favor";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]%sacrifice% enters your tent, a cold biting wind chasing after him. He stumbles into your table, scattering your scrolls and notes. Awkwardly bracing himself with a hand and elbow on the sturdy wood, he leans close enough for you to see his missing pupils and the drool on his face. He leans closer still and whispers %SPEECH_ON%Davkul... calls...me.%SPEECH_OFF% choking on each word. It's always a damn mess with these cultist types about, and its unfortunately your job to deal with it.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Well, go on an answer his call then.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Absolutely not!",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sacrifice.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]%sacrifice_short% shambles out of your tent with less grace than a wiederganger, his body joltting and flopping to the side with every step. You remain pensive as the sound of his clomping steps slowly fades.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Whatever, let possessed cultists lie--",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
        this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_36.png[/img]As you stoop to gather the items that %sacrifice% pushes off your table, a gut-wrenching scream sounds from just outside of camp. When you emerge from your tent you find everyone but %sacrifice_short% is outside as well. An dense unnatural fog has settled around the camp making it impossible to see anything beyound your small circle of tents. The men are startled and looking to you for orders. Orders you take a breath to give, but choke them down startled. Barely human howls of pain echo out of the fog. Directionless and unending, the sounds wash over the camp from every angle. The camp is in chaos, some pray, others curse. A few men return to their tents to stuff straw in their ears. A few others dash into the fog only to return to camp a moment later, a few feet from where they entered, confused and shivering violently.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What the farking hell...",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
        this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/ph_event_26.png[/img]You take a few moments to breathe, wrap wads of cloth around your ears, and school your features. It feels like hours have passed by the time you've gathered everyone around the fire, and stoked the coals into a small inferno. Now, properly wrapped in makeshift turbans of cloth and straw that'd make even an indebted smirk, %sacrifice%'s wailing can only just be heard over the popping of the fire... and the men have mostly stopped muttering about falling into hell.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It's going to be a long night.",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_46.png[/img]No one is quite sure when the screaming stopped. Or, the fog lifted. Or, even when the sun rose. The important thing was that it didn't take long to find a %sacrifice_short%. Well at least a dry old skeleton wearing his clothes. It doesn't make any sense. But neither does the strange red lump that was found nearby. The nasty little lump is slick and randomly spasms like its alive. The cultists fawn over it and coo like doting mothers.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "This ugly thing had better be worth it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sacrifice.getImagePath());
				local dead = _event.m.Sacrifice;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "Sacrificed to Davkul",
					Expendable = dead.getBackground().getID() == "background.slave"
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Sacrifice.getName() + " has died"
				});
				_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Sacrifice.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Sacrifice);
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/loot/ph_davkuls_favor");
				item.m.Variant = 111;
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});

                ::World.Flags.set("ph_DavkulsFavorReceived", true);

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						bro.improveMood(2.0, "Blessed by Davkul");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else
					{
						bro.worsenMood(3.0, "Horrified by the death of " + _event.m.Sacrifice.getName());

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}

                    //all are tired
                    if(!bro.getSkills().hasSkill("effects.exhausted"))
                    {
                        bro.getSkills().add(::new("scripts/skills/effects_world/exhausted_effect"));
                    }
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_18.png[/img]%SPEECH_ON%DAVKUL-%SPEECH_OFF% You slap %sacrifice_short% to silence him before he can call anymore cultists to your tent. To your great surprise, and a small boost to your ego, he lists to the side and collapses, wholly unconscious. He's not out for long. But, when he comes to, %sacrifice% is weak and far too green around the gills. You call a couple of men to carry him to his tent.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nothing he won't live through, hopefully.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sacrifice.getImagePath());

                if (_event.m.Sacrifice.getSkills().hasSkill("injury.sickness"))
		        {
			        _event.m.Sacrifice.getSkills().getSkillByID("injury.sickness").addHealingTime(this.Math.rand(1, 3));
		        }
		        else
		        {
			        _event.m.Sacrifice.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
		        }

                _event.m.Sacrifice.worsenMood(1.0, "ennui");
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 90)
		{
			return;
		}

		//we've already received it!
		if(::World.Flags.get("ph_DavkulsFavorReceived"))
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 8)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local sacrifice_candidates = [];
		local numCultists = 0;		

		foreach( bro in brothers )
		{
			if ( bro.PH_isCultist() )
			{
				if (bro.getLevel() >= 9 && !bro.getSkills().hasSkill("trait.player") && !bro.getFlags().get("IsPlayerCharacter") && !bro.getFlags().get("IsPlayerCharacter"))
			    {
                    if(bro.getSkills().hasSkill("trait.cultist_disciple") || bro.getSkills().hasSkill("trait.cultist_chosen"))
                    {
				        sacrifice_candidates.push(bro);
                    }
                }

                numCultists++;
			}
		}

		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.True_Cultist))
		{
			numCultists++;
		}

		if (sacrifice_candidates.len() == 0 || numCultists < 3)
		{
			return;
		}
		
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = numCultists * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{		
		_vars.push([
			"sacrifice",
			this.m.Sacrifice.getName()
		]);
		_vars.push([
			"sacrifice_short",
			this.m.Sacrifice.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Sacrifice = null;
	}

});

