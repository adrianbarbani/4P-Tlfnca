public with sharing class OpportunityBigDealController {
    public static final string DELIVERABLES_DESC = 'deliverables';
    public static final string TECHNICAL_DESC = 'technical';
    
    public Opportunity BigDealOpportunity {get;set;}
    public Account BigDealAccount {get; set;}
    
    public Boolean canEdit {get; set;}
    public boolean canRead {get; set;}
    public Boolean isBigDealAdmin {get; set;}
    public Boolean isBlocked {get; set;}
    
    public Big_deals_Survey__c Survey{get; set;}
    
    Public List<String> missingObligatoriField {get; set;}
    
    public OpportunityBigDealController(ApexPages.StandardController controller) {
        missingObligatoriField = new List<String>();
        
        loadPermissions();
        if(!canRead) {
            Survey = new Big_deals_Survey__c();
            BigDealOpportunity = new Opportunity();
            return;
        }
        
        
        BigDealOpportunity = [
            SELECT id, Name, AccountId, Amount, Description, CreatedDate
            FROM Opportunity
            WHERE id = :ApexPages.currentPage().getParameters().get('Id')
        ];
        
        List<Account> existingAccount = new List<Account>();
        
        existingAccount = [
            SELECT id, Name
            FROM Account
            WHERE id = :BigDealOpportunity.accountId
        ];
        
        if(existingAccount.size() == 0) {
            BigDealAccount = new Account();
        }
        else {
            BigDealAccount = existingAccount[0];
            
        }
        
        //tdd compatible
        loadSurvey();
        
        checkSurveyState();  
        
        if(Survey.Lineas_implicadas__c == null){
            Survey.Lineas_implicadas__c = '0';
        }
        
        if(survey.Full_contract_value__c != null && survey.Valor_estimado_one_shot__c != null){
            survey.Valor_estimado_ingresos_recurrentes__c = survey.Full_contract_value__c - survey.Valor_estimado_one_shot__c;
            if(survey.Valor_estimado_ingresos_recurrentes__c <0){
                survey.Valor_estimado_ingresos_recurrentes__c = 0;
            }
        }
    }
    
    private void checkSurveyState() {        
        if (Survey.state__c == 'Bloqueado') {
            isBlocked = true;
            if (!isBigDealAdmin) {
                canEdit = false;            
            }
        } else {
            isBlocked = false;
        }
    }
    
    private void loadPermissions() {
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        List<UserRecordAccess> recordAccessList = New List<UserRecordAccess>();
        
        
        recordAccessList = [SELECT RecordId, HasReadAccess, HasEditAccess, MaxAccessLevel FROM UserRecordAccess 
                            WHERE UserId=:UserInfo.getUserId() AND RecordId = :ApexPages.currentPage().getParameters().get('Id')];
        if(recordAccessList.size() > 0) {
            UserRecordAccess ura = recordAccessList[0];
            //userActions temp = new userActions();
            canEdit = ura.HasEditAccess;//temp.checkWrite(BigDealOpportunity.accountId);
            canRead = ura.HasReadAccess;
            isBigDealAdmin = false;
            
            List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
            
            psaList = [SELECT PermissionSetId, PermissionSet.Name FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId() AND PermissionSet.Name = 'Big_Deal_Admin'];
            
            if (psaList.size() > 0) {
                isBigDealAdmin = true;
            } 
        } else {
            canEdit = false;
            canRead = false;
            isBigDealAdmin = false;
        }
    }
    
    private void loadSurvey() {
        List<Big_deals_Survey__c> existentSurveys = new List<Big_deals_Survey__c>();
        
        
        existentSurveys = [
            SELECT ID, Name, Fecha_comienzo_de_contrato__c, Fecha_de_defensa__c, fecha_de_entrega__c,
            Fecha_estimada_del_fallo__c, Full_contract_value__c, NAV_o_ingresos_proximos_12_meses__c,
            Valor_estimado_one_shot__c, Valor_estimado_ingresos_recurrentes__c, Duracion_de_responsabilidad_civil__c,
            Capex_total__c, Capex_a_o_en_curso__c, Lineas_implicadas__c, l_neas_de_producto_principales__c,
            Alcance_definido__c, arquitectura_tecnica__c, Necesario_desarrollar_oferta_con_tercero__c,
            Alcance_de_la_colaboracion_con_terceros__c, Duracion_del_proyecto__c, Plazo_de_ejecucion__c,
            Experiencia_con_proyectos_similares__c, Detalle_de_experiencia_en_el_Grupo__c, Necesidad_de_incorporar_personas__c,
            FTE_que_se_aportaran__c, FTE_no_presentes__c, FTE_terceros_requeridos__c, Detalle_de_perfiles_necesarios__c,
            Actividades_durante_preventa__c, Duracion_estimada_Preventa__c, Condiciones_previas_para_licitar__c,
            Importe_fianzas_depositar__c, Duracion_de_la_garantia__c, SLA_definidos__c, SLA_Detalle__c,
            Detalle_penalizaciones_indemnizaciones__c, Cantidad_jornadas_preventa_y_oferta__c, Tiempo_responsabilidad_terceros__c,
            Grado_de_conocimiento_del_cliente__c, Informacion_formalizada_suficiente__c, FCV_de_contratos_actuales__c, 
            Estabilidad_financiera_cliente__c, Productos_clave_estan_en_porfolio__c, Partners_necesarios_identificados__c,
            Interrelacion_con_principales_decisores__c, Impacto_en_el_cliente__c, Estabilidad_organizacion_del_cliente__c,
            Existe_experiencia_previa_con_solucion__c, Grado_exigencia_SLA__c, Capacidad_para_cumplir_los_SLA__c,
            Grado_certeza_continuidad_plataforma__c, Es_moroso_con_el_Grupo__c, Existe_descripcion_tecnica__c,
            Consumo_capex_activos_fijos__c, facturacion_estandar__c, porcentage_indemnizacion_total_importe__c,
            Porcentaje_pasivo_laboral_importe__c, Estan_perfiles_clave_necesarios__c, porcentaje_penalizacion_resicion__c, 
            Personal_clave_del_cliente_identificado__c, Situacion_con_partners_favorable__c, Productos_terceros_cumplen_SLA__c,
            porcentaje_penalizacion_incumplimiento__c, Competencia__c, Cantidad_de_personas_a_incorporar__c,
            Pais__c, Sector__c, Tipo_de_oportunidad__c, Tipo_de_negocio__c, Responsable_comercial__c,
            Nivel_de_interlocucion_con_el_cliente__c, Es_cliente_actual_de_TEF__c, Ambito_donde_ya_es_cliente_con_TEF__c,
            NAV_12_meses_naturales__c, Valoracion_de_arquitectura_tecnica__c, Valoracion_de_detalle_de_SLA__c,
            Valoracion_de_relacion_de_entregables__c, Descripcion_de_los_entregables_del__c, Codigo_en_Sales_Force_del_proyecto__c, State__c,
            
            Es_Cliente_Actual_Desplegable__c, Alcance_del_proyecto_desplegable__c, Descripci_n_proyecto__c,
            Descripci_n_tecnica_desplegable__c, ofertas_terceros_desplegable__c, incorporar_personas_desplegable__c, Se_conoce_la_exigencia_de_SLAs__c,
            Hay_SLAs_definidos__c, Experiencia_previa_con_solucion_desple__c, Informacion_formalizada_suficiente_despl__c, Condiciones_previas_para_licitar_despleg__c,
            Estabilidad_financiera_cliente_desple__c, facturacion_estandar_desplegable__c, Existe_indemnizaci_n_por_rescisi_n__c, Productos_clave_estan_en_porfolio_desple__c,
            Estan_perfiles_clave_necesarios_desple__c, Personal_clave_del_cliente_desple__c, Partners_necesarios_identificados_desple__c, Situacion_con_partners_favorable_desple__c,
            Tienen_SLAs_los_servicios_que_portan__c
            
            FROM Big_deals_Survey__c
            WHERE Oportunidad__c = :BigDealOpportunity.Id
        ];
        
        if(existentSurveys.size() == 0) {
            Survey = new Big_deals_Survey__c(Oportunidad__c = BigDealOpportunity.id);
        }
        else {
            Survey = existentSurveys[0];
        }
        
        if(Survey.NAV_o_ingresos_proximos_12_meses__c == null){
            Survey.NAV_o_ingresos_proximos_12_meses__c = 0;
        }
    }
    
    public PageReference saveAndUnblock() {
        
        Big_deals_Survey__c tmpSurvey = new Big_deals_Survey__c();
        tmpSurvey = [select id from Big_deals_Survey__c where id = :Survey.id];
        
        
        Survey.state__c = 'Desbloqueado';
        tmpSurvey.state__c = 'Desbloqueado';
        
        
        update tmpSurvey;
        
        checkSurveyState();        
        return null;
    }  
    
    public PageReference saveAndBlock() {
        
        checkAllObligatoriFieldsAreComplete();
        checkSurveyState();
        return null;
    }
    
    public void checkAllObligatoriFieldsAreComplete(){
        
        missingObligatoriField = new List<String>();
        
        // No se puede validar en visual, regla de validacion, etc. para que pueda guardarce a la hora de ingresar un archivo adjunto.
        if(Survey.Descripci_n_proyecto__c  == null && BigDealOpportunity.Description == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + 'Breve descripción del proyecto' + '" ' + Label.inSeccion + ' "' + Label.General_information  +'". '  );  
        }
        
        if(Survey.fecha_de_entrega__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__fecha_de_entrega__c') + '" ' + Label.inSeccion + ' "' + Label.offer_schedule  +'". '  );  
        }
        
        if(Survey.NAV_o_ingresos_proximos_12_meses__c == null){ 
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Ingresos_durante_los_pr_ximos_12_meses_naturales_a_contar_desde_hoy + '" ' + Label.inSeccion + ' "' + Label.Economical_information  +'". '  ); 
        }
        
        if(Survey.Capex_a_o_en_curso__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Capex_a_o_en_curso__c') + '" ' + Label.inSeccion + ' "' + Label.Economical_information  +'". '  ); 
        }
        
        if(Survey.Lineas_implicadas__c == null){
            missingObligatoriField.add(Label.falta_Detallar_el_de_la_soluci_n); 
        }
        
        if(Survey.Duracion_del_proyecto__c == null){
            missingObligatoriField.add(Label.falta_Duraci_n_total_del_proyecto);  
        }
        
        if(Survey.Plazo_de_ejecucion__c == null){
            missingObligatoriField.add(Label.falta_Cu_l_es_el_plazo_de_ejecuci_n); 
        }
        
        if(Survey.incorporar_personas_desplegable__c == 'Si' && Survey.Cantidad_de_personas_a_incorporar__c == null){
            missingObligatoriField.add(Label.falta_N_de_personas);   
        }
        
        if(Survey.FTE_que_se_aportaran__c == null){
            missingObligatoriField.add(Label.falta_Concretar_el_n_mero_FTEs);   
        }
        
        if(Survey.FTE_terceros_requeridos__c == null){
            missingObligatoriField.add(Label.falta_Concretar_el_n_mero_de_FTEs_de_terceros);    
        }
        
        if(Survey.Cantidad_jornadas_preventa_y_oferta__c == null){
            missingObligatoriField.add(Label.falta_Calcular_el_n_de_jornadas);     
        }
        
        if(Survey.Actividades_durante_preventa__c == null){
            missingObligatoriField.add(Label.falta_Actividades_a_realizar_durante);      
        }
        
        if(Survey.Duracion_estimada_Preventa__c == null){
            missingObligatoriField.add(Label.falta_Duraci_n_estimada);       
        }
        
        if(Survey.Grado_de_conocimiento_del_cliente__c == null){
            missingObligatoriField.add(Label.falta_Cu_l_es_el_nivel_de_conocimiento);        
        }
        
        if(Survey.Interrelacion_con_principales_decisores__c == null){
            missingObligatoriField.add(Label.falta_Cu_l_es_el_grado_de_interrelaci_n);        
        }
        
        if(Survey.Impacto_en_el_cliente__c == null){
            missingObligatoriField.add(Label.falta_Cu_l_es_el_impacto_del_proyecto);         
        }
        
        if(Survey.Se_conoce_la_exigencia_de_SLAs__c == 'Si' && Survey.Hay_SLAs_definidos__c == 'Si' && Survey.Grado_exigencia_SLA__c == null){
            missingObligatoriField.add(Label.falta_Cu_l_es_el_grado_de_exigencia);          
        }
        
        if(Survey.Se_conoce_la_exigencia_de_SLAs__c == 'Si' && Survey.Hay_SLAs_definidos__c == 'Si' && Survey.Capacidad_para_cumplir_los_SLA__c == null){
            missingObligatoriField.add(Label.falta_Cu_nta_es_la_facilidad_para_TEF);            
        }
        
        if(Survey.Grado_certeza_continuidad_plataforma__c == null){
            missingObligatoriField.add(Label.falta_Cu_l_es_el_grado_de_fiabilidad_sobre);               
        }
        
        if(Survey.Importe_fianzas_depositar__c == null){
            missingObligatoriField.add(Label.falta_Cuantificar_el_importe_de_las_Fianzas);                 
        }
        
        if(Survey.Se_conoce_la_exigencia_de_SLAs__c == 'Si' && Survey.Hay_SLAs_definidos__c == 'Si' && Survey.porcentaje_penalizacion_incumplimiento__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Cuantificar_estimar_el_volumen_de_penalizaci_n_m_ximo_con_respecto_al_total_del + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );                     
        }
        
        if(Survey.porcentage_indemnizacion_total_importe__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Cuantificar_estimar_el_volumen_de_indemnizaci_n_m_ximo_con_respecto_al_total_del + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        
        if(Survey.Porcentaje_pasivo_laboral_importe__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Cuantificar_estimar_el_volumen_de_pasivo_laboral_m_ximo_con_respecto_al_total_de + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        /*
if(Survey.Fecha_estimada_del_fallo__c == null){
missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('Big_deals_Survey__c','Fecha_estimada_del_fallo__c') + '" ' + Label.inSeccion + ' "' + Label.offer_schedule  +'". '  );
}
*/
        if(Survey.Fecha_comienzo_de_contrato__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Fecha_comienzo_de_contrato__c') + '" ' + Label.inSeccion + ' "' + Label.offer_schedule  +'". '  ); 
        }
        if(Survey.Full_contract_value__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Full_contract_value__c') + '" ' + Label.inSeccion + ' "' + Label.Economical_information  +'". '  );  
        }
        if(Survey.NAV_12_meses_naturales__c == null){
            //Los textos de ayuda por algun motivo estan alternados entre "nav 12 meses naturales" con "nav o ingresos 12 meses naturales". 
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__NAV_o_ingresos_proximos_12_meses__c') + '" ' + Label.inSeccion + ' "' + Label.Economical_information  +'". '  );
        }
        if(Survey.Capex_total__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Capex_total__c') + '" ' + Label.inSeccion + ' "' + Label.Economical_information  +'". '  ); 
        }
        
        
        //Nuevos Obligatorios
        if(Survey.Pais__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + 'Pais' + '" ' + Label.inSeccion + ' "' + Label.General_information  +'". '  ); 
        }
        if(Survey.Codigo_en_Sales_Force_del_proyecto__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Codigo_en_Sales_Force_del_proyecto__c') + '" ' + Label.inSeccion + ' "' + Label.General_information  +'". '  ); 
        }
        if(Survey.Responsable_comercial__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Responsable_Comercial_en_Telef_nica + '" ' + Label.inSeccion + ' "' + Label.General_information  +'". '  ); 
        }
        if(Survey.Es_moroso_con_el_Grupo__c == null && survey.Es_Cliente_Actual_Desplegable__c == 'Si'){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Es_moroso_con_el_Grupo__c') + '" ' + Label.inSeccion + ' "' + Label.General_information  +'". '  ); 
        }        
        if(Survey.Alcance_del_proyecto_desplegable__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Alcance_definido__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.Descripcion_de_los_entregables_del__c == null && Survey.Alcance_del_proyecto_desplegable__c == 'Si'){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Deliberables_description + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.Descripci_n_tecnica_desplegable__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Existe_descripcion_tecnica__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.Descripci_n_tecnica_desplegable__c == 'Si' && Survey.arquitectura_tecnica__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__arquitectura_tecnica__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.incorporar_personas_desplegable__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Necesidad_de_incorporar_personas__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.Competencia__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Competencia__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.Se_conoce_la_exigencia_de_SLAs__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Se_conoce_la_exigencia_de_SLAs_o_se_prevee + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Se_conoce_la_exigencia_de_SLAs__c == 'Si' && Survey.Hay_SLAs_definidos__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Se_conoce_la_exigencia_de_SLAs_o_se_prevee + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Se_conoce_la_exigencia_de_SLAs__c == 'Si' && Survey.Hay_SLAs_definidos__c == 'Si' && Survey.SLA_Detalle__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Detallar_SLAs + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Informacion_formalizada_suficiente_despl__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Existe_informaci_n_formalizada_detallada_y_suficiente_para_elaborar_la_p + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Estabilidad_financiera_cliente_desple__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Ha_tenido_el_cliente_en_los_ltimos_5_a_os_o_tiene_actualmente_conurso_de_acree + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Existe_indemnizaci_n_por_rescisi_n__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Existe_indemnizaci_n_por_rescisi_n_anticipada_de_contrato + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Productos_clave_estan_en_porfolio_desple__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Dispone_TEF_en_su_porfolio_de_los_productos_clave_necesarios_para_el_proyecto + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Estan_perfiles_clave_necesarios_desple__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Existen_en_TEF_los_perfiles_clave_necesarios_para_el_proyecto_b_Y_b_est_n_ac + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Personal_clave_del_cliente_desple__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + Label.Esta_identificado_b_Y_b_disponible_el_personal_clave_del_cliente + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Partners_necesarios_identificados_desple__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Partners_necesarios_identificados__c') + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Situacion_con_partners_favorable_desple__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Situacion_con_partners_favorable__c') + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.Condiciones_previas_para_licitar_despleg__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Condiciones_previas_para_licitar__c') + '" ' + Label.inSeccion + ' "' + Label.Risks  +'". '  );   
        }
        if(Survey.ofertas_terceros_desplegable__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Necesario_desarrollar_oferta_con_tercero__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        if(Survey.ofertas_terceros_desplegable__c == 'Si' && Survey.Alcance_de_la_colaboracion_con_terceros__c == null){
            missingObligatoriField.add( Label.falta_completar + ' "' + obtenerTextoDeAyudaDe('certa_scp__Big_deals_Survey__c','certa_scp__Alcance_de_la_colaboracion_con_terceros__c') + '" ' + Label.inSeccion + ' "' + Label.Detail_of_reach  +'". '  );  
        }
        
        //if i dont have errors i can save.
        if(missingObligatoriField.size() == 0){
            
            if (Schema.sObjectType.Big_deals_Survey__c.fields.state__c.isUpdateable() && Schema.sObjectType.Big_deals_Survey__c.fields.state__c.isCreateable()){
                Survey.state__c = 'Bloqueado';
                save();
            }
            
        }
    }
    
    public String obtenerTextoDeAyudaDe (String nombreObjeto, String nombreCampo){
        
        //Mapa para conseguir los nombres de todos los campos de Big deals Survey.
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get(nombreObjeto); 
        
        String nombreDelCampoSeleccionado = '';
        
        if(leadSchema != null){
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            
            nombreDelCampoSeleccionado = fieldMap.get(nombreCampo).getDescribe().getinlineHelpText();
        }
        
        return nombreDelCampoSeleccionado;
    }
    
    public PageReference save() {
        try {
            upsert Survey;                  
        } catch(DmlException ex){
            ApexPages.addMessages(ex);
        }
        return null;
    }
}