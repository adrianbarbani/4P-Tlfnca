public class FiscalPeriodUtils {
    public static Date getFiscalYearEndDate() {
        FiscalYearSettings[] fys = [Select EndDate From FiscalYearSettings Where StartDate <= TODAY and EndDate >= TODAY];
        if (fys.size()>0) {
            return fys[0].EndDate;
        } else {
            return getFiscalYearEndDateFromStartMonth([select FiscalYearStartMonth from Organization where id=:Userinfo.getOrganizationId()].FiscalYearStartMonth);
        }
    }
    public static Date getFiscalYearEndDateFromStartMonth(Integer FiscalYearStartMonth) {
        Date fiscalYearEndDate;
        
        if(system.today().month() >= FiscalYearStartMonth) {
            fiscalYearEndDate = date.newinstance(system.today().year()+ 1, FiscalYearStartMonth, 1).addDays(-1);
        } else {
            fiscalYearEndDate = date.newinstance(system.today().year(), FiscalYearStartMonth, 1).addDays(-1);
        }
        return fiscalYearEndDate;
    }
}