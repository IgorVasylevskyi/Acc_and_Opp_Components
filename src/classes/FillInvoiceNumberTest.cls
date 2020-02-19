@IsTest
private class FillInvoiceNumberTest {
    @IsTest
    static void addNumber() {
        
        Opportunity opp = InsertOppTestData.addOppAndAccWithoutNum();
        String num = 'ABC123';
        
        Test.startTest();
        FillInvoiceNumberController.addInvoiceNumberOpp(opp.Id, num);
        Test.stopTest();
        
        Opportunity opp1 = [SELECT Name, Invoicing_Item_Number__c FROM Opportunity WHERE Name = 'Test opp' LIMIT 1];
        System.assertEquals(num, opp1.Invoicing_Item_Number__c);
    }
    
    @IsTest
    static void addNumberFromAcc(){
        Opportunity opp = InsertOppTestData.addOppAndAccWithoutNum();
        String num = '12345';
        
        Test.startTest();
        FillInvoiceNumberController.addInvoiceNumberAcc(opp.AccountId, num);
        Test.stopTest();
        
        Opportunity opp1 = [SELECT Name, Invoicing_Item_Number__c FROM Opportunity WHERE Name = 'Test opp' LIMIT 1];
        System.assertEquals(num, opp1.Invoicing_Item_Number__c);
    }
    
    @IsTest
    static void numberTooLong(){
        
        Opportunity opp = InsertOppTestData.addOpportunity();
        String num = '1234567890123456789';
        
        Test.startTest();
        try {
            FillInvoiceNumberController.addInvoiceNumberOpp(opp.Id, num);
        }catch (AuraHandledException e){
            System.assert(e.getMessage().contains('Invoice number is too long'));
        }
        Test.stopTest();
    }
}