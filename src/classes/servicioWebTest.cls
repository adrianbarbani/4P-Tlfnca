global class servicioWebTest {

    webService static Respuesta llamado(String a){
        Respuesta p = new Respuesta();
        p.unaRespuesta = a;
        return p;
    }
    
    global class respuesta{
        webservice string unaRespuesta {get;set;}
    }
}