@IsTest
private class MainOppTriggerHandlerTest {
    @IsTest
    static void insertOppSuccessfully() {
        Account acc = InsertOppTestData.addAccount();
        
        Opportunity opp = new Opportunity(Name = 'test', CloseDate = Date.today(),
                                            AccountId = acc.Id, StageName = 'New', isMain__c = true);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(opp);
        Test.stopTest();
        
        System.assert(result.isSuccess());
    }
    
    @IsTest
    static void updateOppSuccessfully(){
        Opportunity opp = InsertOppTestData.notMainOpp();
        
        Test.startTest();
        opp.isMain__c = true;
        Database.SaveResult result = Database.update(opp);
        Test.stopTest();
        System.assert(result.isSuccess());
    }
    
    @IsTest
    static void insertOppNotSuccessfully(){
        Opportunity opp = InsertOppTestData.addOppAndAccWithoutNum();
        Opportunity opp1 = new Opportunity(Name = 'Test opp', AccountId = opp.AccountId, CloseDate = Date.today(),
                StageName = 'New', isMain__c = true);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(opp1, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
    }
    
    @IsTest
    static void updateOppNotSuccessfully(){
        Opportunity opp = InsertOppTestData.addOppAndAccWithoutNum();
        Opportunity opp1 = new Opportunity(Name = 'Test opp', AccountId = opp.AccountId, CloseDate = Date.today(),
                StageName = 'New', isMain__c = false);
        insert opp1;
    
        Test.startTest();
        opp1.isMain__c = true;
        Database.SaveResult result = Database.update(opp1, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
    }
}