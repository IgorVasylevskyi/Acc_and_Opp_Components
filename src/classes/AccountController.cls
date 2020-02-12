public with sharing class AccountController {

    @AuraEnabled
    public static Boolean hasInvoiceNumber(String accId){
        
        Account acc = [SELECT Id, Name, (SELECT isMain__c, Invoicing_Item_Number__c
                        FROM Opportunities WHERE isMain__c = true)
                        FROM Account WHERE Id = :accId];
    
        if(acc.Opportunities.size() == 1){
            
            Opportunity opp = acc.Opportunities[0];
            if(opp.Invoicing_Item_Number__c != null){
                return true;
                
            }else return false;
            
        }else if(acc.Opportunities.size() != 1){
            AuraHandledException e = new AuraHandledException('Account doesn`t have one main opportunity');
            e.setMessage('Account doesn`t have one main opportunity');
            throw e;
        }
        
        return false;
    }
}