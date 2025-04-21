trigger TaskTrigger on Task (before delete) {
    
    if(Trigger.isBefore && Trigger.isDelete){
        User currentUser = [Select Profile.Name From User Where Id =: UserInfo.getUserId()];
        String ProfileName = currentUser.Profile.Name;
        for(Task tt: trigger.old){
            if(ProfileName != 'system Admin'){
                tt.addError('you dont have permission to delete this record if you are not system admin');
            }
                
        }
    }    

}