public class userActions{
	
	public Static Id accountId {get;set;}
	public Static Id userId {get;set;}
	public Static List<AccountShare> accountShareList {get;set;}

    public Boolean checkWrite(Account a){
    	
    	String uid = UserInfo.getUserId();
		
		if (UserActions.accountId == null) {
    		UserActions.accountId = a.id;
    	}
    	if (UserActions.userId == null) {
    		UserActions.userId = uid;
    	}
		
		List<AccountShare> temp;
		if (UserActions.userId != uid || UserActions.accountId != a.id || UserActions.accountShareList == null) {        
        	temp = [SELECT AccountAccessLevel,UserOrGroupId FROM AccountShare WHERE AccountId = : a.id AND UserOrGroupId = :uid];
        	UserActions.accountShareList = temp;
		} else {
			temp = UserActions.accountShareList;
		}
		
        if(temp.size()==0)
            return false;
        
        if(temp[0].AccountAccessLevel == 'All' || temp[0].AccountAccessLevel == 'Edit')
            return true;
        else
            return false;
    
    }

    public Boolean checkWrite(String a){
    
        String uid = UserInfo.getUserId();
        List<AccountShare> temp = [SELECT AccountAccessLevel,UserOrGroupId FROM AccountShare WHERE AccountId = : a AND UserOrGroupId = :uid];
        System.Debug(temp);
        
        if(temp.size()==0)
            return false;
        
        if(temp[0].AccountAccessLevel == 'All' || temp[0].AccountAccessLevel == 'Edit')
            return true;
        else
            return false;
    
    }

}