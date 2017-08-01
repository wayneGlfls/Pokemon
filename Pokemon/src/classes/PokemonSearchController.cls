public class PokemonSearchController {
    
 	@AuraEnabled   
    public static Map<Integer,String> getSearchResult(String searchQuery){
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit=151';
        request.setEndPoint(endpoint);
        request.setMethod('GET');

        // Send the HTTP request and get the response.
        // The response is in JSON format.
  		Http httpProtocol = new Http();
        HttpResponse response = httpProtocol.send(request);

        // Parse JSON response to get all the totalPrice field values.
        JSONParser parser = JSON.createParser(response.getBody());
        List<String> PokemonNameList = new List<String> ();
        
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'name')) {
                // Get the value.
                parser.nextToken();
                PokemonNameList.add(parser.getText());
            }
        }
		

     	Map<Integer, String> FiltedPokemonNameMap = new Map<Integer, String> ();
        List<Map<Integer,String>> ParentListPokeMonMap = new List<Map<Integer,String>>();
        String S1 = String.valueOf(searchQuery);
		String temp = S1.toLowerCase();
        
        if(temp != NULL){
            for(integer i = 0; i < PokemonNameList.size();i++){
                if(PokemonNameList[i].contains(temp)==true){
                    FiltedPokemonNameMap.put(i+1,PokemonNameList[i]);  
                }
            }
    	}
       
		return FiltedPokemonNameMap;         
    }
        
    @AuraEnabled
    public static List<Map<Integer,String>> getSearchResultV2(String searchQuery){
        system.debug('searchQuery is ' + searchQuery);
    //public static Map<Integer,String> getSearchResult(String searchQuery){
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit=151';
        request.setEndPoint(endpoint);
        request.setMethod('GET');

        // Send the HTTP request and get the response.
        // The response is in JSON format.
  		Http httpProtocol = new Http();
        HttpResponse response = httpProtocol.send(request);

        // Parse JSON response to get all the totalPrice field values.
        JSONParser parser = JSON.createParser(response.getBody());
        List<String> PokemonNameList = new List<String> ();
        
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'name')) {
                // Get the value.
                parser.nextToken();
                PokemonNameList.add(parser.getText());
            }
        }
		

     	Map<Integer, String> FiltedPokemonNameMap = new Map<Integer, String> ();
        List<Map<Integer,String>> ParentListPokeMonMap = new List<Map<Integer,String>>();
        String S1 = String.valueOf(searchQuery);
		String temp = S1.toLowerCase();
        
        if(temp != NULL){
            for(integer i = 0; i < PokemonNameList.size();i++){
                if(PokemonNameList[i].contains(temp)==true){
                    FiltedPokemonNameMap.put(i+1,PokemonNameList[i]);  
                }
            }
    	}
       	system.debug('all good here');
		ParentListPokeMonMap = DividePokemonMap(FiltedPokemonNameMap); 
		return ParentListPokeMonMap;         
    }
    
    public static List<Map<Integer,String>> DividePokemonMap(Map<Integer,String> searchResultMap) {

        Integer pageNumber = 0;
        Map<Integer,String> childMap = new Map<Integer,String>();
        List<Map<Integer,String>> ParentList = new List<Map<Integer,String>>();
        
        List<Integer> keySets = new List<Integer> ();
        KeySets.addAll(searchResultMap.keySet());
        //searchResultMap.keySet();
        
        
        List<Integer> keySetsInt = new List<Integer>();       
        //convert list of keysets from string to integer
        for(integer index = 0; index < keySets.size(); index++){
            KeySetsInt.add(Integer.valueOf(KeySets.get(index)));            
        }
        
        for(integer index = 0; index < searchResultMap.size(); index++){
            integer size = index+1;
            if(math.mod(size,20) == 0 || size == searchResultMap.size() ){               
                //go to this function
                ParentList.add(getSubMap(size,keySetsInt,searchResultMap));               
            }
            
        }
        
        system.debug(ParentList);
        Return ParentList;
    }
    
    Public static Map<Integer,String> getSubMap(integer size, List<Integer> keys, Map<Integer,String> WholeResultMap){
        Map<Integer, String> ConcatMap = new Map<Integer, String>();
        Integer remainder = math.mod(WholeResultMap.size(), 20);
        
        if(math.mod(size, 20)==0){
            //do sth
            for(integer x = size-20;x < size; x++){
                ConcatMap.put(Keys.get(x), WholeResultMap.get(Keys.get(x)));
            }
        }else{
            //do sth else, for the loose end of the map
            //work out the remainder first
            for(Integer y = size-remainder; y<size;y++){
                ConcatMap.put(Keys.get(y), WholeResultMap.get(Keys.get(y)));               
            }
        }
       
        return ConcatMap;
    }
    
    

}