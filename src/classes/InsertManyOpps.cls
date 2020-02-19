public with sharing class InsertManyOpps {
    
    public static Account insertAccount(){
        Account acc = new Account(Name = 'Many opps');
        insert acc;
        return acc;
    }
    
    public static void insertManyOpps(String accId, Integer quantity, String type){
        List<Opportunity> manyOpps = new List<Opportunity>();
        
        for (Integer i = 0; i < quantity; i++){
            Opportunity opp = new Opportunity(Name = 'Test ' + type + i, CloseDate = Date.today(),
                                            AccountId = accId, Type = type, StageName = 'New');
            manyOpps.add(opp);
        }
        insert manyOpps;
    }
}