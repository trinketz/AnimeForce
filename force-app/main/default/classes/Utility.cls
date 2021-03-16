public inherited sharing class Utility {

    // constructor
    public Utility() {
        
    }

    public static void populateDatabase(){

        List<String> anime = new List<String>();
        anime.add('Cowboy Bebop');
        anime.add('One Punch Man');
        anime.add('hunter x hunter');
        anime.add('my hero academia');
        anime.add('Attack on Titan');
        anime.add('Black Clover');
        anime.add('Fire Force');
        anime.add('One Piece');
        anime.add('Bleach');
        anime.add('Naruto');
        anime.add('Fullmetal Alchemist: Brotherhood');
        anime.add('mob psycho');
        anime.add('your lie in april');
        anime.add('code geass');

        List<Anime__c> digestedAnime = consumeAPI(anime);
        insert digestedAnime;
    }
    
    // note to self: think of better name
    // refactor this as well
    public static List<Anime__c> consumeAPI(List<String> animeToConsume){
        String endpoint = 'https://kitsu.io/api/edge/anime?filter[text]=';
        List<Anime__c> animeList = new List<Anime__c>();

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Accept', 'application/vnd.api+json');
        req.setHeader('Content-type', 'application/vnd.api+json');

        for(String a : animeToConsume){
            req.setEndpoint(endpoint + a);
            req.setMethod('GET');
            HttpResponse resp = http.send(req);

            if(resp.getStatusCode() == 200){
                System.debug(endpoint + a);
                Object deserializedResponse = JSON.deserializeUntyped(resp.getBody());
                Map<String, Object> respMap = (Map<String, Object>) deserializedResponse;

                // since our data starts with a list
                List<Object> data = (List<Object>) respMap.get('data');

                // grab the list of data, and take first result
                Map<String, Object> respData = (Map<String, Object>) data[0];
                // take the data, grab the object that contains an object
                //Map<String, Object> attributes = (Map<String, Object>) respData;

                // go into a key and grab the object that contains an object, and grab the attributes
                Map<String, Object> attributes = (Map<String, Object>) respData.get('attributes');
                Map<String, Object> coverImage = (Map<String, Object>) attributes.get('posterImage');

                String title = (String) attributes.get('canonicalTitle');
                String synopsis = (String) attributes.get('synopsis');
                String rated = (String) attributes.get('ageRating');
                String status = (String) attributes.get('status'); 
                String type = (String) attributes.get('subtype');
                Integer episodeCount = (Integer) attributes.get('episodeCount');
                Integer duration = (Integer) attributes.get('episodeLength');

                Date startDate = Date.valueOf(String.valueOf(attributes.get('startDate')));

                String posterImageUrl = (String) coverImage.get('medium');
            
                Account acc = new Account(Id='0015Y00002btneTQAQ');
                // create new anime
                animeList.add(new Anime__c(Name=title,
                            Account__c=acc.Id,
                            Synopsis__c=synopsis,
                            Rated__c=rated,
                            Cover_Image__c=posterImageUrl,
                            Total_Episodes__c=episodeCount,
                            Started_Date__c=startDate,
                            Duration__c=duration,
                            Type__c=type,
                            Status__c=status
                ));
            }
        }

        return animeList; 
    }
}
