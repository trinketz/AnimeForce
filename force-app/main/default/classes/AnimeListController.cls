public with sharing class AnimeListController {
    public AnimeListController() {

    }

    @AuraEnabled
    public static List<List<Anime__c>> getAnimeList(){
        Id currentUser = AnimeController.getCurrentUser().Id;

        List<Anime_List__c> animeList = [SELECT Anime__c, Anime__r.Cover_Image__c 
                                        FROM Anime_List__c 
                                        WHERE Anime_List__c.User__c=:currentUser];
        List<List<Anime__c>> multiDimensionalImagesList = chunkifyList(animeList, 3);
        return multiDimensionalImagesList;
    }

    @AuraEnabled
    public static List<List<Anime__c>> chunkifyList(List<Anime_List__c> SingleDimensionalList, Integer cols){
        Integer counter = 0;
        List<List<Anime__c>> chunked = new List<List<Anime__c>>();

        while(counter < cols){
            chunked.add(new List<Anime__c>());
            counter += 1;
        }

        for(Integer index = 0; index < SingleDimensionalList.size(); index++){
            chunked[Math.mod(index, cols)].add(new Anime__c(Id=SingleDimensionalList[index].Anime__c, 
                                                        Cover_Image__c=SingleDimensionalList[index].Anime__r.Cover_Image__c));
        }

        return chunked;
    }

    @AuraEnabled
    public static List<List<Anime__c>> chunkifyAnime(List<Anime__c> SingleDimensionalList, Integer cols){
        Integer counter = 0;
        List<List<Anime__c>> chunked = new List<List<Anime__c>>();

        while(counter < cols){
            chunked.add(new List<Anime__c>());
            counter += 1;
        }

        for(Integer index = 0; index < SingleDimensionalList.size(); index++){
            chunked[Math.mod(index, cols)].add(SingleDimensionalList[index]);
        }

        return chunked;
    }

    @AuraEnabled
    public static List<List<Anime__c>> getFeaturedAnime(){
        // get featured anime
        List<Anime__c> featured = [SELECT Id, Anime__c.Cover_Image__c FROM Anime__c WHERE Is_Featured__c=true];

        List<List<Anime__c>> multiDimensionalImagesList = chunkifyAnime(featured, 3);
        return multiDimensionalImagesList;      
    }
}