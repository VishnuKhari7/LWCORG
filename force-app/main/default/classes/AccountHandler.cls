public class AccountHandler {
          public static Boolean isExecuted = false;
    public static void checkmobileNUmber(List<Account> listaccount){
        for(Account acc: listaccount){
            if(acc.Mobile_Number__c == null){
               acc.addError('Please fill mobile number'); 
            }
        }
        
    }
    
     public static void UpdateRating(List<Account> accountList){
      //  List<Account> accountListToupdate = new List<Account> ();
         if(!isExecuted){
           for(Account acc: accountList){
            acc.Rating = 'Cold' ;

        }
         }
    }

}