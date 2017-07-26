({
    doInit: function(cmp){
        var action = cmp.get("c.getPokeminNames");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.PokemonList", response.getReturnValue());
            }
        });
     $A.enqueueAction(action);                
    },
    
    next: function(cmp){
        //var count = 1;
    	var action = cmp.get("c.getNextPokeminNames");
      	action.setParams({ "direction" : cmp.get("v.offset") });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set("v.PokemonList", result.PokemonList);
                cmp.set("v.offset",result.offset);
            }
        });
     $A.enqueueAction(action);    
	},
    
    
     prev: function(cmp){
        //var count = 1;
    	var action = cmp.get("c.getprevPokeminNames");
      	action.setParams({ "direction" : cmp.get("v.offset") });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set("v.PokemonList", result.PokemonList);
                cmp.set("v.offset",result.offset);
            }
        });
     $A.enqueueAction(action);    
	},
    
     EnterSearch: function(cmp,event,helper) {
        var searchString = cmp.find("lookupSearchTwo").get("v.value");
         
        if(event.getParams().keyCode == 13){
            	var urlEvent = $A.get("e.force:navigateToURL");
            	urlEvent.setParams({
                	"url": "/pokemonsearch?searchString="+searchString
            	});
            
            	urlEvent.fire();           
        }
    },
    
     ClickSearch: function(cmp,event, helper) {
            var searchString = cmp.find("lookupSearchTwo").get("v.value");
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/pokemonsearch?searchString="+searchString
            });
            urlEvent.fire();              
    },
    
    
})