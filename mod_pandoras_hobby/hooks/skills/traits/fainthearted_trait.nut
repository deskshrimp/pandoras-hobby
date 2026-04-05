::PandorasHobby.MH.hook("scripts/skills/traits/fainthearted_trait", function(q) {

	q.create = @(__original) function(){
		__original();
		this.m.Excluded.push("trait.ph_hate_nobles");
	}
});