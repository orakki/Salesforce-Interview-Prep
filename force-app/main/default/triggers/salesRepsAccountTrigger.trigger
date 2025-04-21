/*
Name :  Aman Ishwar,
Write a trigger on account when n account is inserted,automatically account billing address should populate into the account
shiping address.
*/
/*trigger accountTriger on Account(Before insert){
    if(Trigger.isInsert && Trigger.isBefore){
        for(Account acc:Trigger.new){
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingCountry = acc.BillingCountry;
            acc.BillingPostalCode = acc.BillingPostalCode;
            acc.ShippingLatitude = acc.BillingLatitude;
            acc.ShippingGeocodeAccuracy = acc.BillingGeocodeAccuracy;
            acc.ShippingStreet = acc.BillingStreet;
            acc.ShippingState = acc.BillingState;
            acc.ShippingLongitude = acc.BillingLongitude;
        }
    }
}*/

/*
Name :  Aman Ishwar,
Write a trigger on the Account when the account is updated check all opportunities related to the account.
Update all opportunities Stage to close lost if an opportunity created date is gretter than 30 days from today and stage not
equal to close won.
*/

/*Trigger accountTriger on Account(After update){
    if(Trigger.isUpdate && Trigger.isAfter){
        Set<Id> accId = new Set<Id>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc : Trigger.new){
            accId.add(acc.Id);
        }
        for(Opportunity opp : [Select Id,CreatedDate,StageName from Opportunity where AccountId =: accId]){
            Date createdDate = opp.CreatedDate.date();
            Date todaydate = Date.today();
            Integer numberOfDaysBeween = createdDate.daysBetween(todaydate);
            if(numberOfDaysBeween>30 && opp.StageName != 'close won'){
                opp.StageName = 'close lost';
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
}*/

/*
Name :  Aman Ishwar,
Once an Account will update then that Account will update with the total amount from All its Opportunities on the Account
Level. The account field name would be Total Opportunity Amount.
*/
/*Trigger accountTriger on Account(before update){
    if(Trigger.isUpdate && Trigger.isBefore){
        //Total_Opportunity_Amount__c 
       List<AggregateResult> oppList = new List<AggregateResult>();
       Set<Id> accIds = new Set<Id>();
        for(Account acc : Trigger.new){
            accIds.add(acc.Id);
        }
        oppList = [Select AccountId,sum(Amount) TotalAmount from Opportunity where AccountId =: accIds group by AccountId];
        Map<Id,Double> accOppMap = new Map<Id,Double>();
        for(AggregateResult opp : oppList){
            Id accId = (Id)opp.get('AccountId');
            Double allAmount = (Double)opp.get('TotalAmount');
            accOppMap.put(accId,allAmount);
        }
        
        for(Account aacc : Trigger.new){
            aacc.Total_Opportunity_Amount__c = accOppMap.get(aacc.Id);
        }
        
    }
}*/


Trigger salesRepsAccountTrigger on Account(before Insert,before Update,After Insert){
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        AccountHandler.salesRepsHandler(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isInsert){
        AccountHandler accMethod = new AccountHandler();
        accMethod.createRelatedContact(Trigger.new);
        AccountHandler.createContact(Trigger.new);
    }
}