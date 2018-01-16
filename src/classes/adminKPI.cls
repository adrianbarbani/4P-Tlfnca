public class adminKPI {

    public String title { get; set; }

    public String regionId { get; set;}

    public String industry { get; set; }
    
    public Region__c region { get; set;} 
    
    public List< KPI__c > KPI;
    
    public List< KPI__c > globalKPI {get; set;}
    
    public KPI__c newKPI { get; set; }
    
    public String IdtoDel {get; set;}

    
    public Boolean canEdit {get;set;}
    
    
    public Account tempAccount{get;set;}

    
    public adminKPI(){
    
        KPI = new List<KPI__c>();
        title = 'Choose a Region and Industry to start';
        tempAccount = new Account();
    }

    public List<KPI__c> getKPI(){
        return KPI;
    }
    

    public List<SelectOption> getRegions(){
        List<SelectOption> options = new List<SelectOption>();

    
        List<Region__c> temp =  [SELECT Name,Id From Region__c ORDER BY name ASC];
        
       for( Region__c c : temp)
       {
          options.add(new SelectOption(c.Id,c.Name));
       }  
       return options;
        
    }
    
    public List<SelectOption> getIndustries(){
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       options.add(new SelectOption('All', 'All'));
       return options;
    }
    
    public PageReference save(){
    	Update globalKPI;
    	Update KPI;    	
    	return null;
    }
    
    public void doUpdate(){
      
      industry=tempAccount.Industry;      
      /*
        region = [SELECT Id, Name FROM Region__c WHERE Id = :regionId];
        KPI = [SELECT Name__c,Unit__c FROM KPI__c WHERE Region__c = :regionId AND Industry__c = :industry];
        
        List<Region__Share> tempedit = [select Id from Region__Share WHERE AccessLevel = 'Edit' AND ParentId =:regionId AND UserOrGroupId =:UserInfo.getUserId()];
        
        if(tempedit.size() > 0)
            canEdit = true;
        else
            canEdit = false;
        
        newKPI = new KPI__c();
        newKPI.Region__c = regionId;
        newKPI.Industry__c = industry;
        title = 'Viewing ' + region.Name + ' region and ' + industry + ' industry';
        */
        
        region = [SELECT Id, Name FROM Region__c WHERE Id = :regionId];
        //system.debug('region');
        
        if (tempAccount.Industry == 'Todos') {
        	tempAccount.Micro_Industry__c = 'Todos';
        } else if ( tempAccount.Industry == 'All') {
        	tempAccount.Micro_Industry__c = 'All';
        }
       	        
        List<Region__Share> tempedit = [select Id from Region__Share WHERE (AccessLevel = 'Edit' OR AccessLevel = 'All') AND ParentId =:regionId AND UserOrGroupId =:UserInfo.getUserId()];
        
        if(tempedit.size() > 0)
            canEdit = true;
        else
            canEdit = false;
        
        //canEdit=true;  
        //system.debug('KPI '+regionId+'-'+tempAccount.Micro_Industry__c+'-'+tempAccount.Sector__c+'-'+tempAccount.Industry); 
        KPI = [SELECT Name,Industry__c,Sub_Sector__c,Sector__c,Name__c,Unit__c FROM KPI__c WHERE Region__c = :regionId AND Industry__c = :tempAccount.Micro_Industry__c AND /*Sector__c = :tempAccount.Sector__c AND*/ Sub_Sector__c = :tempAccount.Industry ORDER BY Name ASC];
        //KPI = [SELECT Name,Industry__c,Sub_Sector__c,Sector__c,Name__c,Unit__c FROM KPI__c WHERE Region__c = :regionId AND Sector__c = :tempAccount.Sector__c AND Sub_Sector__c = :tempAccount.Industry ORDER BY Name ASC];
        //system.debug('KPI : SELECT Name,Industry__c,Sub_Sector__c,Sector__c FROM KPI__c WHERE Region__c = \''+regionId+'\' AND Industry__c = \''+tempAccount.Micro_Industry__c+'\' AND Sector__c = \''+tempAccount.Sector__c+'\' AND Sub_Sector__c = \''+tempAccount.Industry+'\' ORDER BY Name ASC');
        newKPI = new KPI__c();
        newKPI.Region__c = regionId;
        newKPI.Industry__c = tempAccount.Micro_Industry__c;
        newKPI.Sub_Sector__c = tempAccount.Industry;
        newKPI.Sector__c = tempAccount.Sector__c;
        
        title = region.Name + ' > '+tempAccount.Industry+' > '  + tempAccount.Micro_Industry__c;
        //title = 'Viewing ' + region.Name + ' > '+tempAccount.Industry+ ' ('+tempAccount.Sector__c + ' Sector)';
         if(tempAccount.Micro_Industry__c == '' || tempAccount.Industry == '' ||
           tempAccount.Micro_Industry__c == '--None--' || tempAccount.Industry == '--None--' ||
           tempAccount.Micro_Industry__c == null || tempAccount.Industry == null ){
            canEdit = false;
            title = 'Debe seleccionar un Sector y un Subsector';
            industry=null;
        }
    }
    

    public PageReference InsertNewKPI() {
        
        insert newKPI;
        this.doUpdate();
        return null;
    }


    public PageReference del(){
    

        this.IdtoDel = Apexpages.currentPage().getParameters().get('IdtoDelete');  
    
        KPI__c toDel= [ SELECT id FROM KPI__c WHERE Id = :this.IdtoDel];
        
        delete toDel;
        
        doUpdate();
        
        return null;       
    }
    
    
    public void checkStandardKPIs(){
    
        //Busco que en todas las industrias esten los KPIs basicos.
        /*    
        Region__c globalRegion = [SELECT id, name FROM Region__C WHERE name = 'Global'];
        
        List<KPI__c> KPI1 = [SELECT Name__c,Unit__c FROM KPI__c WHERE Internal_Name__c = 'Number of Employees' AND  Region__c = :globalRegion.id AND Industry__c = 'All'];
        if(KPI1.size() == 0){
            KPI__c temp = new KPI__c();
            temp.Internal_Name__c = 'Number of Employees';
            temp.Name__c = System.Label.Employees;
            temp.Unit__c = System.Label.Head_Count;
            temp.Region__c = globalRegion.id;
            temp.Industry__c = 'All';
        
            insert temp;
        }
        
        KPI1 = [SELECT Name__c,Unit__c FROM KPI__c WHERE Internal_Name__c = 'Number of Branches' AND  Region__c = :globalRegion.id AND Industry__c = 'All'];
        if(KPI1.size() == 0){
            KPI__c temp = new KPI__c();
            temp.Internal_Name__c = 'Number of Branches';
            temp.Name__c = System.Label.Number_of_Branches;
            temp.Unit__c = System.Label.Units;
            temp.Region__c = globalRegion.id;
            temp.Industry__c = 'All';
        
            insert temp;
        }
        */
        globalKPI = [SELECT Name__c,Unit__c FROM KPI__c WHERE Industry__c = 'All'];
    }
    
    public String getHashIndustry(){
        if(industry !=null)
            return industry.replaceAll('[^a-zA-Z]', '');
        else
            return '*';
    }
}