({
    doInit: function(cmp){
        var action = cmp.get("c.getPokeminNames");
        action.setCallback(this, function(response){
            var state = response.getState();
            var screensize = screen.height;
            var IsPhone = $A.get("$Browser.isPhone");
            var IsTablet = $A.get("$Browser.isTablet");
            cmp.set("v.Isphone",IsPhone);
            cmp.set("v.IsTablet",IsTablet); 
            
            if(IsPhone == true){
                cmp.set("v.cssdefault","slds-size_4-of-4");                
            } else if(IsTablet == true){
                cmp.set("v.cssdefault","slds-size_2-of-4");                                  
            } else{
                cmp.set("v.cssdefault","slds-size_1-of-4");     
            }
            
            if (state === "SUCCESS") {
                //cmp.set("v.PokemonList", response.getReturnValue());
                cmp.set("v.PokemonMap", response.getReturnValue());
            }
            //here comes the new practice
            //
            var wholemap = cmp.get("v.PokemonMap");
            //var firstpagelist = cmp.get(wholemap.value[0]);
            cmp.set("v.CurrentNameList", wholemap[0]);
            /*
            var wholelist = cmp.get("v.PokemonList");
            var partlist = [];
            var i = 0;
            
            for(var key in wholelist){
                i++;
                if(i>=0 && i <=20){
                    partlist.push(wholelist[i]);
                }
            }
            
            cmp.set("v.CurrentNameList",partlist);*/
            
        });
     $A.enqueueAction(action);                
    },
    
    next: function(cmp){
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
    
     nextV2: function(cmp){
    	var wholelist = cmp.get("v.PokemonList");
        var partlist = [];
        var offset = cmp.get("v.offset");
        var Uplimit = 20+offset;
        var i =0;
         
        for (var key in wholelist ) {
            i++;
            if(i>offset && i<=Uplimit){
                partlist.push(wholelist[i]);
            }
            cmp.set("v.offset",Uplimit);
            cmp.set("v.CurrentNameList",partlist);

         }
                
     	$A.enqueueAction(action);    
	},
    
    nextV3: function(cmp){
           var wholemap = cmp.get("v.PokemonMap");
           var index = cmp.get("v.PageNumber");
        
           var offsetStore = cmp.get("v.offset");
           offsetStore += 20;
           index += 1;
        
            if(index > 7){
                index = 7;
            }
            if(offsetStore > 140){
                offsetStore = 140;
            }
        
           cmp.set("v.CurrentNameList", wholemap[index]);
           cmp.set("v.PageNumber",index);
           cmp.set("v.offset",offsetStore);
                      
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
    
    prevV2: function(cmp){
    	   var index = cmp.get("v.PageNumber");
           var offsetStore = cmp.get("v.offset");
           var wholemap = cmp.get("v.PokemonMap");
           index -= 1;
           offsetStore -= 20;
           if(index <= 0){
            	index = 0 ;
        	}

           if(offsetStore < 0){
                offsetStore =0;
           }
                
           cmp.set("v.CurrentNameList", wholemap[index]);
           cmp.set("v.PageNumber",index);
           cmp.set("v.offset",offsetStore);    
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
    
    //navigate to component is still beta stage, not recommended
    EnterSearchv2: function(cmp,event,helper) {
        var searchString = cmp.find("lookupSearchTwo").get("v.value");
         
        if(event.getParams().keyCode == 13){
            	var urlEvent = $A.get("e.force:navigateToComponent");
            	urlEvent.setParams({
                    componentDef : "c:PokemanSearchResult",
					componentAttributes: {
                		SeachString : cmp.find("lookupSearchTwo").get("v.value")
            		}

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
    
    ClickSearchV2: function(cmp,event,helper) {
            var searchString = cmp.find("lookupSearchTwo").get("v.value");
            var urlEvent = $A.get("e.force:navigateToComponent");
           	urlEvent.setParams({
                componentDef : "c:PokemanSearchResult",
				componentAttributes: {
                SeachString : searchString
            	},
                isredirect : "true"
            });            
            urlEvent.fire();              
    },
    
    
    change4: function(cmp,event,helper){
        var currentcss = "slds-size_1-of-4";
        cmp.set("v.cssdefault",currentcss);
    },
    
    change2: function(cmp,event,helper){
        var currentcss = "slds-size_2-of-4";
        cmp.set("v.cssdefault",currentcss);
    },
    
    change1: function(cmp,event,helper){
        var currentcss = "slds-size_4-of-4";
        cmp.set("v.cssdefault",currentcss);
    },
    
    hideSpinner : function (component, event, helper) {
        var spinner = component.find('mySpinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : false });
        evt.fire();   
    },
    
    
})