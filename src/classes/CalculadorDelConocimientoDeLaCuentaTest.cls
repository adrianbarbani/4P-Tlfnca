@isTest
public class CalculadorDelConocimientoDeLaCuentaTest {

    static testMethod void obtengoElCoeficienteDeConocimientoDeLaCuentaEnCienPorciento(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning_Area__c area3 = new FourPlanning_Area__c();
        FourPlanning_Area__c area1 = new FourPlanning_Area__c();
        FourPlanning_Area__c area2 = new FourPlanning_Area__c();
        
        List<FourPlanning_Area__c> areas = new List<FourPlanning_Area__c> {area1, area2, area3};
        insert areas;
        
        FourPlanning_Reto__c reto1 = new FourPlanning_Reto__c();
        reto1.FourPlanning_Area__c = area3.id;
        reto1.Nombre_del_Reto__c = 'a';
        reto1.Nota__c = 'a';
        reto1.Etapa_del_Reto__c = 'Diseño';
        
        FourPlanning_Reto__c reto2  = new FourPlanning_Reto__c();
        reto2.FourPlanning_Area__c = area2.id;
        reto2.Nombre_del_Reto__c = 'a';
        reto2.Nota__c = 'a';
        reto2.Etapa_del_Reto__c = 'Diseño';
        
        FourPlanning_Reto__c reto3  = new FourPlanning_Reto__c();
        reto3.FourPlanning_Area__c = area1.id;
        reto3.Nombre_del_Reto__c = 'a';
        reto3.Nota__c = 'a';
        reto3.Etapa_del_Reto__c = 'Diseño';
        
        List<FourPlanning_Reto__c> retos = new List<FourPlanning_Reto__c> {reto1, reto2, reto3};
            insert retos;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        fourPlanning.FourPlanning_Area_3__c = area3.id;
        fourPlanning.FourPlanning_Area_2__c = area2.id;
        fourPlanning.FourPlanning_Area_1__c = area1.id;
        fourPlanning.Mayor_Nivel_de_Contacto_con_el_Cliente__c = 'C level';
        fourPlanning.Frecuencia_de_Contacto_con_el_Cliente__c = 'Periodica';
        fourPlanning.Agenda_Periodica_Ejecutiva__c = 'Si';
        fourPlanning.Agenda_Periodica_Operacional__c = 'Si';
        fourPlanning.Frecuencia_Funcionarios_del_Cliente__c = 'Semanal';
        fourPlanning.Canal_Comercializacion_cliente__c = 'On-Line';
        fourPlanning.Canal_Comercializacion_que_mas_crece__c = 'On-Line';
        fourPlanning.Area_que_fracasamos_en_el_pasado__c = 'Cualquier valor';
        fourPlanning.Mejoraria_Relacion_Con_El_Cliente__c = 'Si';
        fourPlanning.realcion_empresa_otros_clientes__c = 'Si';
        insert fourPlanning;
        
		CalculadorDelConocimientoDeLaCuenta calculador = new CalculadorDelConocimientoDeLaCuenta(fourPlanning);
		calculador.obtenerCalculoDeCoeficienteDelDesarrolloDelCliente();
        
        
    }
}