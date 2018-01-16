public class GraficosCarteraController {
    
    public List<wrapperMap> cuentasConSusEstados{get;set;}
    public List<familiasYRamas> todosLosServiciosDisponibles{get;set;}
    public Integer numeroDePagina {get;set;}
    public Integer PaginasTotales {get;set;}

    public transient String filtroDeNombre {get; set;}
    
    public GraficosCarteraController(){
        
        todosLosServiciosDisponibles = new List<familiasYRamas>();
        cuentasConSusEstados = new List<wrapperMap>();
        
        numeroDePagina = 1;
        filtroDeNombre = '';
        
        Set<Id> usuariosDebajoDeLaJerarquia = obtenerUsuariosDebajoDeMiJerarquia();
        
        List<Account> cuentasTotales = [SELECT id, name 
                                        FROM Account 
                                        where OwnerId IN: usuariosDebajoDeLaJerarquia AND 
                                        ID IN (select cuenta__c from SolucionEnCuenta__c)
                                        ORDER BY Name ASC
                                        LIMIT 10 ];
        
        List<SolucionEnCuenta__c> solucionesEnCuenta = [select id, TipoSolucion__r.Linea_de_Servicio__r.Name, TipoSolucion__r.Name, cuenta__c, Estado__c, cuenta__r.name 
                                                        from SolucionEnCuenta__c where cuenta__c in: cuentasTotales];
        
        
        
        obtenerWppers(solucionesEnCuenta);
        
        //Obtener paginas totales
		obtenerTotalDeNumeroDePaginas();
    }
    
    public void filtrar(){
        obtenerPrimerPagina();
        actualizarPagina(obtenerCuentasConFiltroNombre());
        
        if(String.isBlank(filtroDeNombre)){
            obtenerTotalDeNumeroDePaginas();
        }else{
        	PaginasTotales = 1;	    
        }
        
    }
    
    public Set<Id> obtenerUsuariosDebajoDeMiJerarquia(){
        
        Id miId = UserInfo.getUserId();
        
        User miUsuario = [select id, name, Email, UserRoleId from user where id =: miId];
        
        Set<Id> usuariosDebajoDeLaJerarquia = new Set<Id>();
        if(miUsuario.userRoleId != null){
            usuariosDebajoDeLaJerarquia.addAll(Util.getRoleSubordinateUsers(miUsuario.UserRoleId));
        }
        
        //Si no hay usuarios debajo, el set vuelve vacio.
        usuariosDebajoDeLaJerarquia.add(miId);
        
        return usuariosDebajoDeLaJerarquia;
    }
    
    public void obtenerWppers(List<SolucionEnCuenta__c> solucionesEnCuenta){
        
        map<Id,wrapperMap> cuentasWpp = new map<id, wrapperMap>();
        map<String,familiasYRamas> familiasYRamasWpp = new map<String, familiasYRamas>();
        
        Set<String> todasLasRamas = new Set<String>();
        for(SolucionEnCuenta__c sol:solucionesEnCuenta){
            
            system.debug(sol.TipoSolucion__r.Linea_de_Servicio__r.Name);
            
            wrapperMap wpp = new wrapperMap();
            
            if(cuentasWpp.get(sol.cuenta__c) == null){
                wpp.cuenta = sol.cuenta__r.name;
                wpp.solucionesyEstados.put(sol.TipoSolucion__r.Name,sol.Estado__c);
                cuentasWpp.put(sol.cuenta__c, wpp);
            }else{
                wpp = cuentasWpp.get(sol.cuenta__c);
                wpp.solucionesyEstados.put(sol.TipoSolucion__r.Name,sol.Estado__c);
            }
            
            todasLasRamas.add(sol.TipoSolucion__r.Name);
            
            familiasYRamas familiawpp = new familiasYRamas();
            
            if(familiasYRamasWpp.get(sol.TipoSolucion__r.Linea_de_Servicio__r.Name) == null){
                familiawpp.familias = sol.TipoSolucion__r.Linea_de_Servicio__r.Name;
                familiawpp.ramas.add(sol.TipoSolucion__r.Name);
                familiasYRamasWpp.put(sol.TipoSolucion__r.Linea_de_Servicio__r.Name, familiawpp);
            }else{
                familiawpp = familiasYRamasWpp.get(sol.TipoSolucion__r.Linea_de_Servicio__r.Name);
                familiawpp.ramas.add(sol.TipoSolucion__r.Name);
            }
        }
        
        system.debug(todasLasRamas);
        system.debug(cuentasWpp.values());
        //Recorro todos los mapas y si les falta algun valor lo agrego como un string vacio, por que cuando pido un campo en el map de la visualforce, si no esta, no tira null, si no que explota (feo lo se).
        for(wrapperMap cuentawpp:cuentasWpp.values()){
            for(String rama: todasLasRamas){
                if(cuentawpp.solucionesyEstados.get(rama) == null){
                    cuentawpp.solucionesyEstados.put(rama, 'No Presentado');
                }
            }
        }
        
        system.debug(cuentasWpp.values());
        
        todosLosServiciosDisponibles = familiasYRamasWpp.values();
        cuentasConSusEstados = cuentasWpp.values();
        
        system.debug(todosLosServiciosDisponibles);
        system.debug(cuentasConSusEstados);
    }
    
    Public PageReference irAlTab(){
        String url = Page.Tab4Planning.getURL();
        return new PageReference (url);   
    }
    
    public void obtenerPrimerPagina(){
        numeroDePagina = 1;
        actualizarPagina(obtenerCuentasSinFiltro());
    }
    
    public void obtenerUltimaPagina(){
        numeroDePagina = paginasTotales;
        actualizarPagina(obtenerCuentasSinFiltro());
    }
    
    public void obtenerSiguiente(){
        numeroDePagina += 1; 
        actualizarPagina(obtenerCuentasSinFiltro());
    }
    
    public void obtenerAnterior(){
        if(numeroDePagina>1){
            numeroDePagina = numeroDePagina-1;
        }
        actualizarPagina(obtenerCuentasSinFiltro());
    }
    
    public void actualizarPagina(List<Account> cuentasTotales){
        
        List<SolucionEnCuenta__c> solucionesEnCuenta = [select id, TipoSolucion__r.Linea_de_Servicio__r.Name, TipoSolucion__r.Name, cuenta__c, Estado__c, cuenta__r.name 
                                                        from SolucionEnCuenta__c where cuenta__c in: cuentasTotales];
        
        
        
        obtenerWppers(solucionesEnCuenta);
    }
    
    public list<Account> obtenerCuentasSinFiltro(){
        Set<Id> usuariosDebajoDeLaJerarquia = obtenerUsuariosDebajoDeMiJerarquia();
        
        Integer cantidadDeOffset = numeroDePagina*10-10;
        
        List<Account> cuentasTotales = [SELECT id, name 
                                        FROM Account 
                                        where OwnerId IN: usuariosDebajoDeLaJerarquia AND 
                                        ID IN (select cuenta__c from SolucionEnCuenta__c)
                                        ORDER BY Name ASC
                                        LIMIT 10 
                                        OFFSET :cantidadDeOffset];
        
        return cuentasTotales;
    }
    
    public List<account> obtenerCuentasConFiltroNombre(){
        
        if(String.isBlank(filtroDeNombre)){
            return obtenerCuentasSinFiltro();
        }
        
        Set<Id> usuariosDebajoDeLaJerarquia = obtenerUsuariosDebajoDeMiJerarquia();
        
        Integer cantidadDeOffset = numeroDePagina*10-10;
        
        String nombreABuscar = '%'+filtroDeNombre+'%';
        List<Account> cuentasTotales = [SELECT id, name 
                                        FROM Account 
                                        where OwnerId IN: usuariosDebajoDeLaJerarquia AND 
                                        ID IN (select cuenta__c from SolucionEnCuenta__c)
                                        AND name like: nombreABuscar
                                        ORDER BY Name ASC
                                        LIMIT 10 
                                        OFFSET :cantidadDeOffset];
        return cuentasTotales;
    }
    
    public void obtenerTotalDeNumeroDePaginas(){
        
        Set<Id> usuariosDebajoDeLaJerarquia = obtenerUsuariosDebajoDeMiJerarquia();
        
        Integer CatidadDeCuentas = [SELECT COUNT() 
                                    FROM Account 
                                    where OwnerId IN: usuariosDebajoDeLaJerarquia AND 
                                    ID IN (select cuenta__c from SolucionEnCuenta__c)
                                    Limit 2000];
        
        paginasTotales = CatidadDeCuentas/10;
        
        if(math.mod(CatidadDeCuentas, 10)>0){
            paginasTotales += 1;
        }
    }
    //=======================================================================    
    public class wrapperMap {
        
        public String cuenta{get;set;}
        public map<String,String> solucionesyEstados {get;set;}
        
        public wrapperMap(){
            solucionesyEstados = new Map<String,String>();
        }
    }
    
    public class familiasYRamas {
        
        public String familias{get;set;}
        public Set<String> ramas{get;set;}
        
        
        public familiasYRamas(){
            ramas = new Set<String>();
        }
        
        public Integer getSizeRamas(){
            return ramas.size();
        }
    }    
}