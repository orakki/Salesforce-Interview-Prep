public class OpportunityHandler {

    // public static void maxOpportunityOnAccount(List<Opportunity> oppNewList, Map<Id,Opportunity> oldOppMap){
    //     //Below we are diclariring the accountId so that we can add account where we have to make change to the maxOpp field!!!
    //     Set <Id> accountId = new Set<Id>();
        
    //         //System.debug('Debugging OpportunityHandler: oldOppMap is not empty.');
    //         for(Opportunity opp : oppNewList){
    //             if(!oldOppMap.isEmpty()){
    //                 if(opp.AccountId != oldOppMap.get(opp.Id).AccountId){
    //                     accountId.add(opp.AccountId);
    //                     accountId.add(oldOppMap.get(opp.Id).AccountId);
    //                 }else{
    //                     accountId.add(opp.AccountId);
    //                 }
    //             }else{
    //                 accountId.add(opp.AccountId);
    //             }
    //         }



    //         // below is a code which will get the Account and find the max ammount of opportunity
    //         List<Account> accUpdateList = new List<Account>();
    //         if(!accountId.isEmpty()){
    //             for(Account Acc : [Select Max_Opp__c, (Select Amount from Opportunities Order by Amount DESC LIMIT 1) from Account where Id IN :accountId]){
    //                 System.debug('Debugging OpportunityHandler: oldOppMap is not empty.');
    //                 if(!Acc.Opportunities.isEmpty()){
    //                     Acc.Max_Opp__c = Acc.Opportunities[0].Amount;
    //                     accUpdateList.add(Acc);
    //                 }else{
    //                     Acc.Max_Opp__c = null;
    //                     accUpdateList.add(Acc);
    //                 }
    //             }
    //             if(!accUpdateList.isEmpty()){
    //                 Update accUpdateList;
    //             }
    //         }
    // }

    public static void maxOpportunityOnAccount(List<Opportunity> newOpp,Map<Id, Opportunity> oldMap){
        if(!newOpp.isEmpty()){
            set<Id> accIds = new set<Id>();
            for(opportunity opp : newOpp){
                if(!oldMap.isEmpty()){
                    if(opp.AccountId != oldMap.get(opp.Id).AccountId){
                        accIds.add(opp.AccountId);
                        accIds.add(oldMap.get(opp.Id).AccountId);
                    }else{
                        accIds.add(opp.AccountId);
                    }
                }else{
                    accIds.add(opp.AccountId);
                }
            }
            
            if(!accIds.isEmpty()){
                List<Account> accUpdateList = new List<Account>();
                for(Account acc : [Select Max_Opp__c,(Select Amount from Opportunities order by Amount DESC Limit 1) From Account where Id IN : accIds]){
                    if(!acc.Opportunities.isEmpty()){
                        acc.Max_Opp__c = acc.Opportunities[0].Amount;
                        accUpdateList.add(acc);
                    }else{
                        acc.Max_Opp__c = null;
                        accUpdateList.add(acc);
                    }
                }
                If(!accUpdateList.isEmpty()){
                    update accUpdateList;
                }
            }
        }
    }
}