public class OutlookTestPageController {
	
	//Seteado
    public Integer previusFiscalYear {get;set;}
    public Integer ytdRevenue {get;set;}
    public Integer projected {get;set;}
    public Integer Budget {get; set;}
    
    //Calculado de Opp
    public Integer backlog {get; set;}
    public Integer forecast {get; set;}
    
    //Calculado de anteriores valores
    public Integer challenge {get; set;}
    
    public Boolean mostrarGrafico {get; set;}
    
    public OutlookTestPageController(){
        previusFiscalYear = 0;
        ytdRevenue = 0;
        projected = 0;
        budget = 0;
        
        backlog = 0;
        forecast = 0;
        
        challenge = 0;
        
        mostrarGrafico = false;
    }
    
    public void actualizarValores(){
        mostrarGrafico = true;
        calcularChallenge();
    }
    
    public void calcularChallenge(){
        challenge = Budget - (ytdRevenue+projected+backlog+forecast);
    }
}