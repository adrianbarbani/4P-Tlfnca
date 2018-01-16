@isTest
public class graficoSBControllerTest {

    static testMethod void graficosSBController(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        cuenta.Micro_Industry__c = 'Financiero';
        insert cuenta;
        
        Super_Ball_Arbol__c arbol = new Super_Ball_Arbol__c(name='arbol');
        arbol.Sector__c = 'Financiero';
        insert arbol;
        
        Super_Ball_Nodo__c nodo = new Super_Ball_Nodo__c(name='nodoPadre');
        nodo.Super_Ball_Arbol__c = arbol.id;
        insert nodo;
        
        Super_Ball_Nodo__c nodoHijo = new Super_Ball_Nodo__c(name='nodoHijo');
        nodoHijo.Super_Ball_Arbol__c = arbol.id;
        nodoHijo.Nodo_Padre__c = nodo.id;
        insert nodoHijo;
        
        Super_Ball_Pregunta__c preguntaSi = new Super_Ball_Pregunta__c(name='a');
        preguntaSi.Super_Ball_Nodo__c = nodoHijo.id;
        preguntaSi.esHija__c = true;
        insert preguntaSi;
        
        Super_Ball_Pregunta__c preguntaNo = new Super_Ball_Pregunta__c(name='a');
        preguntaNo.Super_Ball_Nodo__c = nodoHijo.id;
        preguntaNo.esHija__c = true;        
        insert preguntaNo;
        
        Super_Ball_Pregunta__c pregunta = new Super_Ball_Pregunta__c(name='a');
        pregunta.Super_Ball_Nodo__c = nodoHijo.id;
        pregunta.Dependencia_Si__c = preguntaSi.id;
        pregunta.Dependencia_No__c = preguntaNo.id;
        pregunta.esHija__c = false;
        insert pregunta;
        
        Super_Ball_Recurso__c recurso = new Super_Ball_Recurso__c(name = 'a');
        recurso.Super_Ball_Nodo__c = nodoHijo.id;
        insert recurso;
        
        Super_Ball_Solucion__c solucion = new Super_Ball_Solucion__c(name='a');
        solucion.Super_Ball_Nodo__c = nodoHijo.id;
        insert solucion;
        
        SB_Cuenta_Solucion__c solucionCuenta = new SB_Cuenta_Solucion__c(name='a');
        solucionCuenta.Super_Ball_Nodo__c = nodoHijo.id;
        solucionCuenta.Super_Ball_Solucion__c = solucion.id;
        insert solucionCuenta;
        
        Super_Ball_Interlocutor__c interlocutor = new Super_Ball_Interlocutor__c(name ='a');
        interlocutor.Super_Ball_Nodo__c = nodoHijo.id;
        insert interlocutor;
        
        Test.setCurrentPageReference(new PageReference('Page.PruebaVis'));
        System.currentPageReference().getParameters().put('IdNodo', nodo.id);
        System.currentPageReference().getParameters().put('Id', cuenta.id);
        
        GraficoSBController controller = new graficoSBController();
        controller.volverDePantallaCompleta();
        controller.pantallaCompleta();
        controller.irACuestionario();
    }
}