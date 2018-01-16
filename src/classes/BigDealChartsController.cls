public with sharing class BigDealChartsController {
    
    public static string Red {
        get {
            return '#fe0000';
        }
    }
    public static string Green {
        get {
            return '#009865';
        }
    }
    public static string Yellow {
        get {
            return '#ffff01';
        }
    }
    public static string Black {
        get {
            return '#000000';
        }
    }
    
    public boolean CanEdit {get; private set;}
    public Boolean isBigDealAdmin {get; set;}
    public Boolean isBlocked {get; set;}
    public boolean SurveyIsComplete {get; private set;}
    private boolean readResources;    
    public boolean checkAprobarGoEstrategico {get; set;}
    
    public Opportunity BigDealOpportunity {
        get;        
        set {
            string tempDetail;
            boolean loadedDetail = false;
            if(BigDealSurvey != null && BigDealSurvey.Id != null && BigDealOpportunity != null && BigDealOpportunity.Id == value.Id) {
                tempDetail = BigDealSurvey.Detalles_adicionales__c;                
                loadedDetail = true;    
            }
            

            BigDealOpportunity = [SELECT Id, Description, BigDeals__c, AccountId FROM Opportunity WHERE Id = :value.Id][0];

            
            if (!BigDealOpportunity.BigDeals__c) {
                return;
            }
            
             List<Big_deals_Survey__c> existingSurveys = new  List<Big_deals_Survey__c>();
            

            existingSurveys = [
                SELECT ID,
                	Aprobar_Go_Estrategico__c, Full_contract_value__c, NAV_o_ingresos_proximos_12_meses__c, Capex_total__c,
                	
                	fecha_de_entrega__c, Fecha_comienzo_de_contrato__c, NAV_12_meses_naturales__c,
                	
                	Lineas_implicadas__c, Valoracion_de_relacion_de_entregables__c,
                	
                	Valoracion_de_arquitectura_tecnica__c, Alcance_de_la_colaboracion_con_terceros__c,
                	
                	Cantidad_de_personas_a_incorporar__c, FTE_que_se_aportaran__c,
                	
                	FTE_terceros_requeridos__c, Actividades_durante_preventa__c, Duracion_estimada_Preventa__c,
                	
                	Grado_de_conocimiento_del_cliente__c, Interrelacion_con_principales_decisores__c, Impacto_en_el_cliente__c,
                	
                	Grado_exigencia_SLA__c, Capacidad_para_cumplir_los_SLA__c,
                	
                	Grado_certeza_continuidad_plataforma__c, Valoracion_de_detalle_de_SLA__c,Importe_fianzas_depositar__c,
                	
                	porcentaje_penalizacion_incumplimiento__c, porcentage_indemnizacion_total_importe__c, Porcentaje_pasivo_laboral_importe__c, 
                
                	Fecha_estimada_del_fallo__c, Detalles_adicionales__c,  Oportunidad__r.name, oportunidad__r.Description, oportunidad__r.AccountId,
                	
                	Pais__c, State__c, LastModifiedDate, SLA_definidos__c, Codigo_en_Sales_Force_del_proyecto__c,
                
                	
                	Alcance_del_proyecto_desplegable__c, Descripci_n_tecnica_desplegable__c, ofertas_terceros_desplegable__c,
                	incorporar_personas_desplegable__c, Informacion_formalizada_suficiente_despl__c, Condiciones_previas_para_licitar_despleg__c,
                    Estabilidad_financiera_cliente_desple__c, Existe_indemnizaci_n_por_rescisi_n__c, Productos_clave_estan_en_porfolio_desple__c,
                	Estan_perfiles_clave_necesarios_desple__c, Personal_clave_del_cliente_desple__c, Partners_necesarios_identificados_desple__c,
                	Situacion_con_partners_favorable_desple__c, Tienen_SLAs_los_servicios_que_portan__c, Hay_SLAs_definidos__c
                	
                FROM Big_deals_Survey__c
                WHERE Oportunidad__c = :BigDealOpportunity.Id
            ];
            if(existingSurveys.size() == 0) {
                return;
            }
            BigDealSurvey = existingSurveys[0];
            system.debug(BigDealSurvey.Aprobar_Go_Estrategico__c);
            checkAprobarGoEstrategico = BigDealSurvey.Aprobar_Go_Estrategico__c;
            if(!isSurveyComplete()) {
                SurveyIsComplete = false;
                return;
            }
            SurveyIsComplete = true;
            
            List<Limite_de_Big_deal_por_pais__c> bigDealLimits = new List<Limite_de_Big_deal_por_pais__c>();
            
            bigDealLimits = [SELECT FCV__c, CAPEX__c, NAV__c FROM Limite_de_Big_deal_por_pais__c WHERE Name = :BigDealSurvey.Pais__c];
            
            
            if(bigDealLimits.size() != 0) {
                BigDealLimit = bigDealLimits[0];
            }
            //-----------------------------------------------------------------
            EconomicalInfoData = new EconomicalInformationScore();
            loadFCV(BigDealSurvey.Full_contract_value__c);
            loadIncomeForNext12Months(BigDealSurvey.NAV_o_ingresos_proximos_12_meses__c);
            loadNaturalYearNAV(BigDealSurvey.NAV_12_meses_naturales__c);
            loadTotalCapex(BigDealSurvey.Capex_total__c);
            //-----------------------------------------------------------------
            ScheduleData = new ScheduleScore();
            Date compareDate = Date.newInstance(BigDealSurvey.lastModifiedDate.year(), BigDealSurvey.lastModifiedDate.month(), BigDealSurvey.lastModifiedDate.day());
            loadOfferTurnInDate(BigDealSurvey.fecha_de_entrega__c,compareDate);
            loadContractStartDate(BigDealSurvey.Fecha_comienzo_de_contrato__c, BigDealSurvey.Fecha_estimada_del_fallo__c);
            //-----------------------------------------------------------------
            ReachData = new ReachScore();
            loadAffectedLines(BigDealSurvey.Lineas_implicadas__c);
            loadDeliberablesDescription(BigDealSurvey.Alcance_del_proyecto_desplegable__c, BigDealSurvey.Valoracion_de_relacion_de_entregables__c);
            loadTechnicalArchitectureDescription(BigDealSurvey.Descripci_n_tecnica_desplegable__c, BigDealSurvey.Valoracion_de_arquitectura_tecnica__c);
            loadReachOfThirdPartyInvolvement(BigDealSurvey.ofertas_terceros_desplegable__c, BigDealSurvey.Alcance_de_la_colaboracion_con_terceros__c);
            loadAmountOfResourcesToIncorporate(BigDealSurvey.incorporar_personas_desplegable__c, BigDealSurvey.Cantidad_de_personas_a_incorporar__c);
            //-----------------------------------------------------------------
            PresaleAndOfferData = new PresaleAndOfferScore();
            loadAmountOfContributedFTE(BigDealSurvey.FTE_que_se_aportaran__c);
            loadAmountOfThirdPartyFTERequired(BigDealSurvey.FTE_terceros_requeridos__c);
            loadActivitiesDuringPresale(BigDealSurvey.Actividades_durante_preventa__c);
            loadEstimatedPresaleAndOfferDuration(BigDealSurvey.Duracion_estimada_Preventa__c);
            //-----------------------------------------------------------------
			RisksData = new RisksScore();
            loadClientsRisks(BigDealSurvey.Grado_de_conocimiento_del_cliente__c, BigDealSurvey.Interrelacion_con_principales_decisores__c, BigDealSurvey.Impacto_en_el_cliente__c);
            loadTechnicalSolutionRisks(BigDealSurvey.Informacion_formalizada_suficiente_despl__c, BigDealSurvey.Grado_exigencia_SLA__c, 
                                       BigDealSurvey.Capacidad_para_cumplir_los_SLA__c, BigDealSurvey.Grado_certeza_continuidad_plataforma__c,
                                       BigDealSurvey.Hay_SLAs_definidos__c, BigDealSurvey.Valoracion_de_detalle_de_SLA__c);
            loadProjectRisks(BigDealSurvey.Importe_fianzas_depositar__c, BigDealSurvey.Condiciones_previas_para_licitar_despleg__c);
            loadFinancialRisks(BigDealSurvey.Estabilidad_financiera_cliente_desple__c, 
                                BigDealSurvey.porcentaje_penalizacion_incumplimiento__c, BigDealSurvey.Existe_indemnizaci_n_por_rescisi_n__c,
                                BigDealSurvey.porcentage_indemnizacion_total_importe__c, BigDealSurvey.Porcentaje_pasivo_laboral_importe__c);
            loadOrganizationRisks(BigDealSurvey.Productos_clave_estan_en_porfolio_desple__c, BigDealSurvey.Estan_perfiles_clave_necesarios_desple__c, BigDealSurvey.Personal_clave_del_cliente_desple__c);
            loadThirdPartyRisks(BigDealSurvey.Partners_necesarios_identificados_desple__c, BigDealSurvey.Situacion_con_partners_favorable_desple__c, BigDealSurvey.Tienen_SLAs_los_servicios_que_portan__c);
                                   
            if(loadedDetail) {
            	BigDealSurvey.Detalles_adicionales__c = tempDetail;                
            }
            
            List<UserRecordAccess> recordAccessList = new List<UserRecordAccess>();
            

            recordAccessList = [SELECT RecordId, HasReadAccess, HasEditAccess, MaxAccessLevel FROM UserRecordAccess 
                                                   WHERE UserId=:UserInfo.getUserId() AND RecordId = :BigDealOpportunity.Id];
            if(recordAccessList.size() > 0) {
                UserRecordAccess ura = recordAccessList[0];
                //userActions temp = new userActions();
                CanEdit = ura.HasEditAccess;//temp.checkWrite(BigDealOpportunity.accountId);
            }
            else {
                CanEdit = false;
            }

            isBigDealAdmin = false;
            
            List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
            

            psaList = [SELECT PermissionSetId, PermissionSet.Name FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId() AND PermissionSet.Name = 'Big_Deal_Admin'];
            if (psaList.size() > 0) {
                isBigDealAdmin = true;
            }

            if (BigDealSurvey.state__c == 'Bloqueado') {
                isBlocked = true;             
            } else {
                isBlocked = false;
            }            

            readResources();        

        }
    }    
    
    private void readResources() {

        if (readResources) {

            bigDealResources = [select id, Resource__r.puede_acceder_a_una_solicitud_capex__c, Resource__r.Name, Resource__r.Category__r.Name, Text__c from Big_Deal_Resource__c where Survey__c = :BigDealSurvey.id];
            
            List<Id> bigDealResourcesIds = new List<Id>();
            for (Big_Deal_Resource__c br :bigDealResources) {
                bigDealResourcesIds.add(br.Resource__c);
            }
            

            resources = [select id, Name, Category__r.Name, Selected__c from Resource__c where id not in :bigDealResourcesIds Order by Category__r.Name];
            
            readResources = false;
        }
    }

    public double TotalScore {
        get {
            return EconomicalInfoData.Score + ScheduleData.Score + ReachData.Score + 
                PresaleAndOfferData.Score + RisksData.Score;
        }
    }
    
    public string Color {
        get {
            if(EconomicalInfoData.Color == Black || ScheduleData.Color == Black ||
                ReachData.Color == Black || PresaleAndOfferData.Color == Black ||
            	RisksData.Color == Black) {
            	return Black;
            }
            return getColorForPercentage(TotalScore);
        }
    }
    //==================================================================================
    //Sections
    //==================================================================================
    public ScheduleScore ScheduleData {get; set;}
    public EconomicalInformationScore EconomicalInfoData {get; set;}
    public ReachScore ReachData {get; set;}
    public PresaleAndOfferScore PresaleAndOfferData {get; set;}
    public RisksScore RisksData {get; set;}    
    //==================================================================================
    public Big_deals_Survey__c BigDealSurvey {get; set;}
    
    public Limite_de_Big_deal_por_pais__c BigDealLimit {get; set;}
    public List<Resource__c> resources {get;set;}
    private List<Resource__c> resourcesTemp;
    public List<Big_Deal_Resource__c> bigDealResources {get;set;}
    public Id delid {get;set;}
    
    public PageReference deleteResource() {
        
        Big_Deal_Resource__c aBorrar = new Big_Deal_Resource__c();
        

           aBorrar = [select id from Big_Deal_Resource__c where id = :delid];
	    
           if(Big_Deal_Resource__c.sObjectType.getDescribe().isDeletable()){
               delete aBorrar;
           }
                
        readResources = true;
        return null;
    }

    public BigDealChartsController () {
        loadDummyData();
        checkAprobarGoEstrategico = false;
        CanEdit = false;
        BigDealSurvey = new Big_deals_Survey__c();              
        readResources = true;
    }
    
    public PageReference save() {
        system.debug('save');
        system.debug(BigDealSurvey);
        //BigDealSurvey.Aprobar_Go_Estrategico__c = checkAprobarGoEstrategico;
        system.debug(checkAprobarGoEstrategico);

        upsert BigDealSurvey;

        update bigDealResources;
        
        readResources = true;

        //system.debug('>>>>save-resources: ' + resources);        
        return null;
    }

    public PageReference insertRerources() {
        system.debug('insertRerources - resources: ' + resources);
        
        List<Big_Deal_Resource__c> bigDealResourcesToInsert = new List<Big_Deal_Resource__c>();        
        for (Resource__c r :resources) {
            if (r.Selected__c) {
                bigDealResourcesToInsert.add(new Big_Deal_Resource__c(Survey__c = BigDealSurvey.id, Resource__c = r.id));
            }
        }
        system.debug('insertRerources - bigDealResourcesToInsert: ' + bigDealResourcesToInsert);
        readResources = true;
        

            insert bigDealResourcesToInsert;
        return null;
    }    

    //----------------------------------------------------------------------------------
    public void loadDummyData() {
        FieldScore dummy = new FieldScore(0,1,1);
        //-----------------------------------------------------------------
        EconomicalInfoData = new EconomicalInformationScore();
        EconomicalInfoData.FullContractValue = dummy;
        EconomicalInfoData.FCVSecondary = dummy;
        EconomicalInfoData.IncomeForNext12Months = dummy;
        EconomicalInfoData.IncomeForNext12MonthsSecondary = dummy;
        EconomicalInfoData.TotalCapex = dummy;
        EconomicalInfoData.NaturalYearNAV = dummy;
        EconomicalInfoData.NaturalYearNAVSecondary = dummy;
        //-----------------------------------------------------------------
        ScheduleData = new ScheduleScore();
        ScheduleData.OfferTurnInDate = dummy;
        ScheduleData.ContractStartDate = dummy;
        //-----------------------------------------------------------------
        ReachData = new ReachScore();
        ReachData.AffectedLines = dummy;
        ReachData.DeliberablesDescription = dummy;
        ReachData.TechnicalArchitectureDescription = dummy;
        ReachData.ReachOfThirdPartyInvolvement = dummy;
        ReachData.AmountOfResourcesToIncorporate = dummy;
        //-----------------------------------------------------------------
        PresaleAndOfferData = new PresaleAndOfferScore();
        PresaleAndOfferData.AmountOfContributedFTE = dummy;
        PresaleAndOfferData.AmountOfThirdPartyFTERequired = dummy;
        PresaleAndOfferData.ActivitiesDuringPresale = dummy;
        PresaleAndOfferData.EstimatedPresaleAndOfferDuration = dummy;
        //-----------------------------------------------------------------
        RisksData = new RisksScore();
        RisksData.Clients = new ClientsRisks(RisksData.Weight);
        RisksData.Clients.KnowledgeOnTheClient = dummy;
        RisksData.Clients.RelationWithPrincipalDecisionMakers = dummy;
        RisksData.Clients.ProjectImpactOnClient = dummy;
        //----------------------------------
        RisksData.TechnicalSolution = new TechnicalSolutionRisks(RisksData.Weight);
        RisksData.TechnicalSolution.EnoughFormalInformation = dummy;
        RisksData.TechnicalSolution.DefinedSLA = dummy;
        RisksData.TechnicalSolution.SLADemandDegree = dummy;
        RisksData.TechnicalSolution.CapacityToSatisfySLA = dummy;
        RisksData.TechnicalSolution.DegreeOfCertainityStabilityOfPlatform = dummy;
        //----------------------------------
        RisksData.Project = new ProjectRisks(RisksData.Weight);
        RisksData.Project.Bails = dummy;
        RisksData.Project.Indemnizations = dummy;
        //----------------------------------
        RisksData.Financial = new FinancialRisks(RisksData.Weight);
        RisksData.Financial.ClientFinancialStability = dummy;
        //RisksData.Financial.CapexConsumption = dummy;
        RisksData.Financial.PenaltyOnLevelService = dummy;
        RisksData.Financial.PenaltyOnContractCancellation = dummy;
        RisksData.Financial.IndemnizationsVSValue = dummy;
        RisksData.Financial.WorkingLiabilityVSValue = dummy;
        //----------------------------------
        RisksData.Organization = new OrganizationRisks(RisksData.Weight);
        RisksData.Organization.ProductsInPortfolio = dummy;
        RisksData.Organization.ProfilesAvailable = dummy;
        RisksData.Organization.ClientKeyPersonnel = dummy;
        //----------------------------------
        RisksData.ThirdParty = new ThirdPartyRisks(RisksData.Weight);
		RisksData.ThirdParty.PartnersIdentified = dummy;
        RisksData.ThirdParty.SituationWithPartnersIsFavorable = dummy;
        RisksData.thirdParty.TieneServiciosQueAportan = dummy;
    }
    
    private boolean isSurveyComplete() {
        
        system.debug(BigDealSurvey.Full_contract_value__c);
        system.debug(BigDealSurvey.NAV_o_ingresos_proximos_12_meses__c);
        system.debug(BigDealSurvey.Capex_total__c);
        system.debug(BigDealSurvey.fecha_de_entrega__c);
        system.debug(BigDealSurvey.Fecha_comienzo_de_contrato__c);
        system.debug(BigDealSurvey.NAV_12_meses_naturales__c);
        system.debug(BigDealSurvey.Lineas_implicadas__c);
        system.debug(BigDealSurvey.Fecha_comienzo_de_contrato__c);
        system.debug(BigDealSurvey.NAV_12_meses_naturales__c);
        system.debug(BigDealSurvey.Alcance_del_proyecto_desplegable__c);
        system.debug(BigDealSurvey.ofertas_terceros_desplegable__c); // null
        system.debug(BigDealSurvey.incorporar_personas_desplegable__c);
        system.debug(BigDealSurvey.FTE_que_se_aportaran__c);
        system.debug(BigDealSurvey.FTE_terceros_requeridos__c);
        system.debug(BigDealSurvey.Actividades_durante_preventa__c);
        system.debug(BigDealSurvey.Duracion_estimada_Preventa__c);
        system.debug(BigDealSurvey.Grado_de_conocimiento_del_cliente__c);
        system.debug(BigDealSurvey.Interrelacion_con_principales_decisores__c);
       	system.debug(BigDealSurvey.Impacto_en_el_cliente__c);
        system.debug(BigDealSurvey.Informacion_formalizada_suficiente_despl__c);
        //system.debug(BigDealSurvey.Grado_exigencia_SLA__c);
        //system.debug(BigDealSurvey.Capacidad_para_cumplir_los_SLA__c); ahora son solo obligatorios si hay slas es si, por lo tanto no pueden ser obligatorios para mostrar el grafico.
        system.debug(BigDealSurvey.Grado_certeza_continuidad_plataforma__c);
        system.debug(BigDealSurvey.Importe_fianzas_depositar__c);
        system.debug(BigDealSurvey.Estabilidad_financiera_cliente_desple__c);
        //system.debug(BigDealSurvey.porcentaje_penalizacion_incumplimiento__c); lo mismo que el de arriba.
        system.debug(BigDealSurvey.porcentage_indemnizacion_total_importe__c);
        system.debug(BigDealSurvey.Porcentaje_pasivo_laboral_importe__c);
        system.debug(BigDealSurvey.Productos_clave_estan_en_porfolio_desple__c);
        system.debug(BigDealSurvey.Estan_perfiles_clave_necesarios_desple__c);
        system.debug(BigDealSurvey.Personal_clave_del_cliente_desple__c);
        system.debug(BigDealSurvey.Partners_necesarios_identificados_desple__c);
        system.debug(BigDealSurvey.Situacion_con_partners_favorable_desple__c);
        system.debug(BigDealSurvey.Fecha_estimada_del_fallo__c); // null
        
        return BigDealSurvey.Full_contract_value__c != null && BigDealSurvey.NAV_o_ingresos_proximos_12_meses__c != null && BigDealSurvey.Capex_total__c != null &&
                	BigDealSurvey.fecha_de_entrega__c != null && BigDealSurvey.Fecha_comienzo_de_contrato__c != null && BigDealSurvey.NAV_12_meses_naturales__c != null &&
                	BigDealSurvey.Lineas_implicadas__c != null && BigDealSurvey.Alcance_del_proyecto_desplegable__c != null && 
                	BigDealSurvey.ofertas_terceros_desplegable__c != null && 
                	BigDealSurvey.incorporar_personas_desplegable__c != null && BigDealSurvey.FTE_que_se_aportaran__c != null &&
                	BigDealSurvey.FTE_terceros_requeridos__c != null && BigDealSurvey.Actividades_durante_preventa__c != null && BigDealSurvey.Duracion_estimada_Preventa__c != null &&
                	BigDealSurvey.Grado_de_conocimiento_del_cliente__c != null && BigDealSurvey.Interrelacion_con_principales_decisores__c != null && BigDealSurvey.Impacto_en_el_cliente__c != null &&
                	BigDealSurvey.Informacion_formalizada_suficiente_despl__c != null &&
                	BigDealSurvey.Grado_certeza_continuidad_plataforma__c != null &&  
                	BigDealSurvey.Importe_fianzas_depositar__c != null && BigDealSurvey.Estabilidad_financiera_cliente_desple__c != null &&  
                	BigDealSurvey.porcentage_indemnizacion_total_importe__c != null && BigDealSurvey.Porcentaje_pasivo_laboral_importe__c != null &&
					BigDealSurvey.Productos_clave_estan_en_porfolio_desple__c != null && BigDealSurvey.Estan_perfiles_clave_necesarios_desple__c != null && BigDealSurvey.Personal_clave_del_cliente_desple__c != null &&
                	BigDealSurvey.Partners_necesarios_identificados_desple__c != null && BigDealSurvey.Situacion_con_partners_favorable_desple__c != null && BigDealSurvey.Fecha_estimada_del_fallo__c != null;
    }
    
    public PageReference aprobarGoEstrategico(){
        

            BigDealSurvey.Aprobar_Go_Estrategico__c = True;           
            
            upsert BigDealSurvey;


        
        return null;
    }
    
    public PageReference desaprobarGoEstrategico(){
        

            BigDealSurvey.Aprobar_Go_Estrategico__c = False;
            
            upsert BigDealSurvey;


        
        return null;
    }
    
    public PageReference irASolicitudCapex() {
        
        List <Solicitud_capex__c> solicitud = new List <Solicitud_capex__c>();
        

        solicitud = [SELECT ID FROM Solicitud_capex__c WHERE Big_Deal__c =: BigDealSurvey.id LIMIT 1];

        
        if(solicitud.size() == 0){
            
            Account cuenta = new Account();
            

           cuenta = [SELECT name FROM Account WHERE Id =: BigDealSurvey.oportunidad__r.AccountId];

            
            system.debug('dentro de la solicitud encontra');
			Solicitud_capex__c solicitudACrear = new Solicitud_capex__c(Big_Deal__c = BigDealSurvey.id);
                

                solicitudACrear.Proyect_Name__c = BigDealSurvey.oportunidad__r.name;

                solicitudACrear.Salesforce_code__c = BigDealSurvey.Codigo_en_Sales_Force_del_proyecto__c;

                solicitudACrear.Proyect_description__c = BigDealSurvey.oportunidad__r.Description;

                solicitudACrear.Client_Name__c = cuenta.name;

                solicitudACrear.FCV__c = BigDealSurvey.Full_contract_value__c;

                solicitudACrear.NAV__c = BigDealSurvey.NAV_12_meses_naturales__c;

                solicitudACrear.Total_Capex__c = BigDealSurvey.Capex_total__c;
            

                insert solicitudACrear;

			
            String url = Page.solicitudCapex.getURL();
            return new PageReference (url + '?id=' + solicitudACrear.id);
        }else{
            system.debug(BigDealSurvey.id);

            String url = Page.solicitudCapex.getURL();
            return new PageReference (url + '?id=' + solicitud[0].ID);
        }
    }
    //==================================================================================
    //Qualifiers
    //==================================================================================
    public double getManualScoresFraction(string value) {
        double detailScoreValue; 
        if(value != null){
        	detailScoreValue = double.valueOf(value.replace('%', '')) / 100;
        }
        else {
            detailScoreValue = 1;
        }
        return detailScoreValue;
    }
    
    public integer qualifyFullContractValue(decimal fcv) {
        if(fcv < 200) {
            if(fcv < 150) {
                if(fcv < 100) {
                    if(fcv < 75) {
                        if(fcv < 50) {
                            if(fcv < 20) {
                                if(fcv < 10) {
                                    if(fcv < 5) {
                                        if(fcv < 2) {
                                            if(fcv == 0) {
                                                return 0;
                                            }
                                            else{
                                                return 10;
                                            }
                                        }
                                        else {
                                            return 20;
                                        }
                                    }
                                    else {
                                        return 30;
                                    }
                                }
                                else {
                                    return 40;
                                }
                            }
                            else {
                                return 50;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 70;
                    }
                }
                else {
                    return 80;
                }
            }
            else {
                return 90;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyEconomicalInfoSecondaryScores(decimal fcv, decimal lim) {
        if(fcv < lim * 3) {
            if(fcv < lim * 2) {
                if(fcv < lim * 1.5) {
                    if(fcv < lim * 1.2) {
                        if(fcv < lim) {
                            if(fcv < lim * 0.8) {
                                if(fcv < lim * 0.7) {
                                    if(fcv < lim * 0.5) {
                                        if(fcv < lim * 0.4) {
                                            if(fcv < lim * 0.2) {
                                                return 0;
                                            }
                                            else {
                                                return 10;
                                            }
                                        }
                                        return 20;
                                    }
                                    return 30;
                                }
                                return 40;
                            }
                            return 50;
                        }
                        return 60;
                    }
                    return 70;
                }
                return 80;
            }
            return 90;
        }
        return 100;
    }
    
    public integer qualifyIncomeForNext12Months(decimal income) {
        if (income < 50) {
            if (income < 30) {
                if (income < 20) {
                    if (income < 15) {
                        if (income < 10) {
                            if (income < 4) {
                                if (income < 2) {
                                    if (income < 1) {
                                        if (income < 0.5) {
                                            if (income == 0) {
                                                return 0;
                                            }
                                            else {
                                                return 10;
                                            }
                                        }
                                        else {
                                            return 20;
                                        }
                                    }
                                    else {
                                        return 30;
                                    }
                                }
                                else {
                                    return 40;
                                }
                            }
                            else {
                                return 50;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 70;
                    }
                }
                else {
                    return 80;
                }
            }
            else {
                return 90;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyNAVEstimadoFinDeAnioActual(decimal income) {
        if (income < 4) {
            if (income < 3.5) {
                if (income < 3) {
                    if (income < 2.5) {
                        if (income < 2) {
                            if (income < 1.5) {
                                if (income < 1) {
                                    if (income < 0.75) {
                                        if (income < 0.5) {
                                            if (income == 0) {
                                                return 0;
                                            }
                                            else {
                                                return 10;
                                            }
                                        }
                                        else {
                                            return 20;
                                        }
                                    }
                                    else {
                                        return 30;
                                    }
                                }
                                else {
                                    return 40;
                                }
                            }
                            else {
                                return 50;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 70;
                    }
                }
                else {
                    return 80;
                }
            }
            else {
                return 90;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyTotalCapex(decimal capex) {
        if (capex > 0.5) {
            if (capex > 1) {
                if (capex > 2) {
                    if (capex > 3) {
                        if (capex > 10) {
                            if (capex > 15) {
                                if (capex > 20) {
                                    if (capex > 30) {
                                        if (capex > 40) {
                                            if (capex > 45) {
                                                if (capex > 49) {
                                                    return -1;
                                                }
                                                else {
                                                    return 0;
                                                }
                                            }
                                            else {
                                                return 10;
                                            }
                                        }
                                        else {
                                            return 20;
                                        }
                                    }
                                    else {
                                        return 30;
                                    }
                                }
                                else {
                                    return 40;
                                }
                            }
                            else {
                                return 50;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 70;
                    }
                }
                else {
                    return 80;
                }
            }
            else {
                return 90;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyContractStartDate(Date ContractStart, Date DecisionDate) {
        integer weeks = DecisionDate.daysBetween(ContractStart) / 7;
        if (weeks < 7) {
            if (weeks < 6) {
                if (weeks < 5) {
                    if (weeks < 4) {
                        if (weeks < 3) {
                            if (weeks < 2) {
                                return 20;
                            }
                            else {
                                return 50;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 70;
                    }
                }
                else {
                    return 80;
                }
            }
            else {
                return 90;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyOfferTurnInDate(Date TurnInDate) {
        return qualifyOfferTurnInDate(TurnInDate, System.today());
    }    

    public integer qualifyOfferTurnInDate(Date TurnInDate, Date CompareDate) {
        final integer week = 7;
        integer days = CompareDate.daysBetween(TurnInDate);
        
        if (days < 11 * week) {
            if (days < 10 * week) {
                if (days < 9 * week) {
                    if (days < 8 * week) {
                        if (days < 7 * week) {
                            if (days < 6 * week) {
                                if (days < 5 * week) {
                                    if (days < 4 * week) {
                                        if (days < 3 * week) {
                                            if (days < 15) {
                                                return -1;
                                            }
                                            else {
                                                return 0;
                                            }
                                        }
                                        else {
                                            return 20;
                                        }
                                    }
                                    else {
                                        return 30;
                                    }
                                }
                                else {
                                    return 40;
                                }
                            }
                            else {
                                return 50;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 70;
                    }
                }
                else {
                    return 80;
                }
            }
            else {
                return 90;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyDefinedReach(boolean value) {
        if(value) {
            return 100;
        } 
        else {
            return -1;
        }
    }
    
    public integer qualifyTechnicalArchitectureDescription(boolean value) {
        if(value) {
            return 100;
        } 
        else {
            return 0;
        }
    }
    
    public integer qualifyReachOfThirdPartyInvolvement(string value) {
        if(value != '< 80%') {
            if(value != '< 70%') {
                if(value != '< 60%') {
                    if(value != '< 50%') {
                        if(value != '< 40%') {
                            if(value != '< 30%') {
                                if(value != '< 20%') {
                                    if(value != '< 10%') {
                                        return -1;//value == '> 80%'
                                    }
                                    else {
                                        return 90;
                                    }
                                }
                                else {
                                    return 80;
                                }
                            }
                            else {
                                return 70;
                            }
                        }
                        else {
                            return 60;
                        }
                    }
                    else {
                        return 50;
                    }
                }
                else {
                    return 30;
                }
            }
            else {
                return 20;
            }
        }
        else {
            return 0;
        }
    }
    
    public integer qualifyAmountOfResourcesToIncorporate(string value) {
        /*
        if(value != '+5') {
            if(value != '+10') {
                if(value != '+15') {
                    if(value != '+20') {
                        if(value != '+30') {
                            if(value != '+40') {
                                if(value != '+50') {
                                    if(value != '+70') {
                                        return -1;//value == '+80'
                                    }
                                    else {
                                        return 0;
                                    }
                                }
                                else {
                                    return 10;
                                }
                            }
                            else {
                                return 20;
                            }
                        }
                        else {
                            return 30;
                        }
                    }
                    else {
                        return 40;
                    }
                }
                else {
                    return 50;
                }
            }
            else {
                return 70;
            }
        }
        else {
            return 80;
        }*/
        if(value == '<14'){
            return 0;
        }
        if(value == '<10'){
            return 10;
        }
        if(value == '<=8'){
            return 20;
        }
        if(value == '7'){
            return 30;
        }
        if(value == '6'){
            return 40;
        }
        if(value == '5'){
            return 50;
        }
        if(value == '4'){
            return 60;
        }
        if(value == '3'){
            return 70;
        }
        if(value == '2'){
            return 80;
        }
        if(value == '1'){
            return 90;
        }
        if(value == '0'){
            return 100;
        }
        return -1;
        
    }
    
    public integer qualifyAmountOfContributedFTE(string value) {
        if(value != '+5') {
            if(value != '5') {
                if(value != '4') {
                    if(value != '3') {
                        if(value != '2') {
                            if(value != '1') {
                                return -1;
                            }
                            else {
                                return 10;
                            }
                        }
						else {
                        	return 20;
						}
                    }
					else {
                    	return 40;
					}
                }
				else {
                	return 60;
				}
            }
			else {
            	return 80;
			}
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyAmountOfThirdPartyFTERequired(string value) {
        if(value != '+5') {
            if(value != '5') {
                if(value != '4') {
                    if(value != '3') {
                        if(value != '2') {
                            if(value != '1') {
                                return 100;
                            }
                            else {
                                return 80;
                            }
                        }
						else {
                        	return 60;
						}
                    }
					else {
                    	return 50;
					}
                }
				else {
                	return 30;
				}
            }
			else {
            	return 20;
			}
        }
        else {
            return 0;
        }
    }
    
    public integer qualifyActivitiesDuringPresale(string value) {
        if(value == 'Solo Oferta') {
            return 30;
        }
        if(value == 'Solo preventa especialista sectorial') {
            return 50;
        } 
        //if(value == 'Preventa especialista sectorial + Oferta') {
        return 100;
        
    }
    
    public integer qualifyEstimatedPresaleAndOfferDuration(string value) {
        if(value != '1') {
            if(value != '2') {
                if(value != '3') {
                    if(value != '4') {
                        if(value != '5') {
                            if(value != '6') {
                                if(value != '7') {
                                    if(value != '9') {
                                        return -1;//value == '+9'
                                    }
                                    else {
                                        return 0;
                                    }
                                }
                                else {
                                    return 10;
                                }
                            }
                            else {
                                return 20;
                            }
                        }
                        else {
                            return 30;
                        }
                    }
                    else {
                        return 40;
                    }
                }
                else {
                    return 60;
                }
            }
            else {
                return 80;
            }
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyMostRisks(string value) {
        if(value == 'Alto' || value == 'Alta') {
            return 100;
        } 
        if(value == 'Medio' || value == 'Media') {
            return 60;
        } 
        if(value == 'Bajo' || value == 'Baja') {
            return 30;
        } 
        //if(value == 'Escaso' || value == 'Escasa') 
        return 0;
    }
    
    public integer qualifyMostRisksInverse(string value) {
        return 100 - qualifyMostRisks(value);
    }
    
    public integer qualifyEnoughFormalInformation(boolean value) {
        if(value) {
            return 100;
        } 
        else {
            return 0;
        }
    }
    
    public integer qualifyBails(string value) {
        if(value == '0') {
            return 100;
        }
        if(value == '50') {
            return 80;
        } 
        if(value == '100') {
            return 60;
        } 
        if(value == '150') {
            return 50;
        }
        if(value == '200') {
            return 30;
        }
        //if(value == '+200') 
        return 0;
    }
    
    public integer qualifyIndemnizations(string value) {
        if(value == '0') {
            return 100;
        }
        if(value == '50') {
            return 80;
        } 
        if(value == '100') {
            return 60;
        } 
        if(value == '150') {
            return 50;
        }
        if(value == '200') {
            return 30;
        }
        if(value == '+200') {
        	return 10;
        }
        //if(value == 'no conocidas')
        return 0;
    }
    
    public integer qualifyDefinedSLA(boolean value) {
        if(value) {
            return 100;
        }
        else {
            return 0;
        }
    }
    
    public integer qualifyClientFinancialStability(boolean value) {
        if(value) {
            return 100;
        }
        else {
            return 0;
        }
    }
    
    public integer qualifyCapexConsumption(boolean value) {
        if(value) {
            return 30;
        }
        else {
            return 100;
        }
    }
    
    public integer qualifyMostFinancialRisks(string value) {
        if(value == '<1%' || value == '0%') {
            return 100;
        }
        if(value == '<1%') {
            return 90;
        }
        if(value == '1 - 2%') {
            return 60;
        } 
        if(value == '3 - 5%') {
            return 30;
        }
        //if(value == '>5%')
        return 0;
    }
    
    public integer qualifyIndemnizationsVSValue(string value) {
        if(value == '0%') {
            return 100;
        }
        if(value == '<10%') {
            return 90;
        }
        if(value == '10 - 30%') {
            return 60;
        } 
        if(value == '30 - 50%') {
            return 30;
        }
        if(value == '50 - 100%'){
        	return 0;
        }
        //if(value == '>100%'){
        return -1;
    }
    
    public integer qualifyOrganizationAndThirdPartyRisks(boolean value) {
        if(value) {
            return 100;
        }
        else {
            return 0;
        }
    }
    
    public Integer qualifyCondicionPreviaLicitar(String valorElegido){
        if(valorElegido == 'No'){
            return 100;
        }else{
            return 0;
        }
    }
    
    public Integer qualifyValorResicion (String valorElegido){
        if(valorElegido == 'No'){
            return 100;
        }else{
            return 0;
        }
    }
    //==================================================================================
    //Loaders
    //==================================================================================
    private void loadClientsRisks(string knowledge, string relationship, string impact) {
        RisksData.Clients = new ClientsRisks(RisksData.Weight);
        RisksData.Clients.KnowledgeOnTheClient = new FieldScore(qualifyMostRisks(knowledge), 25, RisksData.Clients.Weight);
        RisksData.Clients.RelationWithPrincipalDecisionMakers = new FieldScore(qualifyMostRisks(relationship), 25, RisksData.Clients.Weight);
        RisksData.Clients.ProjectImpactOnClient = new FieldScore(qualifyMostRisksInverse(impact), 50, RisksData.Clients.Weight);
    }
    
    private void loadTechnicalSolutionRisks(String valorPicklist, string SLADemand, string capabilityToSatisfySLA, string stabilityAlongTimeOfPlatform, String definedSLA, String SLADetailScore) {
        RisksData.TechnicalSolution = new TechnicalSolutionRisks(RisksData.Weight);
        RisksData.TechnicalSolution.EnoughFormalInformation = new FieldScore(qualifyEnoughFormalInformation(valorPicklist == 'Si'), 40, RisksData.TechnicalSolution.Weight);
        RisksData.TechnicalSolution.DefinedSLA = new FieldScore((integer)(qualifyDefinedSLA(definedSLA == 'Si') * getManualScoresFraction(SLADetailScore)), 10, RisksData.TechnicalSolution.Weight);
        RisksData.TechnicalSolution.SLADemandDegree = new FieldScore(qualifyMostRisksInverse(SLADemand), 25, RisksData.TechnicalSolution.Weight);
        RisksData.TechnicalSolution.CapacityToSatisfySLA = new FieldScore(qualifyMostRisks(capabilityToSatisfySLA), 15, RisksData.TechnicalSolution.Weight);
        RisksData.TechnicalSolution.DegreeOfCertainityStabilityOfPlatform = new FieldScore(qualifyMostRisks(stabilityAlongTimeOfPlatform), 10, RisksData.TechnicalSolution.Weight);
    }
    
    private void loadProjectRisks(string bails, string valorPicklist) {
        RisksData.Project = new ProjectRisks(RisksData.Weight);
        RisksData.Project.Bails = new FieldScore(qualifyBails(bails), 60, RisksData.Project.Weight);
        RisksData.Project.Indemnizations = new FieldScore(qualifyCondicionPreviaLicitar(valorPicklist), 40, RisksData.Project.Weight);
    }
    
    private void loadFinancialRisks(String valorPickListCliente, string penaltyLevelService, string valorPenalizacionPorResicion, 
                                    string indemnizations, string LaboralLiability) {
        RisksData.Financial = new FinancialRisks(RisksData.Weight);
        RisksData.Financial.ClientFinancialStability = new FieldScore(qualifyClientFinancialStability(valorPickListCliente == 'No') , 60, RisksData.Financial.Weight);
        //RisksData.Financial.CapexConsumption = new FieldScore(qualifyCapexConsumption(capexConsumption) , 10, RisksData.Financial.Weight);
        RisksData.Financial.PenaltyOnLevelService = new FieldScore(qualifyMostFinancialRisks(penaltyLevelService) , 10, RisksData.Financial.Weight);
        RisksData.Financial.PenaltyOnContractCancellation = new FieldScore(qualifyValorResicion(valorPenalizacionPorResicion) , 5, RisksData.Financial.Weight); 
        RisksData.Financial.IndemnizationsVSValue = new FieldScore(qualifyIndemnizationsVSValue(indemnizations) , 15, RisksData.Financial.Weight);
        RisksData.Financial.WorkingLiabilityVSValue = new FieldScore(qualifyMostFinancialRisks(LaboralLiability) , 10, RisksData.Financial.Weight);
    }
    
    private void loadOrganizationRisks(String valorPickListproducts, String valorPickListprofiles, String valorPickListkeyPersonnel) {
        RisksData.Organization = new OrganizationRisks(RisksData.Weight);
        RisksData.Organization.ProductsInPortfolio = new FieldScore(qualifyOrganizationAndThirdPartyRisks(valorPickListproducts == 'Si'), 40, RisksData.Organization.Weight);
        RisksData.Organization.ProfilesAvailable = new FieldScore(qualifyOrganizationAndThirdPartyRisks(valorPickListprofiles == 'Si'), 30, RisksData.Organization.Weight);
        RisksData.Organization.ClientKeyPersonnel = new FieldScore(qualifyOrganizationAndThirdPartyRisks(valorPickListkeyPersonnel == 'Si'), 30, RisksData.Organization.Weight);
    }
    
    private void loadThirdPartyRisks(String partnersIdentified, String partnerSituationFavorable, String valorServiciosQueAportan) {
        RisksData.ThirdParty = new ThirdPartyRisks(RisksData.Weight);
        RisksData.ThirdParty.PartnersIdentified = new FieldScore(qualifyOrganizationAndThirdPartyRisks(partnersIdentified == 'Si') , 50, RisksData.ThirdParty.Weight);
        RisksData.ThirdParty.SituationWithPartnersIsFavorable = new FieldScore(qualifyOrganizationAndThirdPartyRisks(partnerSituationFavorable == 'Si') , 25, RisksData.ThirdParty.Weight);
        RisksData.ThirdParty.TieneServiciosQueAportan = new FieldScore(qualifyOrganizationAndThirdPartyRisks(valorServiciosQueAportan == 'Si') , 25, RisksData.ThirdParty.Weight);
    }
    
    private void loadAmountOfContributedFTE(string value) {
        FieldScore fs = new FieldScore(qualifyAmountOfContributedFTE(value), 40, PresaleAndOfferData.Weight);
        PresaleAndOfferData.AmountOfContributedFTE = fs;
    }
    
    private void loadAmountOfThirdPartyFTERequired(string value) {
        FieldScore fs = new FieldScore(qualifyAmountOfThirdPartyFTERequired(value), 20, PresaleAndOfferData.Weight);
        PresaleAndOfferData.AmountOfThirdPartyFTERequired = fs;
    }
    
    private void loadActivitiesDuringPresale(string value) {
        FieldScore fs = new FieldScore(qualifyActivitiesDuringPresale(value), 25, PresaleAndOfferData.Weight);
        PresaleAndOfferData.ActivitiesDuringPresale = fs;
    }
    
    private void loadEstimatedPresaleAndOfferDuration(string value) {
        FieldScore fs = new FieldScore(qualifyEstimatedPresaleAndOfferDuration(value), 15, PresaleAndOfferData.Weight);
        PresaleAndOfferData.EstimatedPresaleAndOfferDuration = fs;
    }
    
    private void loadAffectedLines(string value) {
        integer percentageScore = integer.valueOf(value.replace('%', ''));
        FieldScore fs = new FieldScore(percentageScore, 25, ReachData.Weight);
        ReachData.AffectedLines = fs;
    }
    
    private void loadDeliberablesDescription(String valorSeleccionado, string detailScore) {
        double detailScoreValue = (valorSeleccionado == 'Si')?getManualScoresFraction(detailScore):1;
        FieldScore fs = new FieldScore((integer)(qualifyDefinedReach(valorSeleccionado == 'Si') * detailScoreValue), 25, ReachData.Weight);
        ReachData.DeliberablesDescription = fs;
    }
    
    private void loadTechnicalArchitectureDescription(String valorPicklist, string detailScore) {
        double detailScoreValue = getManualScoresFraction(detailScore);
        FieldScore fs = new FieldScore((integer)(qualifyTechnicalArchitectureDescription(valorPicklist == 'Si') * detailScoreValue), 15, ReachData.Weight);
        ReachData.TechnicalArchitectureDescription = fs;
    }
    
    private void loadReachOfThirdPartyInvolvement(String valorPicklist, string amount) {
        integer scoreValue; 
        if(valorPicklist == 'Si'){
        	scoreValue = qualifyReachOfThirdPartyInvolvement(amount);
        }
        else {
            scoreValue = 100;
        }
        FieldScore fs = new FieldScore(scoreValue, 20, ReachData.Weight);
        ReachData.ReachOfThirdPartyInvolvement = fs;
    }
    
    private void loadAmountOfResourcesToIncorporate(String valorPicklist, string amount) {
        integer scoreValue; 
        if(valorPicklist == 'Si'){
        	scoreValue = qualifyAmountOfResourcesToIncorporate(amount);
        }
        else {
            scoreValue = 100;
        }
        FieldScore fs = new FieldScore(scoreValue, 15, ReachData.Weight);
        ReachData.AmountOfResourcesToIncorporate = fs;
    }
    
    private void loadFCV(decimal fcv) {
        FieldScore cpw = new FieldScore(qualifyFullContractValue(fcv), 25, EconomicalInfoData.Weight);
        decimal fcvLimit = 1;//TODO
        FieldScore secondaryScore;
        if(BigDealLimit != null) {
            secondaryScore = new FieldScore(qualifyEconomicalInfoSecondaryScores(fcv, fcvLimit), 15, EconomicalInfoData.Weight);
        }
        else {
            secondaryScore = new FieldScore(0, 15, EconomicalInfoData.Weight);
        }
        EconomicalInfoData.FullContractValue = cpw;
        EconomicalInfoData.FCVSecondary = secondaryScore;
    }
    
    private void loadIncomeForNext12Months(decimal income) {
        FieldScore cpw = new FieldScore(qualifyIncomeForNext12Months(income), 10, EconomicalInfoData.Weight);
        FieldScore secondary;
        if(BigDealLimit != null) {
            secondary = new FieldScore(qualifyEconomicalInfoSecondaryScores(income, BigDealLimit.NAV__c), 5, EconomicalInfoData.Weight);
        }
        else {
            secondary = new FieldScore(0, 5, EconomicalInfoData.Weight);
        }
        EconomicalInfoData.IncomeForNext12Months = cpw;
        EconomicalInfoData.IncomeForNext12MonthsSecondary = secondary;
    }
    
    private void loadNaturalYearNAV(decimal income) {
        FieldScore cpw = new FieldScore(qualifyNAVEstimadoFinDeAnioActual(income), 15, EconomicalInfoData.Weight);
        FieldScore secondary;
        if(BigDealLimit != null) {
            secondary = new FieldScore(qualifyEconomicalInfoSecondaryScores(income, BigDealLimit.NAV__c), 5, EconomicalInfoData.Weight);
        }
        else {
            secondary = new FieldScore(0, 5, EconomicalInfoData.Weight);
        }
        EconomicalInfoData.NaturalYearNAV = cpw;
        EconomicalInfoData.NaturalYearNAVSecondary = secondary;
    }
    
    private void loadTotalCapex(decimal capex) {
        FieldScore cpw = new FieldScore(qualifyTotalCapex(capex), 25, EconomicalInfoData.Weight);
        EconomicalInfoData.TotalCapex = cpw;
    }
    
    private void loadOfferTurnInDate(Date turnDate, Date compareDate) {
        FieldScore cpw = new FieldScore(qualifyOfferTurnInDate(turnDate,compareDate), 65, ScheduleData.Weight);
        ScheduleData.OfferTurnInDate = cpw;
    }

    private void loadOfferTurnInDate(Date turnDate) {
        FieldScore cpw = new FieldScore(qualifyOfferTurnInDate(turnDate), 65, ScheduleData.Weight);
        ScheduleData.OfferTurnInDate = cpw;
    }
    
    private void loadContractStartDate(Date contractSDate, Date decisionDate) {
        FieldScore cpw = new FieldScore(qualifyContractStartDate(ContractSDate, decisionDate), 35, ScheduleData.Weight);
        ScheduleData.ContractStartDate = cpw;
    }
    //==================================================================================
    //Helper Clases
    //==================================================================================
    //Main Sections
    //----------------------------------------------------------------------------------
    public class RisksScore extends SectionScore {
        public override integer getWeight() {
            return 30;
        }
        
        public override List<double> getScore() {
                       
            //yo aca me tengo que traer los getScore de cada uno de estos por que no son field score 
            List <double> allScores = new List<double>();
            allScores.addAll(Clients.getScore());
            allScores.addAll(TechnicalSolution.getScore());
            allScores.addAll(Project.getScore());
            allScores.addAll(Financial.getScore());
            allScores.addAll(Organization.getScore());
            allScores.addAll(ThirdParty.getScore());

            
            /*return new List<double> {Clients.Score, TechnicalSolution.Score, Project.Score,
                Financial.Score, Organization.Score, ThirdParty.Score};*/
            return allScores;
       
                    
        }
        
        public ClientsRisks Clients {get; set;}
        public TechnicalSolutionRisks TechnicalSolution {get; set;}
        public ProjectRisks Project {get; set;}
        public FinancialRisks Financial {get; set;}
        public OrganizationRisks Organization {get; set;}
        public ThirdPartyRisks ThirdParty {get; set;}
    }
    
    public class PresaleAndOfferScore extends SectionScore {
        public override integer getWeight() {
            return 15;
        }
        
        public override List<double> getScore() {
            return new List<double> {AmountOfContributedFTE.Score,
                AmountOfThirdPartyFTERequired.Score,
                ActivitiesDuringPresale.Score,
                EstimatedPresaleAndOfferDuration.Score};
        }
        
        public FieldScore AmountOfContributedFTE {get; set;}
        public FieldScore AmountOfThirdPartyFTERequired {get; set;}
        public FieldScore ActivitiesDuringPresale {get; set;}
        public FieldScore EstimatedPresaleAndOfferDuration {get; set;}
    }
    
    public class ReachScore extends SectionScore {
        public override integer getWeight() {
            return 15;
        }
        
        public override List<double> getScore() {
            return new List<double> {AffectedLines.Score, ReachOfThirdPartyInvolvement.Score,
                TechnicalArchitectureDescription.Score, DeliberablesDescription.Score,
                AmountOfResourcesToIncorporate.Score};
        }
        
        public FieldScore AmountOfResourcesToIncorporate {get; set;}
        public FieldScore DeliberablesDescription {get; set;}
        public FieldScore TechnicalArchitectureDescription {get; set;}
        public FieldScore AffectedLines {get; set;}
        public FieldScore ReachOfThirdPartyInvolvement {get; set;}
    }
    
    public class EconomicalInformationScore extends SectionScore {
        public override integer getWeight() {
            return 25;
        }
        
        public override List<double> getScore() {
            return new List<double> {TotalCapex.Score, IncomeForNext12Months.Score, FullContractValue.Score,
                FCVSecondary.Score, IncomeForNext12MonthsSecondary.Score, NaturalYearNAV.Score,
                NaturalYearNAVSecondary.Score};
        }
        
        public FieldScore FCVSecondary {get; set;}
        public FieldScore FullContractValue {get; set;}
        public FieldScore IncomeForNext12Months {get; set;}
        public FieldScore IncomeForNext12MonthsSecondary {get; set;}
        public FieldScore NaturalYearNAV {get; set;}
        public FieldScore NaturalYearNAVSecondary {get; set;}
        public FieldScore TotalCapex {get; set;}
    }
    
    public class ScheduleScore extends SectionScore {
        public override integer getWeight() {
            return 15;
        }
        
        public override List<double> getScore() {
            return new List<double> {OfferTurnInDate.Score, ContractStartDate.Score};
        }
        
        public FieldScore OfferTurnInDate {get; set;}
        public FieldScore ContractStartDate {get; set;}
    }
    //----------------------------------------------------------------------------------
    //Risks subsections
    //----------------------------------------------------------------------------------
    public class ClientsRisks extends SectionScore {
        public override integer getWeight() {
            return 10 * parentWeight / 100;
        }
        
        public override List<double> getScore() {
            return new List<double> {KnowledgeOnTheClient.Score, RelationWithPrincipalDecisionMakers.Score,
                ProjectImpactOnClient.Score};
        }
        
        public double PercentageScore {
            get {
                return 100 * Score / Weight;
            }
        }
        
        private integer parentWeight;
        
        public ClientsRisks (integer parentWeight){
            this.parentWeight = parentWeight;
        }
        
        public FieldScore KnowledgeOnTheClient {get; set;}
        public FieldScore RelationWithPrincipalDecisionMakers {get; set;}
        public FieldScore ProjectImpactOnClient {get; set;}
    }
    
    public class TechnicalSolutionRisks extends SectionScore {
        public override integer getWeight() {
            return 20 * parentWeight / 100;
        }
        
        public override List<double> getScore() {
            return new List<double> {EnoughFormalInformation.Score, SLADemandDegree.Score,
                CapacityToSatisfySLA.Score, DegreeOfCertainityStabilityOfPlatform.Score, DefinedSLA.Score};
        }
        
        public double PercentageScore {
            get {
                return 100 * Score / Weight;
            }
        }
        
        private integer parentWeight;
        
        public TechnicalSolutionRisks (integer parentWeight){
            this.parentWeight = parentWeight;
        }
        
        public FieldScore EnoughFormalInformation {get; set;}
        public FieldScore SLADemandDegree {get; set;}
        public FieldScore CapacityToSatisfySLA {get; set;}
        public FieldScore DegreeOfCertainityStabilityOfPlatform {get; set;}
        public FieldScore DefinedSLA {get; set;}
    }
    
    public class ProjectRisks extends SectionScore {
        public override integer getWeight() {
            return 20 * parentWeight / 100;
        }
        
        public override List<double> getScore() {
            return new List<double> {Bails.Score, Indemnizations.Score};
        }
        
        public double PercentageScore {
            get {
                return 100 * Score / Weight;
            }
        }
        
        private integer parentWeight;
        
        public ProjectRisks (integer parentWeight){
            this.parentWeight = parentWeight;
        }
        
        public FieldScore Bails {get; set;}
        public FieldScore Indemnizations {get; set;}
    }
    
    public class FinancialRisks extends SectionScore {
        public override integer getWeight() {
            return 20 * parentWeight / 100;
        }
        
        public override List<double> getScore() {
            system.debug(ClientFinancialStability.Score);
            system.debug(PenaltyOnLevelService.Score);
            system.debug(PenaltyOnContractCancellation.Score);
            system.debug(IndemnizationsVSValue.Score);
            system.debug(WorkingLiabilityVSValue.Score);
            return new List<double> {ClientFinancialStability.Score, PenaltyOnLevelService.Score,
                PenaltyOnContractCancellation.Score, IndemnizationsVSValue.Score, WorkingLiabilityVSValue.Score};
        }
        
        public double PercentageScore {
            get {
                return 100 * Score / Weight;
            }
        }
        
        private integer parentWeight;
        
        public FinancialRisks (integer parentWeight){
            this.parentWeight = parentWeight;
        }
        
        public FieldScore ClientFinancialStability {get; set;}
        //public FieldScore CapexConsumption {get; set;}
        public FieldScore PenaltyOnLevelService {get; set;}
        public FieldScore PenaltyOnContractCancellation {get; set;}
        public FieldScore IndemnizationsVSValue {get; set;}
        public FieldScore WorkingLiabilityVSValue {get; set;}

    }
    
    public class OrganizationRisks extends SectionScore {
        public override integer getWeight() {
            return 20 * parentWeight / 100;
        }
        
        public override List<double> getScore() {
            return new List<double> {ProductsInPortfolio.Score, ProfilesAvailable.Score, ClientKeyPersonnel.Score};
        }
        
        public double PercentageScore {
            get {
                return 100 * Score / Weight;
            }
        }
        
        private integer parentWeight;
        
        public OrganizationRisks (integer parentWeight){
            this.parentWeight = parentWeight;
        }
        
        public FieldScore ProductsInPortfolio {get; set;}
        public FieldScore ProfilesAvailable {get; set;}
        public FieldScore ClientKeyPersonnel {get; set;}
    }
    
    public class ThirdPartyRisks extends SectionScore {
        public override integer getWeight() {
            return 10 * parentWeight / 100;
        }
        
        public override List<double> getScore() {
            return new List<double> {PartnersIdentified.Score, SituationWithPartnersIsFavorable.Score, TieneServiciosQueAportan.score};
        }
        
        public double PercentageScore {
            get {
                return 100 * Score / Weight;
            }
        }
        
        private integer parentWeight;
        
        public ThirdPartyRisks (integer parentWeight){
            this.parentWeight = parentWeight;
        }
        
        public FieldScore PartnersIdentified {get; set;}
        public FieldScore SituationWithPartnersIsFavorable {get; set;}
        public FieldScore TieneServiciosQueAportan {get; set;}

    }
    //----------------------------------------------------------------------------------
    //Non specific scoring clases
    //----------------------------------------------------------------------------------
    public class FieldScore {
        public string Color {get; set;}
        public double Score {get; set;}
        public double MaxScore {get; set;}
        public integer percentageScore {get; set;}
        
        public FieldScore (integer percentageScore, integer weight, integer sectionWeight) {
            this.percentageScore = percentageScore;
            Color = BigDealChartsController.getColorForPercentage(percentageScore);
            Score = percentageScore * (weight / 100.0) * (sectionWeight / 100.0);
            MaxScore = weight * (sectionWeight / 100.0);
        }
    }
    
    public abstract class SectionScore {
        public integer Weight {
            get{
                return getWeight();
            }
        }
        
        public double Score {
            get {
                List<double> scores = getScore();
                double total = 0;
                for(double sc : scores) {
                    total += sc;
                }
                return total;
            }
        }
        
        public string Color {
            get {
                List<double> scores = getScore();

                for(double sc : scores) {
                    if(sc < 0) {
                        return Black;
                    }
                }
                return BigDealChartsController.getColorForPercentage((integer)(Score * 100 / Weight));
            }
        }
        
        public abstract integer getWeight();
        public abstract List<double> getScore();
    }
    //==================================================================================
    public static string getColorForPercentage(double value) {
            if (value < 60) {
                if (value < 30) {
                    if (value < 0) {
                        return BigDealChartsController.Black;
                    }
                    else {
                        return BigDealChartsController.Red;
                    }
                }
                else {
                    return BigDealChartsController.Yellow;
                }
            }
            else {
                return BigDealChartsController.Green;
            }
        }
    //==================================================================================
/*
    private class bigDealResourcesWrapper {

        public Boolean selected {get;set;}
        public Resource__c resource {get;set;}

        public bigDealResourcesWrapper(Resource__c r) {
            resource = r;
            selected = false;
        }

    }
*/

}