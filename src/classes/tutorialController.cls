public class tutorialController {
	
	public String pageName {get;set;}
	public String text {get;set;}
	
	public tutorialController() {
		
        system.debug(ApexPages.currentPage().getUrl());
        
        List<String> tutorial = ApexPages.currentPage().getUrl().split('certa_scp__');
        if(tutorial.size()>1){
            pageName = tutorial[1];
        	pageName = pageName.replace('?', '####').split('####')[0];
        }else{
            pageName = '';
        }
		
	}
    
    public Boolean getRenderInComunity(){
        return  ApexPages.currentPage().getUrl().contains('apex');
    }
	
}