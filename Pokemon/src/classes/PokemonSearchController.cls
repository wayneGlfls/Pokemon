public class PokemonSearchController {
        
    @AuraEnabled
    public static Map<Integer,String> getSearchResult(String searchQuery){
        // Create HTTP request to send.
        system.debug('searchQuery is '+searchQuery);
        HttpRequest request = new HttpRequest();
        String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit=151';
        request.setEndPoint(endpoint);
        request.setMethod('GET');


        // Send the HTTP request and get the response.
        // The response is in JSON format.
  		Http httpProtocol = new Http();
        HttpResponse response = httpProtocol.send(request);
        //System.debug(response.getBody());


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
		
        system.debug(PokemonNameList);

        Map<Integer, String> FiltedPokemonNameList = new Map<Integer, String> ();
        String temp = String.valueOf(searchQuery);

        
        if(temp != NULL){
            for(integer i = 0; i < PokemonNameList.size();i++){
                if(PokemonNameList[i].contains(temp)==true){
                    FiltedPokemonNameList.put(i+1,PokemonNameList[i]);  
                }
            }
    	}
        system.debug(FiltedPokemonNameList);
		return FiltedPokemonNameList;         
    }

}