public with sharing class GenerateReportController {
    
    @AuraEnabled
    public static List<String> getTypes(String accId){
        
        Integer CPU_BeforeSOQL = Limits.getCpuTime();
        System.debug(CPU_BeforeSOQL + ' milliseconds: CPU Time before SOQL query');
        
        Integer heapBeforeSOQL = Limits.getHeapSize();
        System.debug(heapBeforeSOQL + ' bytes: Heap size used before SOQL query');
        
        Account acc = [SELECT Id, Name, (SELECT Name, AccountId, Type FROM Opportunities)
                        FROM Account WHERE Id = :accId LIMIT 1];
        
        Integer CPU_AfterSOQL = Limits.getCpuTime();
        System.debug(CPU_AfterSOQL + ' milliseconds: CPU Time after SOQL query');
    
        Integer heapAfterSOQL = Limits.getHeapSize();
        System.debug(heapAfterSOQL + ' bytes: Heap size used after SOQL query');
        
        ///////Without recursion
        Set<String> raw = new Set<String>();
    
        for(Opportunity opp : acc.Opportunities){
            raw.add(opp.Type);
        }
        
        List<String> resList = new List<String>();
        Set<String> resSet = new Set<String>();
        
        for (String str : raw){
            Integer s = resSet.size();
            if(!resSet.contains(str)) {
                resSet.add(str);
                resList.add(str);
            }
            
            for(Integer j = 0; j < s; j++){
                String resString = str + resList.get(j);
                
                if(!resSet.contains(resString)){
                    resSet.add(resString);
                    resList.add(resString);
                }
            }
        }
        System.debug('----------------------------------');
        Integer CPU_AfterExecution = Limits.getCpuTime();
        System.debug(CPU_AfterExecution + ' milliseconds: CPU Time after processing (WITHOUT recursion)');
        System.debug((CPU_AfterSOQL - CPU_BeforeSOQL) + ' milliseconds: Total CPU Time of query');
        System.debug((CPU_AfterExecution - CPU_AfterSOQL) + ' milliseconds:' +
                ' Total CPU Time of processing WITHOUT recursion');
    
        System.debug('----------------------------------');
        Integer heapAfterExecution = Limits.getHeapSize();
        System.debug(heapAfterExecution + ' bytes: Heap size used after processing (WITHOUT recursion)');
        System.debug((heapAfterSOQL - heapBeforeSOQL) + ' bytes: Total Heap size used for SOQL');
        System.debug((heapAfterExecution - heapAfterSOQL) + ' bytes: Total Heap size used for processing ' +
                                                            ' (WITHOUT recursion)');
        //END Without recursion
        
        /*/////////With recursion
        Set<String> setTypes = new Set<String>();
        
        for(Opportunity opp : acc.Opportunities){
            if(opp.Type != null) {
                setTypes.add(opp.Type);
            }
        }
        
        String str = '';
        for(String s : setTypes){
            str = str + s;
        }
        List<String> types = getItems(str);
        List<String> resList = new List<String>();
        for (String s : types){
            if(s != ''){
                resList.add(s);
            }
        }
        System.debug('----------------------------------');
        Integer CPU_AfterExecution = Limits.getCpuTime();
        System.debug(CPU_AfterExecution + ' milliseconds: CPU Time after processing (WITH recursion)');
        System.debug((CPU_AfterSOQL - CPU_BeforeSOQL) + ' milliseconds: Total CPU Time of query');
        System.debug((CPU_AfterExecution - CPU_AfterSOQL) + ' milliseconds:' +
                ' Total CPU Time of processing WITH recursion');
    
        System.debug('----------------------------------');
        Integer heapAfterExecution = Limits.getHeapSize();
        System.debug(heapAfterExecution + ' bytes: Heap size used after processing (WITH recursion)');
        System.debug((heapAfterSOQL - heapBeforeSOQL) + ' bytes: Total Heap size used for SOQL');
        System.debug((heapAfterExecution - heapAfterSOQL) + ' bytes: Total Heap size used for processing ' +
                                                            ' (WITH recursion)');
        
        *//////END With recursion
        
        resList.add('Old Type');
        return resList;
    }
    //////With recursion
    public static List<String> getItems(String str){
        if(str.length() == 0){
            List<String> l = new List<String>{''};
            return l;
        }
        List<String> items = getItems(str.substring(1));
        List<String> result = new List<String>();
        
        Integer k = 0;
        for (Integer i = 0; i < items.size(); i++){
            result.add(items.get(i));
            k++;
        }
        for (Integer i = 0; i < items.size(); i++){
            result.add(str.substring(0, 1) + items.get(i));
            k++;
        }
        
        return result;
    }
}