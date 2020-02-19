public with sharing class FillInvoiceNumberController {
    
    @AuraEnabled
    public static void addInvoiceNumberOpp(String recordId, String invoiceNum){
        System.debug('recordId opp: ' + recordId);
        
        if(invoiceNum.length() <= 18) {
            Opportunity opp = [SELECT Id, Name, Invoicing_Item_Number__c FROM Opportunity WHERE Id = :recordId];
            opp.Invoicing_Item_Number__c = invoiceNum;
            update opp;
        }else {
            AuraHandledException e = new AuraHandledException('Invoice number is too long');
            e.setMessage('Invoice number is too long');
            throw e;
        }
        
    }
    
    @AuraEnabled
    public static void addInvoiceNumberAcc(String recordId, String invoiceNum){
        System.debug('recordId acc: ' + recordId);
        Account acc = [SELECT Id, Name,
        (SELECT Id, isMain__c, Invoicing_Item_Number__c
        FROM Opportunities WHERE isMain__c = TRUE)
        FROM Account WHERE Id = :recordId];
        
        if(acc.Opportunities.size() == 1){
            Opportunity opp = acc.Opportunities[0];
            opp.Invoicing_Item_Number__c = invoiceNum;
            update opp;
        }
    }
}