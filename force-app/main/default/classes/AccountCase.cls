public class AccountCase{
    public static Map<Id, Case> fetchOpenCases(List<Id> accIds){
        Map<List<Id>,List<Case>> mapCase = new map<List<Id>,List<Case>>();
        List<Case> caseList = [Select Id,status from Case where Status=:'New'];
        Map<Id, Case> caseMapList = new Map<Id, Case>();
        return caseMapList;
}
    // vishnu
    // To fetch all open cases
    public static Map<Id, List<Case>> fetchallOpenCase(List<Id> accIds){
        map <Id,List<Case>> caseAccmap = new map<Id, List<case>> (); //key is acc Id, values are list of cases
    
        List<Case> caselistAll = [select Id,AccountId from case where AccountId in:accIds AND Status ='New' ]; //fetching all open cases and storing in caselistAll
             for(case caseoBj : caselistAll ){ 
                 if(caseAccmap.containsKey(caseoBj.AccountId)){ // frist record in for loop -- this condition fails
                   List<case> caseListFromMap = caseAccmap.get(caseoBj.AccountId);
                     caseListFromMap.add(caseoBj);
                     caseAccmap.put(caseoBj.AccountId ,caseListFromMap);
                 }else{
                   List<case> caseList = new  List<case>(); 
                     caseList.add(caseoBj);
                      caseAccmap.put(caseoBj.AccountId, caseList) ;
                 }
           /* List<case> caseList = new  List<case>();
                 caseList.add(caseoBj);
           caseAccmap.put(caseoBj.AccountId, caseList) ; */
        }
        return caseAccmap;
    }
    // vishnu using parent to child query 
    public static Map<Id, List<Case>> fetchallOpenCaseQuery(List<Id> accIds){
        map <Id,List<Case>> caseAccmap = new map<Id, List<case>> (); 
      List<Account> accountList  = [select Id,(Select Id  from Cases where AccountId in:accIds AND Status ='New')from Account Where Id in:accIds ];
        for(Account acc : accountList ){
          //List<case> caseList =   acc.Cases ;
        //   caseAccmap.put(acc.Id, caseList);
        caseAccmap.put(acc.Id, acc.Cases);
        }
        return caseAccmap;
    }
     public static Map<Id, List<Case>> fetchallOpenCaseforLoopQuery(List<Id> accIds){
         map <Id,List<Case>> caseAccmap = new map<Id, List<case>> ();
         for(Account acc : [select Id,(Select Id  from cases where AccountId in:accIds AND Status ='New')from Account Where Id in:accIds ]){
              caseAccmap.put(acc.Id, acc.Cases);
         }
    return caseAccmap;
}
      public static List<Map<Id,List<case>>>  task027Das(List<Id> accIds){
       map <Id,List<Case>> caseAccmapOpen = new map<Id, List<case>> (); 
          map <Id,List<Case>> caseAccmapClosed = new map<Id, List<case>> ();
          List<Map<Id,List<case>>> ListcaseAccmapOpenandClose = new List <Map<Id,List<case>>>();
          List<String> caseStatus = new List <String>{'New','Closed'};
          // logic 
          for(Account acc1: [Select Id, (Select Id from cases where AccountId in:accIds AND Status in:caseStatus) from Account where Id in:accIds]){
            List<Case> CaseList = acc1.cases ;
              for(Case caseObj : CaseList){
                  if(caseObj.Status =='New'){
                          if(caseAccmapOpen.isEmpty()){
                                  List<Case> casListObj = new List<Case>{caseObj};
                              caseAccmapOpen.put(acc1.Id,casListObj );
                          }else if(caseAccmapOpen.ContainsKey(acc1.Id)){
                             List<Case> casListFromMap = caseAccmapOpen.get(acc1.Id);
                              casListFromMap.add(caseObj);
                              
                          }

                  }else{
                       if(caseAccmapOpen.isEmpty()){
                                  List<Case> casListObj = new List<Case>{caseObj};
                              caseAccmapClosed.put(acc1.Id,casListObj );
                          }else if(caseAccmapClosed.ContainsKey(acc1.Id)){
                             List<Case> casListFromMap = caseAccmapClosed.get(acc1.Id);
                              casListFromMap.add(caseObj);
                               caseAccmapClosed.put(acc1.Id,casListFromMap );
                              
                          }
                      
                  }
                  
              }
            //  caseAccmapOpen.put(acc1.Id, acc1.cases);
          }
          
         
          ListcaseAccmapOpenandClose.add(caseAccmapClosed);
          ListcaseAccmapOpenandClose.add(caseAccmapOpen);
          
       return ListcaseAccmapOpenandClose;
    
}
    public static List<Map<Id,List<case>>>  task027(List<Id> accIds){
       map <Id,List<Case>> caseAccmapOpen = new map<Id, List<case>> (); 
          map <Id,List<Case>> caseAccmapClosed = new map<Id, List<case>> ();
          List<Map<Id,List<case>>> ListcaseAccmapOpenandClose = new List <Map<Id,List<case>>>();
          List<String> caseStatus = new List <String>{'New','Closed'};
          // logic 
          for(Account acc1: [Select Id, (Select Id from cases where AccountId in:accIds AND Status ='New') from Account where Id in:accIds]){
            List<Case> CaseList = acc1.cases;
              caseAccmapOpen.put(acc1.Id, acc1.cases);
          }
          
          for(Account acc2: [Select Id, (Select Id from cases where AccountId in:accIds AND Status ='Closed') from Account where Id in:accIds]){
              caseAccmapClosed.put(acc2.Id, acc2.cases);
          }
          
          //
          ListcaseAccmapOpenandClose.add(caseAccmapClosed);
          ListcaseAccmapOpenandClose.add(caseAccmapOpen);
          
       return ListcaseAccmapOpenandClose;
        
        // Wrapper class example
        
       
            
        }
    
    // wrapper
 
     Public class allAccountOpttyCaseWrapper{
         @AuraEnabled
         public Account accountObj ;
         @AuraEnabled
          public List<Case> caseList ;
         @AuraEnabled
         Public List<Opportunity> opptyList ;
         @AuraEnabled
         Public integer casecount ;
         @AuraEnabled
          Public integer OpptyCOunt ;
         @AuraEnabled
         Public String CurrentUsername ;
         @AuraEnabled
         Public String CurrentUserEmail ;
     }
    Public static allAccountOpttyCaseWrapper returnMyWrapper(String accId){
        Account acc =  [select Id,(Select Id  from Cases)from Account Where Id=:accId ];
        List<Case> caseList ;
        if(!acc.Cases.IsEmpty()){
        caseList  = acc.Cases;
        }
       
       List<Opportunity> opptyList = [Select Id From Opportunity where AccountId =:accId];
        User userObj = [Select Id,UserName ,Email From User where Id=:UserInfo.getUserId() ];
        
        allAccountOpttyCaseWrapper wrapperObj  = new allAccountOpttyCaseWrapper ();
        wrapperObj.accountObj = acc ;
            wrapperObj.caseList = caseList ;
        wrapperObj.casecount = caseList.Size();
        if(!opptyList.IsEmpty()){
            wrapperObj.opptyList = opptyList;
            wrapperObj.OpptyCOunt = opptyList.Size();
        }
            wrapperObj.CurrentUsername = userObj.Username ;
             wrapperObj.CurrentUserEmail = userObj.Email ;
       return wrapperObj;
        
    }
    
}