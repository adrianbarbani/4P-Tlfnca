@isTest
private class test_accountMasterPlan {

    static testMethod void myUnitTest() {
      
      
    Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';
        
        insert cuenta;      
      
      
      Task task = new Task();
      task.WhatId = cuenta.id;
      task.Subject = 'Step 1';
      insert task;
      
      Task task2 = new Task();
      task2.WhatId = cuenta.id;
      task2.Subject = 'Step 1';
      insert task2; 
      
      System.currentPagereference().getParameters().put('id',cuenta.id);
        
    accountMasterPlan p_Test = new accountMasterPlan();
      for(accountMasterPlan.TaskWrapper tw :p_Test.tasks){
        
        tw.selected = true;
      }
      
      p_Test.MergeTasks();
      
      p_Test.getAssignedToList();
      p_Test.getPriorityList();
      p_Test.getSubjectList();
      p_Test.getTaskStatusList();
      
      p_Test.SaveChanges();
      
      for(accountMasterPlan.TaskWrapper tw :p_Test.tasks){
        
        tw.selected = true;
      }
      
      p_Test.DeleteTasks();
      
    }
}