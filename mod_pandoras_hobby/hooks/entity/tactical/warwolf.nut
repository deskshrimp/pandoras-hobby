//just give the wolf a little armor (its squishier than the armored dogs!)
::Const.Tactical.Actor.WarWolf.Armor = [
	30,
	30
];

::PandorasHobby.MH.hook("scripts/entity/tactical/warwolf", function(q) {
	
	//add the missing method for setting the variant!
	q.setVariant  <- function( _v )
	{
		this.m.Items.getAppearance().Body = "bust_wolf_0" + _v;
		this.getSprite("body").setBrush("bust_wolf_0" + _v + "_body");
		this.getSprite("head").setBrush("bust_wolf_0" + _v + "_head");
		this.setDirty(true);
	}
});