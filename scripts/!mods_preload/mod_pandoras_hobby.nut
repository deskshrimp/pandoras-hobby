::PandorasHobby <- {
	ID = "mod_pandoras_hobby",
	Name = "Pandora's Hobby",
	Version = "1.2.0"	
	GitHubURL = "https://github.com/deskshrimp/pandoras-hobby",
	NexusURL = "https://www.nexusmods.com/battlebrothers/mods/992",
}

::PandorasHobby.MH <- ::Hooks.register(::PandorasHobby.ID, ::PandorasHobby.Version, ::PandorasHobby.Name);
::PandorasHobby.MH.require("mod_reforged");
::PandorasHobby.MH.conflictWith("mod_legends", "mod_more_followers", "mod_retinue_ups");

::PandorasHobby.MH.queue([">mod_reforged", ">mod_hardened", ">mod_stronghold", ">mod_crock_pot"], function(){
	::PandorasHobby.Mod <- ::MSU.Class.Mod(::PandorasHobby.ID, ::PandorasHobby.Version, ::PandorasHobby.Name);
	
	::PandorasHobby.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::PandorasHobby.GitHubURL);
	::PandorasHobby.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	::PandorasHobby.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, ::PandorasHobby.NexusURL);
	
	::Hooks.registerJS("ui/mods/pandoras_hobby/ph_world_campfire_modules.js");
	::Hooks.registerCSS("ui/mods/pandoras_hobby/ph_world_campfire_modules.css");
	
	foreach (file in ::IO.enumerateFiles("mod_pandoras_hobby/config")){
		::include(file);
	}

	foreach (file in ::IO.enumerateFiles("mod_pandoras_hobby/config_late")){
		::include(file);
	}

	foreach (file in ::IO.enumerateFiles("mod_pandoras_hobby/hooks")){
		::include(file);
	}

	foreach (file in ::IO.enumerateFiles("mod_pandoras_hobby/late_hooks")){
		::include(file);
	}

	//the scripts folder will be included automatically
});


/*
::logInfo() blue
::logDebug() yellow
::logWarning() orange
::logError() red
*/