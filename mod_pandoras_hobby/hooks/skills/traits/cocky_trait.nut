::PandorasHobby.MH.hook("scripts/skills/traits/cocky_trait", function(q) {

	q.create = @(__original) function(){
		__original();
		this.m.Excluded.push("trait.ph_fear_nobles");
	}
});