@IsTest
private class AccountControllerTest {
    @IsTest
    static void hasOneMainOppAndNum() {
        Opportunity opp = InsertOppTestData.addOppandAccWithNum();
        
        Test.startTest();
        Boolean withNum = AccountController.hasInvoiceNumber(opp.AccountId);
        Test.stopTest();
        
        System.assertEquals(true, withNum);
    }
    
    @IsTest
    static void hasOneMainOppWithoutNum(){
        Opportunity opp = InsertOppTestData.addOppAndAccWithoutNum();
        
        Test.startTest();
        Boolean withoutNum = AccountController.hasInvoiceNumber(opp.AccountId);
        Test.stopTest();
        
        System.assertEquals(false, withoutNum);
    }
    
    @IsTest
    static void notHaveMainOpp(){
        Opportunity opp = InsertOppTestData.notMainOpp();
        
        Test.startTest();
        try {
            Boolean result = AccountController.hasInvoiceNumber(opp.AccountId);
        }catch (AuraHandledException e){
            System.assert(e.getMessage().contains('Account doesn`t have one main opportunity'));
        }
        Test.stopTest();
        
    }
}