public class MYACCOUNTDATA {
    @AuraEnabled(cacheable=true)
    public static List<Account> accdata(){
        List<Id> accid = new List<Id>{'0015j00001D2x73AAB','0015j00001D2x72AAB','0015j00001D2x74AAB','0015j00001D2x76AAB'};
        return [Select Id, Name, AnnualRevenue, Type, Industry From Account where Id IN :accid Limit 10];
    }
}