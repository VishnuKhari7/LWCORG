trigger AccountTrigger on Account (before insert,before update,after insert,after update,before delete) {
    List<Id> accIds = new List<Id>();
    if(trigger.isBefore && trigger.isupdate){
        for(Account acc : trigger.new){
            accIds.add(acc.Id);
        }
        If(!AccountHandler.isExecuted){
           AccountHandler.UpdateRating(trigger.new);
             AccountHandler.isExecuted = true;
        }
    }
}