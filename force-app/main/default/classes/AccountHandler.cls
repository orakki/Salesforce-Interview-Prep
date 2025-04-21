public class AccountHandler {
    public static void salesRepsHandler(List<Account> accListNew){
        Set<Id> userId = new Set<Id>();
        for(Account acc : accListNew){
            userId.add(acc.OwnerId);
        }
        
        Map<Id,user> userMap = new Map<Id,user>([Select id,Name from user where id =: userId]);
        
        for(Account acc : accListNew){
            acc.SalesReps__c = userMap.get(acc.OwnerId).Name;
        }
    }
    
    public void createRelatedContact(List<Account> accList){
        List<Contact> contactListToUpdate = new List<Contact>();
        integer i= 0;
        try{
            	for(Account acc : accList){
            	contact con = new contact();
            	con.FirstName = 'Aman '+i;
            	con.LastName = 'Ishwar';
            	con.AccountId = acc.Id;
            	contactListToUpdate.add(con);
        	}
        	if(!contactListToUpdate.isEmpty()){
            	insert contactListToUpdate;
        	}
        }catch(Exception ex){
            system.debug('Aman Ishwar');
        }
        
    }
    Public static void createContact(List<Account> accList){
        List<Contact> conInsetList = new List<Contact>();
        for(Account acc : accList){
            Integer count = Integer.ValueOf(acc.NumberofLocations__c);
            system.debug('number of location---->'+count);
            if(count>0){
                for(Integer i=0;i<count;i++){
                    contact cc = new contact();
                    cc.FirstName = 'Contact'+i;
                    cc.LastName = 'contact last'+i;
                    cc.AccountId = acc.Id;
                    conInsetList.add(cc);
                }
            }
        }
        Insert conInsetList;
    }
    
    Public static void sendEmailToContact(String address,String subject,String body){
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
            mail.setToAddresses(toAddresses);
        	mail.setSubject(subject);
        	mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
    }
    //this will run in the before insert context
    Public Static void updateShippingAddress(List<account> aaList){
        for(account aa: aaList){
            if(aa.billingState != null){
                aa.ShippingState = aa.BillingState;
            }
        }
    }
    
}