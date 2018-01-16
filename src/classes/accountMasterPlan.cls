public class accountMasterPlan {

    public Account account { get; set; }
    public String temp {get;set;}
    public List<TaskWrapper> tasks { get; set; }
    public Boolean canEdit {get;set;}
    public String sortExpression {get;set;}
    public String sortDirection {get;set;}
    public String filterExpression {get;set;}
    public String filterText {get;set;}

    public accountMasterPlan(ApexPages.StandardController stdController) {
        this();
    }

    public accountMasterPlan(){
        
        if (Util.globalAccount==null) {
        	this.account = [SELECT name, id, parentId, Industry, Region__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        } else {
    		this.account = Util.globalAccount; 
    	}
        
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();

        this.canEdit=true;
        this.sortExpression = 'CreatedDate';
        this.sortDirection = 'ASC';
        this.filterExpression = '';
        this.filterText = ''; 
        this.loadTasks();

    }
    
    public void loadTasks(){
    	
        List<Id> oppIds = new List<Id>();
        For (Opportunity opp :[select id from opportunity where accountId = :account.id]) {
        	oppIds.add(opp.id);
        }                
        
        tasks = new List<TaskWrapper>();
        for(Task t :[select subject, Description, ActivityDate, Status,Priority,End_date__c, OwnerId, CreatedDate, Owner.Name, URL__C FROM Task WHERE WhatId = :account.id or WhatId in :oppIds]){
            tasks.add(new TaskWrapper(t));
        }

    }
    
    private List<Task> getChangedTask() {
      Map<Id, Task> taskMap = new Map<Id, Task>();      
      for (TaskWrapper t :tasks) {
        taskMap.put(t.task.id,t.task);
      }      
      List<Task> taskList = new List<Task>();
      for (Task oldTask :[select id, Subject, Description, URL__c, ActivityDate, End_Date__c, Status, Priority, OwnerId from task where id in :taskMap.keySet()]) {
        Task newTask = taskMap.get(oldTask.id);
        if (newTask.Subject != oldTask.Subject || newTask.Description != oldTask.Description || newTask.URL__c != oldTask.URL__c
          || newTask.ActivityDate != oldTask.ActivityDate || newTask.End_Date__c != oldTask.End_Date__c || newTask.Status != oldTask.Status
          || newTask.Priority != oldTask.Priority || newTask.OwnerId != oldTask.OwnerId) {

          taskList.add(newTask);          
        }
      }      
      return taskList;
    }
    
    private Boolean canSave() {
      boolean canSave = true;
      boolean canEdit = (new userActions()).checkWrite(this.account);
      for (Task t :getChangedTask()) {
      if (!canEdit && t.Ownerid != UserInfo.getUserId() ) {
        canSave = false;
        break;
      }
    }      
      return canSave;
    }

    public PageReference SaveChanges() {        
        if (canSave()) {        
          Map<Id,Task> taskMap = new Map<Id,Task>();
          for(TaskWrapper tw : tasks){
              taskMap.put(tw.task.Id,tw.task);
              if(tw.task.End_date__c == null && tw.task.Status == 'Completed')
                  tw.task.End_date__c = Date.today();
              else if(tw.task.End_date__c != null && tw.task.Status != 'Completed')
                  tw.task.End_date__c = null;
          }
          List<Task> taskListEmail = new list<Task>();
          List<Task> taskListNotEmail = new list<Task>();
          for (Task t :[select Id, OwnerId from Task where id in :taskMap.keySet()]) {
              if (t.OwnerId != taskMap.get(t.Id).OwnerId) {
                  taskListEmail.add(taskMap.get(t.Id));            
              } else {
                  taskListNotEmail.add(taskMap.get(t.Id));            
              }
          }
  
          Database.DMLOptions dmlo = new Database.DMLOptions();
          dmlo.EmailHeader.triggerUserEmail = true;
          database.update(taskListEmail, dmlo);
          database.update(taskListNotEmail);
  
          update account;
          loadTasks();
        }else {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.ErrorDeleteTask));
        }
        return null;
        
    }
    
    public PageReference DeleteTasks() {
        List<Task> taskList = new List<Task>();
        boolean canDelete = true; 
        boolean canEdit = new userActions().checkWrite(this.account);
        
        for(TaskWrapper tw : tasks) {
            if(tw.selected) {
		        if (!canEdit && tw.task.Ownerid != UserInfo.getUserId()) {
		          canDelete = false;
		          break;
		        }
		        taskList.add(tw.task);                                
            }            
        }        
        
        if (canDelete) {
        	delete taskList;
        } else {
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.ErrorDeleteTask));
        }
        loadTasks();
        return null;
    }
    
    public PageReference irACuestionario(){
        
        String url = Page.cuestionarioFourPlanning.getURL();
        return new PageReference (url + '?id=' + account.id);
    }


    public PageReference MergeTasks() {
        Task newTask = new Task();
        newTask.Subject = '';
        newTask.Description = '';
        newTask.Status = 'Deferred';
        
        List<Task> taskToDelete = new List<Task>();
      	boolean canMerge = true; 
        boolean canEdit = new userActions().checkWrite(this.account);
    
        for(TaskWrapper tw : tasks) {
            if(tw.selected){
                if (!canEdit && tw.task.Ownerid != UserInfo.getUserId()) {
		          canMerge = false;
		          break;
		        }
                if(newTask.Subject == '' || (newTask.Subject == tw.task.Subject))
                    newTask.Subject = tw.task.Subject;
                else
                    newTask.Subject = newTask.Subject + ' ' + tw.task.Subject;
                    
                newTask.Description = newTask.Description + tw.task.Description + ' ';
                if(newTask.ActivityDate >  tw.task.ActivityDate)
                    newTask.ActivityDate = tw.task.ActivityDate;
                
                if(     (newTask.Status == 'Deferred')
                    ||  (newTask.Status == 'Waiting on someone else' && ( tw.task.Status == 'Not Started' || tw.task.Status == 'In Progress' || tw.task.Status == 'Completed') ) 
                    ||  (newTask.Status == 'Completed' && ( tw.task.Status == 'Not Started' || tw.task.Status == 'In Progress' ) )
                    ||  (newTask.Status == 'In Progress' && ( tw.task.Status == 'Not Started') )
                  )
                    newTask.Status = tw.task.Status;
                
                if(     (newTask.Priority == '')
                    ||  (newTask.Priority == 'Low' && ( tw.task.Priority == 'Normal' || tw.task.Priority == 'High') )
                    ||  (newTask.Priority == 'Normal' &&  tw.task.Priority == 'High' )
                  )
                    newTask.Priority = tw.task.Priority;

                newTask.OwnerId = tw.task.OwnerId;

       		 	taskToDelete.add(tw.task);
            }
        }
        
        if (canMerge) {
        	delete taskToDelete;
        
        	newTask.WhatId = account.id;
        	if(newTask.Description != '') {
            	insert newTask;
        	}
        } else {
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.ErrorDeleteTask));
        }
        
        loadTasks();
        return null;
    }
    
    public List<String> getTaskStatusList(){
    
    	List<String> ret = new List<String>();
    
    	Schema.DescribeFieldResult fieldResult = Task.Status.getDescribe();
     	List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
     	for( Schema.PicklistEntry f : ple) {
        	ret.add(f.getLabel());
       	}  
    
       	return ret;
    }
    
    public List<String> getPriorityList(){
    
    	List<String> ret = new List<String>();
    
    	Schema.DescribeFieldResult fieldResult = Task.Priority.getDescribe();
    	List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
    	for( Schema.PicklistEntry f : ple) {
       		ret.add(f.getLabel());
       	}  
       	return ret;
    }

    public List<String> getAssignedToList(){
    
       List<String> ret = new List<String>();
       
       LIST<AggregateResult> temp = [SELECT Owner.name FROM Task WHERE WhatId = :account.id GROUP BY Owner.name];
       
       for(AggregateResult t : temp){
           Boolean add = true;
           for(String s : ret) {
               if(s == String.valueOf(t.get('name'))){
                   add = false;
                   break;
               }
           }
           if (add) {
               ret.add(String.valueOf(t.get('name')));
           }
       	}
               
        return ret;
    
    }


    public List<SelectOption> getSubjectList(){
    
		List<SelectOption> ret = new List<SelectOption>();
       
		LIST<Task> temp = [SELECT Subject FROM Task WHERE WhatId = :account.id ];
		ret.add(new SelectOption('',''));
		for(Task t : temp){
			Boolean add = true;
			for(SelectOption s : ret) {
               	if(s.getValue() == t.Subject){
                   	add = false;
                   	break;
               	}
           	}
           	if(add && t.Subject != null) {
           		ret.add(new SelectOption(t.Subject,t.Subject));
           	}
       	}
       	ret.add(new SelectOption('#$NEWSUBJECT','New Subject'));

       	return ret;
    }
	
	public PageReference ExportToExcel() {      
        SaveChanges();
        return Page.accountMasterPlanExcel;        
    }
    
    public String getExcelName() {
        String name = account.Name + '-' + Label.Action_Plan_Builder + '.xls';
        return name.replaceAll(' ', '_').replaceAll(',','');
    }
	

    public class TaskWrapper{
    
        public Task task {get;set;}
        public Boolean selected {get;set;}
        
        public TaskWrapper(Task task){
            selected = false;
            this.task = task;
        }
        
        public void save(){
            if(task.End_date__c == null && task.Status == 'Completada')
                task.End_date__c = Date.today();
            else if(task.End_date__c != null && task.Status != 'Completada')
                task.End_date__c = null;
            update task;
        }
    
    }

}