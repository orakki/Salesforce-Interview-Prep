trigger OpportunityTrigger on Opportunity (After Insert,After Update,After Delete,After Undelete) {
	//OpportunityHandler.maxOpportunityOnAccount(Trigger.new,Trigger.oldMap);
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityHandler.maxOpportunityOnAccount(Trigger.new,Trigger.oldMap);
    }
    If(Trigger.isAfter && Trigger.isDelete){
        OpportunityHandler.maxOpportunityOnAccount(Trigger.old,null);
    }
    if(Trigger.isAfter && Trigger.isInsert && Trigger.isUndelete){
        OpportunityHandler.maxOpportunityOnAccount(Trigger.new,null);
    }
}