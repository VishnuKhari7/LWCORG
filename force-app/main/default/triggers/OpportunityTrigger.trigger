//check opportunity amount and update max opp amount in acc fields
trigger OpportunityTrigger on Opportunity (before insert,before update,after insert,after update,before delete) {
    if(Trigger.isAfter && Trigger.isUpdate){
   opportunityHandler.updateMaxOpptyAmountOnAccount2(trigger.new,trigger.oldMap);
    }

}