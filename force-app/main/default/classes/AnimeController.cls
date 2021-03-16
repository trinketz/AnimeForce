public with sharing class AnimeController {
    @AuraEnabled
    public static User getCurrentUser(){
        return [SELECT Id, Name FROM User WHERE Id=:UserInfo.getUserId()];
    }

    @AuraEnabled
    public static String addAnime(Id animeId){
        
        Id userId = getCurrentUser().Id;
        Anime_List__c animeList = new Anime_List__c(Anime__c=animeId, User__c=userId);

        insert animeList; 
        return (String)animeId;
    }

    @AuraEnabled
    public static Boolean hasAnime(Id animeId){
        Id userId = getCurrentUser().Id;
        List<Anime_List__c> isMatch = [SELECT Anime__c FROM Anime_List__c 
                                       WHERE Anime_List__c.User__c =:userId 
                                       AND Anime__c =:animeId];
        if(isMatch.size() > 0)
            return true;
        return false;
    }
    public void getAnimeList(){
        // Anime_List__c userAnimeList =  [SELECT Anime__c FROM Anime_List__c 
        // WHERE Anime_List__c.User__c =:userId];
        // Anime__c show = new Anime__c(Id=animeId);
        // current contact(anime.Id=Anime__c.id)?
        
        // Anime_List__c userAnimeList =  [SELECT Anime__c FROM Anime_List__c 
        //                                 WHERE Anime_List__c.User__c =:userId];

                                  
    }
}

