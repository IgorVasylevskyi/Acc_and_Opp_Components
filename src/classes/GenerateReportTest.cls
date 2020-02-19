@IsTest
private class GenerateReportTest {
    @IsTest
    static void getTypes() {
        Opportunity opp = InsertOppTestData.addOppandAccWithNum();
        Opportunity opp1 = InsertOppTestData.addOpportunity();
        opp.Type = 'A';
        update opp;
        opp1.Type = 'B';
        opp1.AccountId = opp.AccountId;
        update opp1;
        
        Test.startTest();
        List<String> types = GenerateReportController.getTypes(opp.AccountId);
        Test.stopTest();
        
        System.assertEquals(4, types.size());
    }
    @IsTest
    static void getBlankTypes(){
        Opportunity opp = InsertOppTestData.addOppandAccWithNum();
        Opportunity opp1 = InsertOppTestData.addOpportunity();
        opp1.AccountId = opp.AccountId;
        update opp1;
    
        Test.startTest();
        List<String> types = GenerateReportController.getTypes(opp.AccountId);
        System.debug('types from test: ' + types);
        Test.stopTest();
    
        System.assertEquals(2, types.size());
    }
}