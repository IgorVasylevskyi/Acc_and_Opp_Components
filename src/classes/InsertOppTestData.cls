@IsTest
public class InsertOppTestData {
    //@IsTest
    public static Opportunity addOppAndAccWithoutNum() {
    
        Date today = Date.today();
        
        Account acc = new Account(Name = 'Test acc');
        insert acc;
        
        Opportunity opp = new Opportunity(Name = 'Test opp', AccountId = acc.Id, CloseDate = today,
                StageName = 'New', isMain__c = true);
        insert opp;
        return opp;
    }
    
    public static Opportunity addOppandAccWithNum(){
        Date today = Date.today();
        String num = 'Test123';
        
        Account acc = new Account(Name = 'Test acc');
        insert acc;
    
        Opportunity opp = new Opportunity(Name = 'Test opp', AccountId = acc.Id, CloseDate = today,
                StageName = 'New', isMain__c = true, Invoicing_Item_Number__c = num);
        insert opp;
        return opp;
    }
    
    public static Opportunity notMainOpp(){
        Date today = Date.today();
        Account acc = new Account(Name = 'Test acc');
        insert acc;
    
        Opportunity opp = new Opportunity(Name = 'Test opp', AccountId = acc.Id, CloseDate = today,
                StageName = 'New', isMain__c = false);
        insert opp;
        return opp;
    }
}