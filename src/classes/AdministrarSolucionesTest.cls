@isTest
public class AdministrarSolucionesTest {

    static testMethod void test1(){
        
        
        AdministrarSolucionesController controller = new AdministrarSolucionesController();
        
        system.assertEquals(0, controller.lineasDeServicios.size());
        
        
        Linea_de_Servicio__c lineaServicio2 = new Linea_de_Servicio__c();
        lineaServicio2.name = 'test2';
        controller.lineaDeServicioAInsertar = lineaServicio2;
        
        controller.insertarLineaDeServicio();
        
        Linea_de_Servicio__c lineaServicio1 = new Linea_de_Servicio__c();
        lineaServicio1.name = 'test1';
        controller.lineaDeServicioAInsertar = lineaServicio1;
        
        controller.insertarLineaDeServicio();
        
        system.assertEquals(2, controller.lineasDeServicios.size());
        
        Solucion__c solucion1 = new Solucion__c();
        controller.lineaPadreDeLaSolucionAInsertar = lineaServicio1.id;
        controller.solucionAInsertar = solucion1;
       
        controller.insertarSolucion();
        
        controller.solucionABorrarId = solucion1.id;
        controller.borrarSolucion();
        
        controller.lineaABorrarId = lineaServicio1.id;
        controller.borrarLineaDeServicio();
        
         system.assertEquals(1, controller.lineasDeServicios.size());
        
        
    }

}