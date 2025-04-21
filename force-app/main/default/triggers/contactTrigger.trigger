trigger contactTrigger on Contact (after Insert , after Update,after Delete,before Insert, before Update) {
    Set<Id> accIdSet = new Set<Id>();
    List<Account> accUpdateList = new List<Account>();
    if(Trigger.isAfter && (Trigger.isInsert)){
        for(Contact cc:Trigger.new){
            accIdSet.add(cc.AccountId);
        }
        List<Account> accList = new List<Account>([Select Id,count_of_Contact__c,(Select id from Contacts)  from Account where Id = :accIdSet]);
        for(Account acc : accList){
            acc.count_of_Contact__c = acc.Contacts.size();
            accUpdateList.add(acc);
        }
        update accUpdateList;
    }
    if(Trigger.isAfter && (Trigger.isUpdate)){
        for(Contact cc:Trigger.New){
            Contact conOld = Trigger.oldMap.get(cc.Id);
                if(cc.AccountId != conOld.AccountId){
                    accIdSet.add(cc.AccountId);
                    accIdSet.add(conOld.AccountId);
                }else{
                    accIdSet.add(cc.AccountId);
                }
            
        }
        List<Account> accList = new List<Account>([Select Id,count_of_Contact__c,(Select id from Contacts)  from Account where Id = :accIdSet]);
        for(Account acc : accList){
            acc.count_of_Contact__c = acc.Contacts.size();
            accUpdateList.add(acc);
        }
        update accUpdateList;
    }
    
        if(Trigger.isAfter && (Trigger.isDelete)){
        for(Contact cc:Trigger.old){
            accIdSet.add(cc.AccountId);
        }
        List<Account> accList = new List<Account>([Select Id,count_of_Contact__c,(Select id from Contacts)  from Account where Id = :accIdSet]);
        for(Account acc : accList){
            acc.count_of_Contact__c = acc.Contacts.size();
            accUpdateList.add(acc);
        }
        update accUpdateList;
    }

    if(Trigger.isBefore && Trigger.isInsert){
        Set<Id> accountIds = new Set<Id>();
        for(contact cc : Trigger.new){
            if(cc.Status__c == 'Active'){
                accountIds.add(cc.AccountId);
            }
        }
        List<AggregateResult> activeContacts = [Select AccountId,count(Id) cnt From contact
                                               where Status__c = 'Active' and AccountId =:accountIds group by AccountId];
        
        Map<Id,Integer> accountCountMap = new Map<Id,Integer>();
        for(AggregateResult ar : activeContacts){
            accountCountMap.put((Id) ar.get('AccountId'), (Integer) ar.get('cnt') );
        }
        for(Contact cc1 : Trigger.new){
            
        }
			        
    }
    
    if(Trigger.isBefore && Trigger.isInsert){
        
    }
    
    
}