public class administracionBackShopController {

    public List<Evento_BackShop__c> eventosBackShop {get; set;}
    
    public Evento_BackShop__c eventoAInsertar {get; set;}
    
    public String idABorrar {get; set;}
    
    public List<cuentaWrapper> cuentasWpp {get;set;}
    
    public String CuentaABorrarNombre {get;set;}
    
    public administracionBackShopController(){
        
        eventoAInsertar = new Evento_BackShop__c();
        cuentasWpp = new List<cuentaWrapper>();
        
        obtenerEventos();
        
    }
    
    public void obtenerEventos(){
        eventosBackShop = [select id, name, Descripcion__c, Link__c, Pais__c, 
                           Sector__c, Sub_sector__c, Region__c, Cantidad_de_edificios__c, cantidad_de_empleados__c, cuantos_veh_culos_dispone_el_parque__c,
                           Indica_la_cantidad_de_sucursales__c, Ingresos_anuales_del_cliente__c, ispone_de_parque_automotor__c, Cantidad_de_edificios_condicion__c,
                           cantidad_de_empleados_condicion__c, cuantos_veh_culos_dispone_el_parque_cond__c, Indica_la_cantidad_de_sucursales_cond__c, Ingresos_anuales_del_cliente_condicion__c, FiltroCuenta__c
                           from Evento_BackShop__c];
    }
    
    public PageReference InsertarEvento(){
        
        if(eventoAInsertar.name != null && cuentasWpp.size() == 0){
            
            eventoAInsertar.FiltroCuenta__c = null;
            insert eventoAInsertar;
        	eventoAInsertar = new Evento_BackShop__c();
            obtenerEventos();
        }
        
        List<Evento_BackShop__c> lista = new List<Evento_BackShop__c>();
        
        if(eventoAInsertar.name != null && cuentasWpp.size() > 0){
            
            if(eventoAInsertar.sector__c != null || 
            eventoAInsertar.Sub_sector__c != null || 
            eventoAInsertar.Region__c != null || 
            eventoAInsertar.Ingresos_anuales_del_cliente__c != null || 
            eventoAInsertar.cantidad_de_empleados__c != null || 
            eventoAInsertar.Cantidad_de_edificios__c != null || 
            eventoAInsertar.Indica_la_cantidad_de_sucursales__c != null || 
            eventoAInsertar.ispone_de_parque_automotor__c != null || 
            eventoAInsertar.cuantos_veh_culos_dispone_el_parque__c != null
            ){
                Evento_BackShop__c evento = new Evento_BackShop__c();
                evento.name = eventoAInsertar.name;
                evento.sector__c = eventoAInsertar.sector__c;
                evento.Sub_sector__c = eventoAInsertar.Sub_sector__c;
                evento.Region__c = eventoAInsertar.Region__c;
                evento.Ingresos_anuales_del_cliente_condicion__c = eventoAInsertar.Ingresos_anuales_del_cliente_condicion__c;
                evento.Ingresos_anuales_del_cliente__c = eventoAInsertar.Ingresos_anuales_del_cliente__c;
                evento.cantidad_de_empleados_condicion__c = eventoAInsertar.cantidad_de_empleados_condicion__c;
                evento.cantidad_de_empleados__c = eventoAInsertar.cantidad_de_empleados__c;
                evento.Cantidad_de_edificios_condicion__c = eventoAInsertar.Cantidad_de_edificios_condicion__c;
                evento.Cantidad_de_edificios__c = eventoAInsertar.Cantidad_de_edificios__c;
                evento.Indica_la_cantidad_de_sucursales_cond__c = eventoAInsertar.Indica_la_cantidad_de_sucursales_cond__c;
                evento.Indica_la_cantidad_de_sucursales__c = eventoAInsertar.Indica_la_cantidad_de_sucursales__c;
                evento.ispone_de_parque_automotor__c = eventoAInsertar.ispone_de_parque_automotor__c;
                evento.cuantos_veh_culos_dispone_el_parque_cond__c = eventoAInsertar.cuantos_veh_culos_dispone_el_parque_cond__c;
                evento.cuantos_veh_culos_dispone_el_parque__c = eventoAInsertar.cuantos_veh_culos_dispone_el_parque__c;
                evento.Descripcion__c = eventoAInsertar.Descripcion__c;
                evento.Link__c = eventoAInsertar.Link__c;
                lista.add(evento);
                
            }
            
            
            for (cuentaWrapper cuentas : cuentasWpp){
                Evento_BackShop__c evento = new Evento_BackShop__c();
                
                evento.name = eventoAInsertar.name;
                evento.Descripcion__c = eventoAInsertar.Descripcion__c;
                evento.Link__c = eventoAInsertar.Link__c;
                evento.FiltroCuenta__c = cuentas.cuenta;
                
               lista.add(evento);
                
            }
            
            
            
            insert lista;
            eventoAInsertar = new Evento_BackShop__c();
            cuentasWpp = new List<cuentaWrapper>();
            obtenerEventos();
        }
        
        
        return null;
    }
    
    public void renderizarPagina(){
        //lo utilizo para renderizar la pagina al comienzo para que no se genere el #text entre el titulo y el contenido del pageblock section. twisty    
    }
    
    public PageReference borrarEvento(){
        
        Integer i = 0;
        
        for(Evento_BackShop__c evento : eventosBackShop){
            
            if(evento.id == idABorrar){
                break;
            }
            else{
                i++;
            }   
        }
        
        if(eventosBackShop[i].id != null){            
            delete eventosBackShop[i];    
        }
        
        eventosBackShop.remove(i);        
         
        return null;
    }
    
    
    public void agregoCuenta(){
        
        if(eventoAInsertar.FiltroCuenta__c != null){
            Account cuenta = new Account();
            
            cuenta = [SELECT id, name FROM Account WHERE id =: eventoAInsertar.FiltroCuenta__c];
            
            cuentaWrapper cuentaWpp = new cuentaWrapper(cuenta);
            cuentasWpp.add(cuentaWpp);
            
          
            
        }
    }
    
    public void borrarCuentaDeLista(){
        
        system.debug(CuentaABorrarNombre);
        
        Set<cuentaWrapper> cuentasSet = new Set<cuentaWrapper>(cuentasWpp);

        system.debug(cuentasSet);
        
        for(cuentaWrapper cuenta : cuentasSet ){
            if (cuenta.nombre == CuentaABorrarNombre){
                cuentasSet.remove(cuenta);
            }
        }
        
        cuentasWpp = new List<cuentaWrapper>(cuentasSet);
        
        system.debug(cuentasWpp);
        
    }
    
    
    public class cuentaWrapper{
        
        public Id cuenta {get; set;}
        public String nombre {get; set;}
        
        public cuentaWrapper(Account unaCuenta){
            cuenta = unaCuenta.id;
            nombre = unaCuenta.name;
        }
    }
}