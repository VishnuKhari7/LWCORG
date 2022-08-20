//check opportunity amount and update max opp amount in acc fields
//first need to check opp amount which is greater
public class opportunityHandler {
    /*  public static void updateAccount(List<opportunity> newList,Map<Id,opportunity> oldMap){ 
Set<Id>  accIds = new Set<Id>();
List<Account> accList = new List<Account>();
Decimal maxAmount;
for(Opportunity opp : newList){
if(opp.Amount > maxAmount) {
accIds.add(opp.AccountId);
accIds.add(oldMap.get(opp.Id).AccountId);
system.debug('accIds'+accIds);

maxAmount = opp.Amount;   
}
}
for(Account acc : [Select Id,Name,Max_amount_from_Opp__c,Max_amount_Opp_ID__c, (Select Id,amount from Opportunities) from Account where Id In:accIds]){
// acc.Max_amount_from_Opp__c == acc.opportunities.amount;
system.debug('Max_amount_from_Opp__c'+acc.Max_amount_from_Opp__c);
accList.add(acc);
}
update accList;
} */
    /****
* Cretaed BY Vishnu
* */
    
    public static void updateMaxOpptyAmountOnAccount(List<opportunity> newList,Map<Id,opportunity> oldMap){ 
        Set<Id>  accIds = new Set<Id>();
        List<Account> accListToUpdate = new List<Account>();
        for(Opportunity opp : newList){
            if(opp.amount !=null &&  oldMap.get(opp.Id).amount != Null && opp.amount != oldMap.get(opp.Id).amount){
                //above check is to check the oppty amount is updated or not if updated add those account Ids to a set   
                accIds.add(opp.AccountId);    
            }
        }
        // query to get Opptys from account  parent to child
        for(Account acc : [Select Id,Name,Max_amount_from_Opp__c,Best_Opportunity_Id__c, (Select Id,amount from Opportunities where amount != NULL) from Account where Id In:accIds]){ 
            List<opportunity> opptyList = acc.Opportunities ;
            decimal OpptyAmountofPrivoiusRecord=0 ;
           integer i = 0 ;
            for(opportunity opp : opptyList){
         //  50,200,25
                if(opptyList.size() ==1){
                    acc.Max_amount_from_Opp__c = opp.Amount ;
                    acc.Best_Opportunity_Id__c = opp.Id ;
                }else if( i == 0 && opptyList.size() > 1 ){
                    OpptyAmountofPrivoiusRecord = opp.Amount ;
                    acc.Max_amount_from_Opp__c = opp.Amount ;
                    acc.Best_Opportunity_Id__c = opp.Id ;
                    i ++ ;
                }else if (opp.Amount > OpptyAmountofPrivoiusRecord ){
                    OpptyAmountofPrivoiusRecord = opp.Amount ;
                    acc.Max_amount_from_Opp__c = opp.Amount ;
                    acc.Best_Opportunity_Id__c = opp.Id ;
                }
            }
            accListToUpdate.add(acc);
        }
        if(accListToUpdate.isEmpty()){
            update accListToUpdate;
        }
        /** second method easy method to avoid unnesseary if else in code
*  */
        
    }
          /** second method easy method to avoid unnesseary if else in code
          *  */
    public static void updateMaxOpptyAmountOnAccount2(List<opportunity> newList,Map<Id,opportunity> oldMap){ 
        Set<Id>  accIds = new Set<Id>();
        List<Account> accListToUpdate = new List<Account>();
        Decimal maxAmount;
        
        for(Opportunity opp : newList){
            if(opp.amount !=null &&  oldMap.get(opp.Id).amount != Null && opp.amount != oldMap.get(opp.Id).amount){
                //above check is to check the oppty amount is updated or not if updated add those account Ids to a set   
                accIds.add(opp.AccountId);    
                system.debug('accIds'+accIds);
            }
        }
        
        // query to get Opptys from account child to parent
        for(Account acc : [Select Id,Name,Max_amount_from_Opp__c,Best_Opportunity_Id__c, (Select Id,amount from Opportunities where amount != NULL ORDER BY amount DESC Limit 1) from Account where Id In:accIds]){ 
            List<opportunity> opptyList = acc.Opportunities ;
            for(opportunity opp : opptyList){
                acc.Max_amount_from_Opp__c = opp.Amount ;
                acc.Best_Opportunity_Id__c = opp.Id ;
            }
            accListToUpdate.add(acc);
        }
        if(!accListToUpdate.isEmpty()){
            update accListToUpdate;
        }
    }
}