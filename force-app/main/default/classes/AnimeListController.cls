public with sharing class AnimeListController {
    public AnimeListController() {

    }

    @AuraEnabled
    public static List<List<String>> getAnimeList(){
        Id currentUser = AnimeController.getCurrentUser().Id;

        List<Anime_List__c> animeList = [SELECT Anime__r.Cover_Image__c 
                                        FROM Anime_List__c 
                                        WHERE Anime_List__c.User__c=:currentUser];
        List<String> imageUrls = new List<String>();

        for(Anime_List__c a : animeList){
            imageUrls.add(a.Anime__r.Cover_Image__c);
        }

        List<List<String>> multiDimensionalImagesList = chunkifyList(imageUrls, 3);
        return multiDimensionalImagesList;
    }

    @AuraEnabled
    public static List<List<String>> chunkifyList(List<String> SingleDimensionalList, Integer cols){
        Integer counter = 0;
        List<List<String>> chunked = new List<List<String>>();

        while(counter < cols){
            chunked.add(new List<String>());
            counter += 1;
        }

        for(Integer index = 0; index < SingleDimensionalList.size(); index++){
            chunked[Math.mod(index, cols)].add(SingleDimensionalList[index]);
        }

        return chunked;
    }
}

