public with sharing class AccountBusinessLandscapeController {

    public Account account {get;set;}
    public Boolean canEdit {get;set;}
    public List<BusinessLandscape__c> businessLandscapeList {get;set;}
    public Id toDel {get;set;}
    public List<BusinessLandscapeWrapper> businessLandscapeWrapperList {get;set;}
    public BusinessLandscape__c newBusinesLandscape {get;set;}
    
    public AccountBusinessLandscapeController() {        
        account = [SELECT id, Name FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];    
        canEdit = true;        
        init();        
    }
    
    private void init() {
         businessLandscapeList = [select id, level__c, CurrentProvider__c, Sub_Category_Service__c, AnnualSpend__c, Country__c, ContractEndDate__c, NumberOfChannels__c, 
                                 OtherInformation__c, service__c, Category_Service__c, Decision_maker__c, Compra_a_nivel__c 
                                 from BusinessLandscape__c 
                                 where account__c = :account.id 
                                 order by createdDate];
         
        
                
        
        newBusinesLandscape = new BusinessLandscape__c(Account__c = account.id);

        Map<String, BusinessLandscapeWrapper> CategoryMap = new Map<String, BusinessLandscapeWrapper>();
        businessLandscapeWrapperList = new List<BusinessLandscapeWrapper>(); 
        
        for (BusinessLandscape__c bl :businessLandscapeList) {
            
            if (CategoryMap.get(bl.Category_Service__c) == null) {
                BusinessLandscapeWrapper nuevoCategoriaDeServicio = new BusinessLandscapeWrapper(bl);
                
                //Creo el wrapper para el servicio.
                ServiciosWrapper servicioWpp = new ServiciosWrapper(bl);
                nuevoCategoriaDeServicio.servicios.add(servicioWpp);
                
                //Pongo el wrapper de categoria de servicio en el mapa.
                CategoryMap.put(bl.Category_Service__c, nuevoCategoriaDeServicio);
                
                //Pongo el wpp contenedor de la categoria en la lista para mostrarlo.
                businessLandscapeWrapperList.add(nuevoCategoriaDeServicio);
                
            } else { 
                
                //Obtengo el wpp de la categoria.
                BusinessLandscapeWrapper CategoriaDeServicioConocida = 	CategoryMap.get(bl.Category_Service__c);
                
                //Creo el wrapper para el servicio.
                ServiciosWrapper servicioWpp = new ServiciosWrapper(bl);
                
                //Se lo agrego a la categoria que corresponda.
                CategoriaDeServicioConocida.servicios.add(servicioWpp);
            }
        }
        
    }
    
    public PageReference save() {
        upsert businessLandscapeList;
        init();
        return null;
    }
    
    public PageReference add() {
        insert newBusinesLandscape;
        init();
        return null;
    }
    
    public PageReference del() {        
        if (toDel != null) {
            delete [select id from BusinessLandscape__c where id = :toDel];
            init();
        }       
        return null;
    }
    
    public PageReference ExportToExcel() { 
        save();
        return Page.accountBusinessLandscapeExcel;
    }
    
    public PageReference siNoHayCreadoUnRegistroEnParqueDeServiciosGeneroUnoDeCadaUno(){
        
        if(businessLandscapeList.size() == 0){
            system.debug('siNoHayCreadoUnRegistroEnParqueDeServiciosGeneroUnoDeCadaUno');
        	crearUnRegistroPorCategoria();
            init();
        }
        return null;
    }
    
    public void crearUnRegistroPorCategoria(){
        
        system.debug('crearUnRegistroPorCategoria');
        
        List<String> categorias = new List<String>();
        categorias.add('IoT');
        categorias.add('Seguridad');
        categorias.add('Comunicaciones unificadas y servicios de colaboración');
        categorias.add('Cloud');
        categorias.add('Big Data');
        
        //cargo el mapa de subCategorias por cada categoria.
        Map<String, List<String>> subCategoriaDeCadaCategoria = new Map<String, List<String>>();
        
        //cargo de cada categoria su lista de subcategorias.
        List<String> categoriaIoT = new List<String>{'Conectividad IoT','Smart Mobility','Smart Cities','Smart Retail','Nuevo Negocio IoT'};
        List<String> categoriaSeguridad = new List<String>{'Almacenamiento','Seguridad Mgmt','Seguridad en Comunicaciones','Seguridad Cloud','Identidad & Privacidad'};
        List<String> categoriaComunicacion = new List<String>{'Gestión de Servicios Móviles','Unificación de Comunicaciones y Servicios de Colaboración','Servicios de Red'};
        List<String> categoriaCloud = new List<String>{'Almacenamiento','laaS & PaaS','Gestión de Servicios Cloud','SaaS','Enterprise Mobile IT'};
        List<String> categoriaBigData = new List<String>{'Smart Steps','Smart Digits'};
        
        subCategoriaDeCadaCategoria.put('IoT',categoriaIoT);
        subCategoriaDeCadaCategoria.put('Seguridad',categoriaSeguridad);
        subCategoriaDeCadaCategoria.put('Comunicaciones unificadas y servicios de colaboración',categoriaComunicacion);
        subCategoriaDeCadaCategoria.put('Cloud',categoriaCloud);
        subCategoriaDeCadaCategoria.put('Big Data',categoriaBigData);
            
        List<BusinessLandscape__c> servicios = new List<BusinessLandscape__c>();
        
        BusinessLandscape__c servicio = new BusinessLandscape__c();
        for(String categoria: categorias){
            for(String subCategoria: subCategoriaDeCadaCategoria.get(categoria)){
                servicio = new BusinessLandscape__c();
                servicio.Category_Service__c = categoria;
                servicio.Service__c = subCategoria;
                servicio.Account__c = account.id;
                servicios.add(servicio);
            }
        }
		
        system.debug(servicios);
        insert servicios;
        
    }
    
    public String getExcelName() {
        String name = account.Name + '-' + Label.Account_Business_Landscape +'.xls';
        return name.replaceAll(' ', '_');
    }    

    class BusinessLandscapeWrapper {
        
        public BusinessLandscape__c bl {get;set;}
        public List<serviciosWrapper> servicios {get;set;}        
        
        public BusinessLandscapeWrapper(BusinessLandscape__c n) {
            bl = n;
            servicios = new List<serviciosWrapper>();
        }
    }
    
    class serviciosWrapper {
        
        public BusinessLandscape__c servicio {get; set;}
        
        public serviciosWrapper(BusinessLandscape__c unServicio){
            servicio = unServicio;
        }
    }
}