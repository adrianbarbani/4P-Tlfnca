public class accountSCPFullReportNew {
    
    public Account account { get; set; }
    
    /* Account Team */
    public List<Account_Team_Member__c> TeamMembers {get;set;}    
    
    /* Industry Trends */
    public List<ExtendedRegion> Regions {get;set;}
    
    /* Strategic Context */
    public List<Account> globalStrategicContext { get; set; }
    public List<Strategic_Initiative__c>  localStrategicInitiatives { get; set; }
    public List<Strategic_Initiative__c>  globalStrategicInitiatives { get; set; }
    public List<String> globalBuyingCriteria {get;set;}

    /* KPI */
    public List <ExtendedKPI> Data {get;set;}    
    public List <ExtendedKPI> globalData {get;set;} 
    public Integer year {get;set;}
    
    /* Overall Relationship */
    public List<Account_Competitor__c> newCompetitors { get; set; }
    
    /* Historical Business Window */
    public PastActivity__c thisyear {get;set;}
    public PastActivity__c lastyear {get;set;}
    public PastActivity__c last2year {get;set;}
    
    /* Review of Current Contracts */
    public List<Contract> contracts {get;set;}
    public List<Contract> competitors_contracts {get;set;}
    
    /* Value Proposition Business Support */
    //public List<accountIndustryTrends.Owrap> oppsList {get;set;}
    
    /* Outlook Revenue and Sales */
    public Outlok_Plan_Comercial__c total_opc { get; set; }
 
    /* SweetSpot */
    public List<ValueChainWrapper> valueChainWrapperList {get;set;}
    public List<CapabilityWrapper> capabilityWrapperList {get;set;}    
    
    public accountSCPFullReportNew() {
        this.account = [Select id, name, Strategic_Context__c, Strategic_Context_Last_Update__c, Buying_Criteria__c, 
                        Brand_Strengths__c, Products_Services_Strengths__c, People_Strengths__c, Other_Strengths__c,
                        Brand_weakness__c, Products_Services_weakness__c, People_weakness__c, Other_weakness__c,
                        Brand_Opportunities__c, Products_Services_Opportunities__c, People_Opportunities__c, Other_Opportunities__c,
                        Brand_threats__c, Products_Services_threats__c, People_threats__c, Other_threats__c,
                        CSAT_Unit__c, CSAT_Second_To_Last_Year__c, CSAT_Last_Year__c, CSAT_Current_Year__c 
                        from account where id = :ApexPages.currentPage().getParameters().get('Id')];
        initIndustryTrends();
        initStrategicContext();
        initKPI();
        initOverallRelationship();
        initHistoricalBusiness();
        initCurrentContracts();
        initValuePropositionBusinessSupport();
        initSweetSpot();        
    }
    
    private void initIndustryTrends() {
        regions = (new accountIndustryTrends()).regions;    
    }
    
    private void initStrategicContext() {
        accountStrategicContextWindow ascw = new accountStrategicContextWindow(); 
        globalStrategicContext = ascw.globalStrategicContext;   
        localStrategicInitiatives = ascw.localStrategicInitiatives;
        globalStrategicInitiatives = ascw.globalStrategicInitiatives;
        globalBuyingCriteria = ascw.globalBuyingCriteria;       
    }
    
    private void initKPI() {
        AccountKPIWindow akw = new AccountKPIWindow();
        Data = akw.Data;
        //globalData = akw.globalData;   
        year = akw.year;        
    }
    
    private void initOverallRelationship() {
        newCompetitors = (new accountOverallRelationshipWindow()).newCompetitors;   
    }
    
    private void initHistoricalBusiness() {
        accountHistoricalBusinessWindow ahbw = new accountHistoricalBusinessWindow();
        thisyear = ahbw.thisyear;       
        lastyear = ahbw.lastyear;       
        last2year = ahbw.last2year;         
    }
    
    private void initCurrentContracts() {
        this.contracts = [select id, ContractNumber, description, StartDate, ContractTerm, EndDate, mrc__c, fcv__c, competitorName__c, isCompetitorContract__c from Contract where accountid = :account.id and isCompetitorContract__c = false];
        this.competitors_contracts = [select id, ContractNumber, description, StartDate, ContractTerm, EndDate, mrc__c, fcv__c, competitorName__c, isCompetitorContract__c from Contract where accountid = :account.id and isCompetitorContract__c = true];
    }
    
    private void initValuePropositionBusinessSupport() {
        //oppsList = (new accountIndustryTrends()).oppsList;
    }    

    private void initSweetSpot() {
         accountValueChainTableController avtc = new accountValueChainTableController();
         valueChainWrapperList = avtc.getValueChainWrapperList(); 
         
         accountCapabilityMatrixController accm = new accountCapabilityMatrixController();
         capabilityWrapperList = accm.getCapabilityWrapperList(); 

    }
}