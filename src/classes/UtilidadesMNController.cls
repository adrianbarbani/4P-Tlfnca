public class UtilidadesMNController {
    
    Public String idCuenta {get;set;}
    Public String idCuentaPrincipal {get;set;}
    public Account cuenta {get;set;}
    Public List<Account> listaQueContieneTodasLasCuentasHijas {get;set;}
    Public Boolean esCuentaPrincipal {get;set;}
    
    Public String seccion {get;set;}
    
    public UtilidadesMNController(){
        
        esCuentaPrincipal = false;
        seccion = 'section1';
        listaQueContieneTodasLasCuentasHijas = new List<Account>();
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        if(ApexPages.currentPage().getParameters().get('IdPadre') != null){
            idCuentaPrincipal = ApexPages.currentPage().getParameters().get('IdPadre');
        }else{
            idCuentaPrincipal = idCuenta;
            esCuentaPrincipal = true;
        }
        
        cuenta = [select id, name, (select id, name from ChildAccounts )
                  from account where id =: idCuentaPrincipal];
        
        if(cuenta.ChildAccounts.size()>0){
            listaQueContieneTodasLasCuentasHijas.addAll(cuenta.ChildAccounts);
        }
        
    }
    
    public void guardarAtributo(){
        seccion = Apexpages.currentPage().getParameters().get('interviewDate');
        system.debug(seccion);
    }
}