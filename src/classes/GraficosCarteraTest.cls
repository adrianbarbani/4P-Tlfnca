@isTest
public class GraficosCarteraTest {

    static testMethod void generarAreas(){
        
        Account cuenta = new Account();
        cuenta.name = 'asd';
        insert cuenta;
        
        GraficosCarteraController controller = new GraficosCarteraController();
        controller.filtrar();
        
        controller.obtenerAnterior();
        controller.irAlTab();
        GraficosCarteraController.familiasYRamas wppRamas = new GraficosCarteraController.familiasYRamas();
        wppRamas.getSizeRamas();
        wppRamas.familias = 'asd';
        
        GraficosCarteraController.wrapperMap wpp = new GraficosCarteraController.wrapperMap();
        wpp.cuenta = 'asda';
        
        
    }
}