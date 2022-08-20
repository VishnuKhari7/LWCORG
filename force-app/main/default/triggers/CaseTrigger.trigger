trigger CaseTrigger on Case (before insert,before update,after insert,after update,before delete) {
    if(Trigger.isAfter && Trigger.isUpdate){
        CaseHandler.updateTask(Trigger.new, Trigger.OldMap);
    }
}