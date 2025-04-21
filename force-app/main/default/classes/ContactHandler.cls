public class ContactHandler {
    public static void duplicateContactCheck(List<contact> contactList){
        Set<String> contactEmail = new Set<String>();
        Set<String> contactPhoneNumber = new Set<String>();
        for(contact cc:contactList){
            if(cc.Phone != null){
                contactPhoneNumber.add(cc.Phone);
            }
            if(cc.Email != null){
                contactEmail.add(cc.Email);
            }
        }
        List<contact> ccListDulicate = new List<contact>([Select id,Phone,Email from contact where email =:contactEmail OR Phone =:contactPhoneNumber ]);
        
        Set<String> duplicateEmail = new Set<String>();
        Set<String> duplicatePhone = new Set<String>();
        for(contact cc : ccListDulicate){
            if(cc.Email != null){
				duplicateEmail.add(cc.Email);                
            }
            if(cc.Phone != null){
                duplicatePhone.add(cc.Phone);
            }
        }
        
        for(contact cc : contactList){
            if(cc.Email != null && duplicateEmail.contains(cc.Email.toLowerCase())){
                cc.addError('This is duplicate Email');
            }
               if(cc.Phone != null && duplicatePhone.contains(cc.Phone)){
                   cc.addError('This is duplicate Phone');
               }
        }
    }
    
   
    
    
    
    
    
    
    
    
    
    
}