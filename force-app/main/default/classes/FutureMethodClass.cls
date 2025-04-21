public class FutureMethodClass implements LearningInterface {
    @future
    public static void contactCount(List<Id> accIdList){
        List<Account> accList = new List<Account>([Select Id,(Select Id from Contacts) from Account where Id =: accIdList]);
        for(Account acc : accList){
            system.debug(acc.Contacts.size());
            acc.contactCount__c = acc.Contacts.size();
        }
        update accList;
    }
    public static String testMethods(String aa){
        return 'Ishwar';
    }

}