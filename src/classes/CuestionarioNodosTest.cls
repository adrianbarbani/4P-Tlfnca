@isTest
public class CuestionarioNodosTest {
    
    static testMethod void creoLosNodos(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
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
        preguntaSi.pregunta__c = 'pregunta si';
        preguntaSi.esHija__c = true;
        insert preguntaSi;
        
        Super_Ball_Pregunta__c preguntaNo = new Super_Ball_Pregunta__c(name='a');
        preguntaNo.Super_Ball_Nodo__c = nodoHijo.id;
        preguntaNo.pregunta__c = 'pregunta no';
        preguntaNo.esHija__c = true;        
        insert preguntaNo;
        
        Super_Ball_Pregunta__c pregunta = new Super_Ball_Pregunta__c(name='a');
        pregunta.Super_Ball_Nodo__c = nodoHijo.id;
        pregunta.Dependencia_Si__c = preguntaSi.id;
        pregunta.Dependencia_No__c = preguntaNo.id;
        pregunta.esHija__c = false;
        insert pregunta;
        
        system.debug(preguntaSi.id);
        system.debug(preguntaNo.id);
        
        Super_Ball_Recurso__c recurso = new Super_Ball_Recurso__c(name = 'a');
        recurso.Super_Ball_Nodo__c = nodoHijo.id;
        insert recurso;
        
        Super_Ball_Solucion__c solucion = new Super_Ball_Solucion__c(name='a');
        solucion.Super_Ball_Nodo__c = nodoHijo.id;
        insert solucion;
        
        Super_Ball_Interlocutor__c interlocutor = new Super_Ball_Interlocutor__c(name ='a');
        interlocutor.Super_Ball_Nodo__c = nodoHijo.id;
        insert interlocutor;
        
        Test.setCurrentPageReference(new PageReference('Page.CuestionarioNodos'));
        System.currentPageReference().getParameters().put('IdNodo', nodo.id);
        System.currentPageReference().getParameters().put('Id', cuenta.id);

        CuestionarioNodosController controller = new CuestionarioNodosController();
        controller.traigoRamasDelNodoOLasGenero();
        controller.renderizar();
        controller.guardar();
        controller.irAMapaDeLaCuenta();
        controller.irAMenu();
    }
}