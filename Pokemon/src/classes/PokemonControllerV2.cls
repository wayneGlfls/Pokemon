public class PokemonControllerV2 {
	@AuraEnabled
    public static Map<Integer, List<String>> getPokeminNames(Integer direction){
    //public static List<String> getPokeminNames(Integer direction){
        // Create HTTP request to send. Add some extra comments here
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

        integer i=0;
        integer Key=0;       
        List<String> PokemonNameList = new List<String> ();
        Map<Integer, List<String>> PokemonMap = new map<Integer, List<String>>();
        List<List<String>> PokemonSubNameList = new List<List<String>>();
        List<String> NewSubConcatNameList =  new List<String> ();

        
        while (parser.nextToken() != null) {

            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'name')) {
                // Get the value.
                parser.nextToken();               
                PokemonNameList.add(parser.getText());
                i++;
                    
                    if(math.mod(i, 20)==0 || i == 151){
                   
                        NewSubConcatNameList = getSubList(i, PokemonNameList);                                       
                        PokemonSubNameList.add(NewSubConcatNameList);
                        //below two codes both works
                        //PokemonMap.put(Key, NewSubConcatNameList);
                        PokemonMap.put(Key, PokemonSubNameList.get(key));
                        key++;
                }
            }
        }
        
        return PokemonMap;
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
           
        return buffer;
     
    
    }
    
    @AuraEnabled
    public static PokemonWrapper getprevPokeminNames(Integer direction){
        PokemonWrapper buffer = new PokemonWrapper(); 
        Integer limits = 20;
        Integer DirectionToInt = integer.valueOf(direction);
        
        //remember to change count
        //Integer count = direction;
        Integer offsets = DirectionToInt-limits;
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
    
  
    public Static List<String> getSubList(Integer Index, List<String> nameList){
        //List<String> FullNameList = nameList.clone();
        List<String> SubNameList = new List<String>();
        
       try{  
        if(Index > 20 && Index < 150){
        	for(Integer j=Index-20;j < Index;j++){
            	SubNameList.add(nameList.get(j));
        	}
           // system.debug('good here 2');
        }else if(Index==20){
            
            for(Integer x=0;x<20;x++){
            	//system.debug(nameList);
            	SubNameList.add(nameList.get(x));
            }
        }else if(index == 151){
            for(Integer j=index-11;j < index;j++){
            	SubNameList.add(nameList.get(j));
        	}
            	
        }

       
       }catch (System.NullPointerException e){          
            
       }
      //system.debug('SubNameList is '+ subNameList);
      return SubNameList;
    }
        
   public class PokemonWrapper{
        @AuraEnabled
        public List<String> PokemonList;
        @AuraEnabled 
        public Integer offset;
    }
      
}
