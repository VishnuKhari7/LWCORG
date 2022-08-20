@isTest(SeeAllData=false)
public class CaseHandlerTest{
    @testSetup static void setup(){
        Case caseRec = new Case(Status = 'New',Origin ='Phone');
        insert caseRec;
        Task__c taskRec1 = new Task__c(Name='task 1',Status__c='New',Case__c=caseRec.Id);
        Task__c taskRec2 = new Task__c(Name='task 2',Status__c='Closed',Case__c=caseRec.Id);
        Task__c taskRec3 = new Task__c(Name='task 3',Status__c='New',Case__c=caseRec.Id);
        List<Task__c > taskList = new List<Task__c >();
        taskList.add(taskRec1);
        taskList.add(taskRec2);
        taskList.add(taskRec3);
        insert taskList;
    }
    
    @isTest static void updateTask_Test() {
        
        Test.startTest();
        List<Case> caseList = [Select Id, status from Case Limit 1];
        caseList[0].status = 'Escalated';
        update caseList;
        Test.stopTest();
    }
}