public class CalculadorDelConocimientoDeLaCuenta {
    
    public map<String, Double> respuestasYValores {get; set;}
    public Double conocimientoDeLaCuenta {get; set;}
    
    public Static Double MAXIMO_VALOR_POSIBLE = 107;
    
    public FourPlanning__c fourPlanning {get; set;}
    
    public CalculadorDelConocimientoDeLaCuenta(FourPlanning__c unFourPlanning){
        
        fourPlanning = unFourPlanning;
        
    }
    
    
    public void obtenerCalculoDeCoeficienteDelDesarrolloDelCliente(){
        
        
        respuestasYValores = new map<String,Double>();
        
        Double sumatoriaDeValoresDeLaCuenta = 0; 
        
        //¿Cuáles son los ingresos anuales del cliente?
        if(fourPlanning.Facturacion__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //Si conoces el número exacto, indica cantidad de empleados
        if(fourPlanning.Cantidad_de_empleados_exacto__c != null){
            sumatoriaDeValoresDeLaCuenta += 2;
        }
        //Cantidad de edificios centrales y/o administrativos
        if(fourPlanning.Cantidad_de_sedes_exactas__c != null){
            sumatoriaDeValoresDeLaCuenta += 2;
        }
        //Indica la cantidad de sucursales
        if(fourPlanning.Cantidad_de_sucursales__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //¿El número de sucursales, crece, decrece o se mantiene?
        if(fourPlanning.Como_se_mantiene_el_numero_de_sucursales__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //¿El cliente dispone de parque automotor?
        if(fourPlanning.Dispone_de_parque_automotor__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }	
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //¿Cuáles son los principales desafíos e iniciativas estratégicas del cliente?
        
        sumatoriaDeValoresDeLaCuenta += valorDeIniciativasEstrategicasDelCliente();
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //Indica cuáles son las principales empresas con las que compite tu cliente
        
        if(fourPlanning.Competidor_Principal_1__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        if(fourPlanning.Competidor_Principal_2__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }	
        if(fourPlanning.Competidor_Principal_3__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        
        //Indica cuales son los canales utilizados por el cliente para comercializar sus productos o servicios (Indique por orden de importancia)
        if(fourPlanning.Canal_de_comercializaci_n_multiple__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //¿Cuál es el canal de comercialización que más esta creciendo? (Indique por orden de importancia)
        if(fourPlanning.comercializacion_que_mas_crece_multiple__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //¿Con qué frecuencia nos reunimos con el cliente?
        sumatoriaDeValoresDeLaCuenta += valorGradualReunirseConElCliente(); //aca
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //¿Cuál es nuestro mayor nivel de contacto con el cliente?
        sumatoriaDeValoresDeLaCuenta += valorGradualMayorNivelDeContacto();
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //¿Tenemos agenda periódica ejecutiva con participación de nivel directivo de ambas organizaciones?
        if(fourPlanning.Agenda_Periodica_Ejecutiva__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //¿Tenemos agenda periódica operacional sobre la calidad de los servicios prestados?
        if(fourPlanning.Agenda_Periodica_Operacional__c != null){
            sumatoriaDeValoresDeLaCuenta += 10;
        }	
        
        //Selecciona los 3 contactos en el cliente con los que tiene mayor afinidad
        if(fourPlanning.Contacto_con_mayor_afinidad_1__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        if(fourPlanning.Contacto_con_mayor_afinidad_2__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        if(fourPlanning.Contacto_con_mayor_afinidad_3__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        
        //¿Conoces lo que Telefónica hace en otros países con clientes semejantes al tuyo?
        if(fourPlanning.realcion_empresa_otros_clientes__c != null){
            sumatoriaDeValoresDeLaCuenta += 2;
        }
        
        //1 Operativa - 5 Comercial
        if(fourPlanning.Agenda_de_Trabajo_1__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //1 Tradicional - 5 Digital
        if(fourPlanning.Agenda_de_Trabajo_2__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //1 Renegociación - 5 Desarrollo
        if(fourPlanning.Agenda_de_Trabajo_3__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //1 Conflictiva - 5 Constructiva
        if(fourPlanning.Agenda_de_Trabajo_4__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //Areas
        sumatoriaDeValoresDeLaCuenta += valorPorAreas();
        
        //¿Estamos en el Top 5 de proveedores de nuestro cliente?
        if(fourPlanning.Top_5_de_proveedores__c != null){
            sumatoriaDeValoresDeLaCuenta += 4;
        }
        //¿Tenemos un buen vínculo entre la alta dirección de Telefónica y la alta dirección del cliente?
        if(fourPlanning.vinculo_direccion_tecnologia__c != null){
            sumatoriaDeValoresDeLaCuenta += 4;
        }
        //¿Quién prospecta la venta de tecnología en tu cliente?
        if(fourPlanning.prospecta_venta_tecnologia_cliente__c != null){
            sumatoriaDeValoresDeLaCuenta += 4;
        }
        //¿Estás en el futuro de tu cliente?
        if(fourPlanning.esta_en_el_futuro_del_cliente__c != null){
            sumatoriaDeValoresDeLaCuenta += 4;
        }
        //Los planes estratégicos de tu cliente….
        if(fourPlanning.lanes_estrat_gicos_de_tu_cliente__c != null){
            sumatoriaDeValoresDeLaCuenta += 4;
        }
        
        //Fecha de Vencimiento de contratos de datos fijos
        if(fourPlanning.Vencimiento_Datos_Fijos__c != null){
            sumatoriaDeValoresDeLaCuenta += 2;
        }
        //Fecha de vencimiento de contrato de servicios móviles
        if(fourPlanning.Vencimiento_Servicios_Moviles__c != null){
            sumatoriaDeValoresDeLaCuenta += 2;
        }
        //Fecha de vencimiento de contratos de otros servicios
        if(fourPlanning.Vencimiento_Otros_Servicios__c != null){
            sumatoriaDeValoresDeLaCuenta += 2;
        }
        //¿A qué evento de Telefónica vas a invitar al cliente?
        if(fourPlanning.Evento_telefonica_cliente__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        //Fecha del Evento
        if(fourPlanning.Fecha_Evento__c != null){
            sumatoriaDeValoresDeLaCuenta += 1;
        }
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        //Otros Hitos
        sumatoriaDeValoresDeLaCuenta += valorSumatoriaOtrosHitos();
        system.debug(sumatoriaDeValoresDeLaCuenta);
        
        system.debug(sumatoriaDeValoresDeLaCuenta);
        
        Decimal myDecimal = ((sumatoriaDeValoresDeLaCuenta*100)/MAXIMO_VALOR_POSIBLE);
        conocimientoDeLaCuenta = myDecimal.setScale(2);
    }
    
    public Double valorDeIniciativasEstrategicasDelCliente(){
        
        Double valor = 0;
        
        List<Strategic_Initiative__c> iniciativasDelNegocioDelCliente = [SELECT id
                                                                         FROM Strategic_Initiative__c 
                                                                         WHERE Account__C = : fourPlanning.Cuenta__c limit 3];
        
        valor = iniciativasDelNegocioDelCliente.size() * 5;
        
        return valor;
    }
    
    public Double valorGradualReunirseConElCliente(){
        
        respuestasYValores = new map<String,Double>();
        
        Double valor = 0;
        
        respuestasYValores.put('Ocasional', 1);
        respuestasYValores.put('Mensual', 2);
        respuestasYValores.put('Quincenal', 3);
        respuestasYValores.put('Semanal', 4);
        respuestasYValores.put('Diaria', 5);
        
        if(fourPlanning.Frecuencia_de_Contacto_con_el_Cliente__c != null){
            valor = respuestasYValores.get(fourPlanning.Frecuencia_de_Contacto_con_el_Cliente__c);
        }
        if(valor == null){
            valor = 0;
        }
        
        return valor;
    }
    
    public Double valorGradualMayorNivelDeContacto(){
        
        respuestasYValores = new map<String,Double>();
        
        Double valor = 0;
        
        respuestasYValores.put('Sin Contacto', 0);
        respuestasYValores.put('Usuarios', 1);
        respuestasYValores.put('Analista', 2);
        respuestasYValores.put('Jefe', 3);
        respuestasYValores.put('Gerente', 4);
        respuestasYValores.put('Director', 5);
        respuestasYValores.put('C level', 6);
        
        if(fourPlanning.Mayor_Nivel_de_Contacto_con_el_Cliente__c != null){
            valor = respuestasYValores.get(fourPlanning.Mayor_Nivel_de_Contacto_con_el_Cliente__c);
        }
        if(valor == null){
            valor = 0;
        }
        
        return valor;
    }
    
    public Double valorSumatoriaOtrosHitos(){
        
        Double valor = 0;
        
        List<FourPlanning_Hito__c> hitos = [SELECT ID 
                                            FROM FourPlanning_Hito__c
                                            WHERE FourPlanning__c =: fourPlanning.id 
                                            Limit 1];
        valor = hitos.size();
        
        return valor;
    }
    
    public Double valorPorAreas(){
        Double valor = 0;
        
        List<FourPlanning_Area__c> todasLasAreas = [select id from FourPlanning_Area__c where FourPlanning__c =: fourPlanning.Id limit 5];
        
        if(todasLasAreas.size()>0){
            valor += todasLasAreas.size() + 3;
        }
        
        List<Id> idArea = new List<Id>();
        for(FourPlanning_Area__c area: todasLasAreas){
            idArea.add(area.id);
        }
        
        List<FourPlanning_Reto__c> retosAConseguir = [SELECT ID, FourPlanning_Area__c,
                                                      (select id from FourPlanning_Soluciones__r limit 1),
                                                      (select id from FourPlanning_Contactos__r limit 1)
                                                      FROM FourPlanning_Reto__c 
                                                      WHERE FourPlanning_Area__c =: idArea];
        
        Integer SolucionesTotales = 0;
        Integer contactosTotales = 0;
        for(Id area: IdArea){
            
            Integer soluciones = 0;
            Integer contactos = 0;
            
            for(FourPlanning_Reto__c reto: retosAConseguir){
                if(reto.FourPlanning_Area__c == area){
                    soluciones += reto.FourPlanning_Soluciones__r.size();
                    contactos += reto.FourPlanning_Contactos__r.size();
                }
            }
            
            if(soluciones>0){
                solucionesTotales += 1;
            }
            if(contactos>0){
                contactosTotales += 1;
            }
        }
        
        if(solucionesTotales>0){
            valor += solucionesTotales+1;
        }
        
        valor += contactosTotales;
        
        return valor;
    }
}