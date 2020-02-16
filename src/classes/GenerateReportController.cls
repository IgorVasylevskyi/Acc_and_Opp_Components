public with sharing class GenerateReportController {
    
    @AuraEnabled
    public static List<String> getTypes(String accId){
        
        Set<String> setTypes = new Set<String>();
        
        Account acc = [SELECT Id, Name, (SELECT Name, AccountId, Type FROM Opportunities)
                        FROM Account WHERE Id = :accId LIMIT 1];
        
        for(Opportunity opp : acc.Opportunities){
            if(opp.Type != null) {
                setTypes.add(opp.Type);///!!!!!!!!!!!!!!11
            }
        }
        
        List<String> raw = new List<String>(setTypes);
        System.debug('raw: ' + raw);
        List<String> types = new List<String>();
        
        if(raw.size() > 1){//---------
            for(String s : raw){
                types.add(s);
            }
            
            for(Integer i = 0; i < raw.size() - 1; i++){
                for(Integer j = i + 1; j < raw.size(); j++){
                    String s = raw.get(i) + raw.get(j);
                    types.add(s);
                }
            }
            types.sort();
            types.add('Old Type');
            System.debug('types: ' + types);
            return types;
            
        }else{
            raw.add('Old Type');
            System.debug('raw from else: ' + raw);
            return raw;
        }
    }
}