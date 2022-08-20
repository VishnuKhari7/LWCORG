public class CaseHandler {
   public static void updateTask(List<Case> caseList, Map<Id,Case> OldCaseMap) {
      Set<Id> caseIds = new Set<Id>();
        List<Task__c> taskList = new List<Task__c>();
        for(Case newCase : caseList){
            Case oldCase = OldCaseMap.get(newCase.Id);
            if(newCase.status!=oldCase.Status && newCase.status == 'Escalated'){
                caseIds.add(newCase.Id);
            }
        }
        for(Task__c task : [Select Id,status__c, Case__c from Task__c where Case__c in:caseIds]){
            task.status__c = 'Closed';
            taskList.add(task);
        }
      update taskList;
}
}