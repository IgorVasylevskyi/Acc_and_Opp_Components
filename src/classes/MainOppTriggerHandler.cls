public with sharing class MainOppTriggerHandler extends TriggerHandler{
    public Map<Id, Account> getAccMap(){
        
        List<Id> accsIds = new List<Id>();
        for (Opportunity opp : (List<Opportunity>) Trigger.new){
            accsIds.add(opp.AccountId);
        }
        Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, Name, Main_Opps__c
        FROM Account WHERE Id IN :accsIds]);
        return accMap;
    }
    
    public override void beforeInsert(){
    
        Map<Id, Account> accMap = getAccMap();
    
        for (Opportunity opp : (List<Opportunity>) Trigger.new) {
            Account parentAcc = accMap.get(opp.AccountId);
            if (opp.isMain__c && parentAcc.Main_Opps__c == 1) {
                opp.addError('Parent Account already has Main Opportunity');
            }
        }
    }
    
    public override void beforeUpdate(){
        Map<Id, Account> accMap = getAccMap();
    
        for (Opportunity opp : (List<Opportunity>) Trigger.new) {
            Account parentAcc = accMap.get(opp.AccountId);
            Opportunity oldOpp = (Opportunity) Trigger.oldMap.get(opp.Id);
            if ((opp.isMain__c == true)
                    && (oldOpp.isMain__c != true)
                    && (parentAcc.Main_Opps__c == 1)) {
            
                opp.addError('Parent Account already has main Opportunity');
            }
        }
    }
}