//character.nut
//force all the slots to be unlocked!
::Const.FollowerSlotRequirements <- [
    0,
	0,
	0,
	0,
	0,
	0
];

//world_assets.nut
//add new upgrade tiers
::Const.World.InventoryUpgradeCosts <- [
    2000, //DK+
	5000,
    5000, //cart+
	10000,
    10000, //Wagon+
	15000,
    15000, //Big Wagon+
	30000, //Ultimate Wagon!
];

//strings.nut
//add new upgrade tiers
::Const.Strings.InventoryUpgradeCosts <- [
	"2,000",
	"5,000",
	"5,000",
	"10,000",
	"10,000",
	"15,000",
	"15,000",
	"30,000",
];
::Const.Strings.InventoryHeader <- [
	"Donkey",
    "Enhanced Donkey",
	"Cart",
    "Improved Cart",
	"Wagon",
    "Improved Wagon",
	"Big Wagon",
    "Big Wagon o' Swag"
	"Ultimate Wagon"
];
::Const.Strings.InventoryUpgradeHeader <- [
	"Enhance your Donkey",
	"Buy a Cart",
	"Improve your Cart",
	"Buy a Wagon",
	"Improve your Wagon",
	"Buy a Big Wagon",
	"Swag your Big Wagon"
	"Create the Ultimate Wagon"
];
::Const.Strings.InventoryUpgradeText <- [
	"enhance your donkey",
	"buy a cart",
	"improve your cart",
	"buy a wagon",
	"improve your wagon",
	"buy a big wagon",
	"swag your big wagon"
	"create the ultimate wagon"
];