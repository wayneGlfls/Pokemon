public class PokemonController {
        
    @AuraEnabled
    public static List<String> getPokeminNames(Integer direction){
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit=20';
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
        //system.debug(PokemonNameList);
        return PokemonNameList;      
    }
    
    @AuraEnabled
    public static PokemonWrapper getNextPokeminNames(Integer direction){
        PokemonWrapper buffer = new PokemonWrapper(); 
        Integer limits = 20;
        Integer DirectionToInt = integer.valueOf(direction);
        
        //remember to change count
        //Integer count = direction;
        system.debug('direction is '+direction);
        system.debug('step one is good');
        Integer offsets = limits+DirectionToInt;
        system.debug('step two is good');
        //String sInteger = String.valueOf(offsets);
        //system.debug('step three is good');
        system.debug(offsets);
        Integer total = offsets+limits;
        
        //need to add one condition when list size is between 150 and its own size
        if(total > 150){ 
        	limits = 10;
            offsets = 140;
        }                             
            // Create HTTP request to send.
            HttpRequest request = new HttpRequest();
            String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit='+limits+'&offset='+offsets;
            //String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit=20&offset=20';
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
        system.debug(offsets);
        
        buffer.PokemonList = PokemonNameList;
        buffer.offset = offsets;
        
        system.debug(buffer.PokemonList);
        system.debug(buffer.offset);
       
        //system.debug(PokemonNameList);
        //return PokemonNameList;      
        return buffer;
     
    
    }
    
    @AuraEnabled
    public static PokemonWrapper getprevPokeminNames(Integer direction){
        PokemonWrapper buffer = new PokemonWrapper(); 
        Integer limits = 20;
        Integer DirectionToInt = integer.valueOf(direction);
        
        //remember to change count
        //Integer count = direction;
        system.debug('direction is '+direction);
        system.debug('step one is good');
        Integer offsets = DirectionToInt-limits;
        system.debug('step two is good');
        //String sInteger = String.valueOf(offsets);
        //system.debug('step three is good');
        system.debug(offsets);
        Integer total = offsets+limits;
        
        
        if(offsets <= 0 ){ 
        	limits = 20;
            offsets = 0;
        }                             
            // Create HTTP request to send.
            HttpRequest request = new HttpRequest();
            String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit='+limits+'&offset='+offsets;
            //String endpoint = 'http://pokeapi.co/api/v2/pokemon/?limit=20&offset=20';
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
        system.debug(offsets);
        
        buffer.PokemonList = PokemonNameList;
        buffer.offset = offsets;
        
        system.debug(buffer.PokemonList);
        system.debug(buffer.offset);
       
        //system.debug(PokemonNameList);
        //return PokemonNameList;      
        return buffer;    
    }
    

     
   public class PokemonWrapper{
        @AuraEnabled
        public List<String> PokemonList;
        @AuraEnabled 
        public Integer offset;
    }
        	
}