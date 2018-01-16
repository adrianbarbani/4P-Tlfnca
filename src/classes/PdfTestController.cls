public class PdfTestController {
    
    public Opportunity oportunidad {get; set;}
    
    public PdfTestController(){
        oportunidad = [SELECT id, name, description FROM Opportunity LIMIT 1];    
    }
    
    public PageReference sendPdf() {
        
        return null;
        
    }
 
}