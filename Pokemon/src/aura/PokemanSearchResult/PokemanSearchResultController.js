({
	doInit : function(component, event, helper) {
        var articleURL = window.location.pathname;
        var urlSplit = articleURL.split('/');
        
        var queryString = location.search.substring(1); 
        var keyValues = queryString.split('&'); 
        var keyValue = keyValues[0].split('=');
        
        var action = component.get("c.getSearchResult");
        action.setParams({ searchQuery : keyValue[1] });
        
        action.setCallback(this, function(response){
            var state = response.getState();           
            if (state === "SUCCESS") {
                var custs = [];
                var conts = response.getReturnValue();
                for ( var key in conts ) {
                    custs.push({value:conts[key], key:key});
                }
                component.set("v.customers", custs);
            }
        });
        $A.enqueueAction(action);
		
	},
    
   goHome: function(cmp,event,helper) {       
            	var urlEvent = $A.get("e.force:navigateToURL");
            	urlEvent.setParams({
                	"url": "https://wayne123-developer-edition.ap5.force.com/s/"
            	});
            
            	urlEvent.fire();           
        
    },

    
    
})