@isTest
public class PlanificacionPrincipalsTest {
    
    static testMethod void myUnitTest() {
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        Opportunity opp = new Opportunity();
        opp.name = 'as';
        opp.AccountId = cuenta.id;
        opp.linea_de_negocio__c = 'Movil';
        opp.full_contract_value__c = 23;
        opp.CloseDate = Date.today().addDays(-3); 
        opp.StageName = 'Closed Won';
        insert opp;
        
        opp = new Opportunity();
        opp.name = 'as';
        opp.AccountId = cuenta.id;
        opp.linea_de_negocio__c = 'Fijo';
        opp.full_contract_value__c = 23;
        opp.CloseDate = Date.today().addDays(-3); 
        opp.StageName = 'Closed Won';
        insert opp;
        
        opp = new Opportunity();
        opp.name = 'as';
        opp.AccountId = cuenta.id;
        opp.linea_de_negocio__c = 'Digital';
        opp.full_contract_value__c = 23;
        opp.CloseDate = Date.today().addDays(-3); 
        opp.StageName = 'Closed Won';
        insert opp;
        
        opp = new Opportunity();
        opp.name = 'as';
        opp.AccountId = cuenta.id;
        opp.linea_de_negocio__c = 'Convergente';
        opp.full_contract_value__c = 23;
        opp.CloseDate = Date.today().addDays(-3); 
        opp.StageName = 'Closed Won';
        insert opp;
        
        PageReference cuestionario = Page.Planificacion; 
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        PlanificacionPrincipalController a = new PlanificacionPrincipalController();
        a.idCuenta = cuenta.id;
        a.sumar(1,2);
        a.insertar4Planning();
        
        a.hitoAInsertar.categoria__c = 'Otro';
        a.insertHito();
        
        a.hitoABorrarId = [select id from FourPlanning_Hito__c].id;
        a.BorrarHito();
        
        a.retoAInsertar.Nombre_del_Reto__c = 'asd';
        a.retoAInsertar.Etapa_del_Reto__c = '1';
        a.solucionAInsertar2.Lista_de_Soluciones__c = 'asd';
        a.areaAInsertar.Tipo_de_Area__c = 'Digitalización';
        a.areaAInsertar.Titulo_Area__c = 'ASD';
        a.solucionAInsertar2.Nivel_de_Desarrollo__c = '123';
        
        a.insertarReto();
        
        a.retoAInsertar2.Nombre_del_Reto__c = 'asd';
        a.areaAInsertar.Titulo_Area__c = 'ASD';
        a.insertarRetoCustom();
        
        a.retoABorrarId = [select id from FourPlanning_Reto__c limit 1].id;
        a.BorrarReto();
        a.setearOportunidadesAContacto();
        
        a.idDelRetoDelContacto = [select id from FourPlanning_Reto__c limit 1].id;
        a.crearPlanDeAccion();

        a.cancelarApoyoAVentaEspecialista();
        
        a.pedirApoyoAVentas();
        
        a.idDelRetoDelContacto = [select id from FourPlanning_Reto__c limit 1].id;
        a.contactoAInsertar.Tipo_de_Contacto__c = 'Otro';
        a.contactoAInsertar.pruebaTexto__c = 'asd';
        a.contactoAInsertar.Nivel_de_Relaci_n__c = 'Fluida y Constante';
        a.contactoAInsertar.Reto__c = [select id from FourPlanning_Reto__c limit 1].id;
        a.insertarContacto();
        
        a.guardarHitos();
        
        a.guardarRetos();
        
        Task task = new Task();
        task.WhatId = cuenta.id;
        task.Subject = 'Step 1';
        insert task;
        
        Task task2 = new Task();
        task2.WhatId = cuenta.id;
        task2.Subject = 'Step 1';
        insert task2; 
        
        System.currentPagereference().getParameters().put('id',cuenta.id);
        
        for(PlanificacionPrincipalController.TaskWrapper tw :a.tasks){
            
            tw.selected = true;
        }
        
        a.MergeTasks();
        
        a.getAssignedToList();
        a.getPriorityList();
        a.getSubjectList();
        a.getTaskStatusList();
        
        a.SaveChanges();
        
        for(PlanificacionPrincipalController.TaskWrapper tw :a.tasks){
            
            tw.selected = true;
        }
        
        a.DeleteTasks();

        a.getExcelName();
        a.ExportToExcel();


        //a.conseguirOportunidadesParaGraficoDeVencimientos();
    }
}