public class FastTaskController {

    public Task task {get;set;}
    
    public String PageName {get;set;}
    public String accountId {get;set;}
    public String oppId {get;set;}
    public String done {get;set;}
    public String msj {get;set;}
    public Date duedate {get;set;}

    
    public FastTaskController(){
        
        task = new Task();
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
  
  
    }
    
    public Boolean getcanEdit(){
    
        userActions temp = new userActions();
        return temp.checkWrite(accountId);
    
    }
    

    public PageReference savetask() {
    	
    	Task temp;
        if (oppId!=null && oppId != '') {
        	temp = new Task(subject = PageName, WhatId = oppId, Description = msj, ActivityDate = task.ActivityDate);
        } else {
        	temp = new Task(subject = PageName, WhatId = accountId, Description = msj, ActivityDate = task.ActivityDate);
        }
        insert temp;
        done = 'Sent';

        task = new Task();
        msj = '';

        return null;
    }   
}