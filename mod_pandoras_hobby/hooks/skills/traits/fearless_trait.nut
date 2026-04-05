::PandorasHobby.MH.hook("scripts/skills/traits/fearless_trait", function(q) {

	q.create = @(__original) function(){
		__original();
		this.m.Excluded.push("trait.ph_fear_nobles");
	}
});