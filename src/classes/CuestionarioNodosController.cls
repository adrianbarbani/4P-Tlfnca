public class CuestionarioNodosController {

    Public String idCuenta {get;set;}
    Public String IdNodoPadre {get;set;}
    
    Public List<WrapperPregunta> wrppPreguntas {get;set;}
    Public List<SB_Cuenta_Solucion__c> soluciones {get;set;}
    Public List<SB_Cuenta_Interlocutor__c> interlocutores {get;set;}
    
    Public Set<SB_Cuenta_Pregunta__c> PosiblesPreguntasAInsertar {get;set;}
    
    Public List<Super_Ball_Nodo__c> todosLosNodos {get;set;}
    Public Super_Ball_Nodo__c nodoCentral {get; set;} 
    
    public CuestionarioNodosController(){
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        idNodoPadre = ApexPages.currentPage().getParameters().get('IdNodo');
        
        wrppPreguntas = new List<WrapperPregunta>();
        soluciones = new List<SB_Cuenta_Solucion__c>();
        interlocutores = new List<SB_Cuenta_Interlocutor__c>(); 
        todosLosNodos = new List<Super_Ball_Nodo__c>();
        PosiblesPreguntasAInsertar = new Set<SB_Cuenta_Pregunta__c>();
        
        
        system.debug(IdNodoPadre);
        system.debug(idCuenta);
        nodoCentral = [select id, name, Super_Ball_Arbol__r.Pais__c, Super_Ball_Arbol__r.Sector__c, Super_Ball_Arbol__r.name, posicion__c from Super_Ball_Nodo__c 
                       where id =: IdNodoPadre
                       order by posicion__c asc];
        
    }
    
    public void traigoRamasDelNodoOLasGenero(){
        
        //Me traigo las preguntas, los interlocuores, las soluciones y los recursos que hay cargados en administracion.
        List<Super_Ball_Nodo__c> hijosDeNodos = [select id, Nodo_Padre__c, name, Descripci_n__c, posicion__c,
                                                 (select id, Pregunta__c, Super_Ball_Nodo__c, posicion__c,
                                                  Dependencia_Si__c, Dependencia_No__c,  Dependencia_Si__r.pregunta__c, Dependencia_No__r.pregunta__c 
                                                  from Super_Ball_Preguntas__r 
                                                  where esHija__c != true order by posicion__c asc),
                                                 (select id, name, Super_Ball_Nodo__c, posicion__c from Super_Ball_Soluciones__r order by posicion__c asc),
                                                 (select id, name, contacto__c, Super_Ball_Nodo__c from Super_Ball_Interlocutores__r order by createdDate asc),
                                                 (select id, name, link__c, Super_Ball_Nodo__c from Super_Ball_Recursos__r order by createdDate asc)
                                                 from Super_Ball_Nodo__c 
                                                 where Nodo_Padre__c =: idNodoPadre
                                                 order by posicion__c asc];
     
        
        //Por cada uno de estos 3, los recursos no cuenta, genero su igual pero a nivel cuenta, no a nivel global.
        for(Super_Ball_Nodo__c hijoNodo: hijosDeNodos){  
            
            for(Super_Ball_Pregunta__c pregunta: hijoNodo.Super_Ball_Preguntas__r){
                
                SB_Cuenta_Pregunta__c preguntaDependenciaSi;
                if(pregunta.Dependencia_Si__c != null){
                    preguntaDependenciaSi = new SB_Cuenta_Pregunta__c();
                    preguntaDependenciaSi.pregunta__c = pregunta.Dependencia_Si__r.pregunta__c;
                    preguntaDependenciaSi.esHija__c = true;
					preguntaDependenciaSi.cuenta__c = idCuenta;
                    preguntaDependenciaSi.Super_Ball_Nodo__c = hijoNodo.id;
                    preguntaDependenciaSi.Super_Ball_Pregunta__c = pregunta.Dependencia_Si__c;
                }
                
                SB_Cuenta_Pregunta__c preguntaDependenciaNo;
                if(pregunta.Dependencia_No__c != null){
                    preguntaDependenciaNo = new SB_Cuenta_Pregunta__c();
                    preguntaDependenciaNo.pregunta__c = pregunta.Dependencia_No__r.pregunta__c;
                    preguntaDependenciaNo.esHija__c = true;
					preguntaDependenciaNo.cuenta__c = idCuenta;
                    preguntaDependenciaNo.Super_Ball_Nodo__c = hijoNodo.id;
                    preguntaDependenciaNo.Super_Ball_Pregunta__c = pregunta.Dependencia_No__c;
                }
                
                SB_Cuenta_Pregunta__c preguntaPrincipal = new SB_Cuenta_Pregunta__c();
                preguntaPrincipal.pregunta__c = pregunta.pregunta__c;
                preguntaPrincipal.esHija__c = false;
                preguntaPrincipal.cuenta__c = idCuenta;
                preguntaPrincipal.posicion__c = pregunta.posicion__c;
                preguntaPrincipal.Super_Ball_Nodo__c = hijoNodo.id;
                preguntaPrincipal.Super_Ball_Pregunta__c = pregunta.id;
                
                WrapperPregunta preguntawpp = new WrapperPregunta(preguntaPrincipal);
                if(preguntaDependenciaSi != null){
                    preguntawpp.DependenciaSi = preguntaDependenciaSi;
                    PosiblesPreguntasAInsertar.add(preguntaDependenciaSi);
                    preguntaPrincipal.DependenciaSi__c = preguntaDependenciaSi.id;
                    system.debug(preguntaPrincipal.pregunta__c);
                    system.debug(preguntaDependenciaSi.id);
                }
                if(preguntaDependenciaNo != null){
                    preguntawpp.DependenciaNo = preguntaDependenciaNo;
                    PosiblesPreguntasAInsertar.add(preguntaDependenciaNo);
                    preguntaPrincipal.DependenciaNo__c = preguntaDependenciaNo.id;
                } 
                
                wrppPreguntas.add(preguntawpp);
                PosiblesPreguntasAInsertar.add(preguntaPrincipal);
            }
            
            system.debug(wrppPreguntas);
            
            for(Super_Ball_Solucion__c solucion: hijoNodo.Super_Ball_Soluciones__r){
                
                SB_Cuenta_Solucion__c solucionPrincipal = new SB_Cuenta_Solucion__c();
                solucionPrincipal.name = solucion.name;
                solucionPrincipal.posicion__c = solucion.posicion__c;
                solucionPrincipal.Super_Ball_Nodo__c = hijoNodo.id;
                solucionPrincipal.cuenta__c = idCuenta;
                solucionPrincipal.Super_Ball_Solucion__c = solucion.id;
                
                soluciones.add(solucionPrincipal);
            }
            
            for(Super_Ball_Interlocutor__c interlocutor: hijoNodo.Super_Ball_Interlocutores__r){
               
                SB_Cuenta_Interlocutor__c interlocutorPrincipal = new SB_Cuenta_Interlocutor__c();
                interlocutorPrincipal.name = interlocutor.name;
                interlocutorPrincipal.Super_Ball_Nodo__c = hijoNodo.id;
                interlocutorPrincipal.cuenta__c = idCuenta;
                interlocutorPrincipal.Super_Ball_Interlocutor__c = interlocutor.id;
                
                interlocutores.add(interlocutorPrincipal);
            }

        }
        
        comprueboQueNodosExisten();
    }
    
    public void comprueboQueNodosExisten(){
        
        //Me traigo las preguntas, los interlocutores, las soluciones y los recursos que hay cargados a nivel cuenta, para ese nodo, menos los recursos.
        List<Super_Ball_Nodo__c> hijosDeNodos = [select id, Nodo_Padre__c, name, Descripci_n__c,
                                                 (select id, Pregunta__c, Super_Ball_Nodo__c, posicion__c,
                                                  DependenciaSi__c, DependenciaNo__c,  DependenciaSi__r.pregunta__c, DependenciaNo__r.pregunta__c, Super_Ball_Pregunta__c 
                                                  from SB_Cuenta_Preguntas__r order by posicion__c asc),
                                                 (select id, name, Super_Ball_Nodo__c, Super_Ball_Solucion__c, posicion__c from SB_Cuenta_Soluciones__r order by posicion__c asc),
                                                 (select id, contacto__c, Super_Ball_Nodo__c, Super_Ball_Interlocutor__c from SB_Cuenta_Interlocutores__r order by createdDate asc),
                                                 (select id, name, link__c, Super_Ball_Nodo__c from Super_Ball_Recursos__r order by createdDate asc)
                                                 from Super_Ball_Nodo__c 
                                                 where Nodo_Padre__c =: idNodoPadre
                                                 order by createdDate asc];
        
        Set<SB_Cuenta_Pregunta__c> preguntasSet = new Set<SB_Cuenta_Pregunta__c>(); 
        Set<SB_Cuenta_Solucion__c> solucionesSet = new Set<SB_Cuenta_Solucion__c>(soluciones);
        Set<SB_Cuenta_Interlocutor__c> interlocutoresSet = new Set<SB_Cuenta_Interlocutor__c>(interlocutores);
        
        
        List<SB_Cuenta_Solucion__c> solucionesModificacadasAActualizar = new List<SB_Cuenta_Solucion__c>();
        List<SB_Cuenta_Pregunta__c> preguntasModificacadasAActualizar = new List<SB_Cuenta_Pregunta__c>();
        
        for(Super_Ball_Nodo__c hijoNodo: hijosDeNodos){
                
            for(SB_Cuenta_Solucion__c solucionNodoCreada: hijoNodo.SB_Cuenta_Soluciones__r){
                for(SB_Cuenta_Solucion__c posibleSolucionAInsertar: soluciones){
                    if(solucionNodoCreada.Super_Ball_Solucion__c == posibleSolucionAInsertar.Super_Ball_Solucion__c){
                        solucionesSet.remove(posibleSolucionAInsertar);
                        
                        if(solucionNodoCreada.posicion__c != posibleSolucionAInsertar.posicion__c || solucionNodoCreada.name != posibleSolucionAInsertar.name){
                            solucionNodoCreada.posicion__c = posibleSolucionAInsertar.posicion__c;
                            solucionNodoCreada.name = posibleSolucionAInsertar.name;
                            solucionesModificacadasAActualizar.add(solucionNodoCreada);
                        }
                    }
                }
            }
            
            for(SB_Cuenta_Interlocutor__c interlocutorNodoCreado: hijoNodo.SB_Cuenta_Interlocutores__r){
                for(SB_Cuenta_Interlocutor__c posibleInterlocutorAInsertar: interlocutores){
                    if(interlocutorNodoCreado.Super_Ball_Interlocutor__c == posibleInterlocutorAInsertar.Super_Ball_Interlocutor__c){
                        interlocutoresSet.remove(posibleInterlocutorAInsertar);
                    }
                }
            }
            
            // ya existe una pregunta asociada a nivel cuenta? si no inserto la que no.
            for(SB_Cuenta_Pregunta__c PreguntaCreada: hijoNodo.SB_Cuenta_Preguntas__r){
                for(WrapperPregunta posiblePreguntaAInsertar: wrppPreguntas){

                    if(PreguntaCreada.Super_Ball_Pregunta__c == posiblePreguntaAInsertar.pregunta.Super_Ball_Pregunta__c){
                        PosiblesPreguntasAInsertar.remove(posiblePreguntaAInsertar.pregunta);
                        
                        if(PreguntaCreada.posicion__c != posiblePreguntaAInsertar.pregunta.posicion__c){
                            PreguntaCreada.posicion__c = posiblePreguntaAInsertar.pregunta.posicion__c;
                            preguntasModificacadasAActualizar.add(PreguntaCreada);
                        }
                    }
                    
                    if(posiblePreguntaAInsertar.DependenciaSi != null){
                        if(PreguntaCreada.Super_Ball_Pregunta__c == posiblePreguntaAInsertar.DependenciaSi.Super_Ball_Pregunta__c){
                            PosiblesPreguntasAInsertar.remove(posiblePreguntaAInsertar.DependenciaSi);
                        }
                    }
                    
                    if(posiblePreguntaAInsertar.DependenciaNo != null){
                        if(PreguntaCreada.Super_Ball_Pregunta__c == posiblePreguntaAInsertar.DependenciaNo.Super_Ball_Pregunta__c){
                            PosiblesPreguntasAInsertar.remove(posiblePreguntaAInsertar.DependenciaNo);
                        }
                    }
                    
                }
            }
        }
        
        system.debug(solucionesSet);
        system.debug(PosiblesPreguntasAInsertar);
        system.debug(interlocutoresSet);
        
        insert new List<SB_Cuenta_Solucion__c>(solucionesSet);
        insert new List<SB_Cuenta_Pregunta__c>(PosiblesPreguntasAInsertar);
        insert new List<SB_Cuenta_Interlocutor__c>(interlocutoresSet);
        
        update solucionesModificacadasAActualizar;
        update preguntasModificacadasAActualizar;
        
        List<Super_Ball_Nodo__c> nodosConPreguntasPadre = [select id, Nodo_Padre__c, name, Descripci_n__c, posicion__c,
                                                           (select id, Pregunta__c, Super_Ball_Nodo__c,
                                                            DependenciaSi__c, DependenciaNo__c, respuesta__c, DependenciaSi__r.pregunta__c, DependenciaNo__r.pregunta__c,
                                                            Super_Ball_Pregunta__c 
                                                            from SB_Cuenta_Preguntas__r 
                                                            where esHija__c != true order by posicion__c asc)
                                                           from Super_Ball_Nodo__c 
                                                           where Nodo_Padre__c =: idNodoPadre
                                                           order by posicion__c asc];
        
        List<SB_Cuenta_Pregunta__c> preguntasPadre = new List<SB_Cuenta_Pregunta__c>();
        for(Super_Ball_Nodo__c nodo: nodosConPreguntasPadre){
            preguntasPadre.addAll(nodo.SB_Cuenta_Preguntas__r);
        }
        
        List<Super_Ball_Nodo__c> nodosConPreguntashijas = [select id, Nodo_Padre__c, name, Descripci_n__c, posicion__c,
                                                           (select id, Pregunta__c, Super_Ball_Nodo__c, posicion__c,
                                                            DependenciaSi__c, DependenciaNo__c, respuesta__c, DependenciaSi__r.pregunta__c, DependenciaNo__r.pregunta__c,
                                                            Super_Ball_Pregunta__c 
                                                            from SB_Cuenta_Preguntas__r 
                                                            where esHija__c = true order by posicion__c asc)
                                                           from Super_Ball_Nodo__c 
                                                           where Nodo_Padre__c =: idNodoPadre
                                                           order by posicion__c asc];
        
        List<SB_Cuenta_Pregunta__c> preguntasHija = new List<SB_Cuenta_Pregunta__c>();
        for(Super_Ball_Nodo__c nodo: nodosConPreguntashijas){
            preguntasHija.addAll(nodo.SB_Cuenta_Preguntas__r);
        }
        
        for(WrapperPregunta preguntaWpp: wrppPreguntas){
            for(SB_Cuenta_Pregunta__c pregunta: preguntasPadre){
                system.debug(pregunta.pregunta__c);
                if(preguntaWpp.pregunta.Super_Ball_Pregunta__c == pregunta.Super_Ball_Pregunta__c){
                    preguntaWpp.pregunta = pregunta;
                }
            }
        }
        
        for(WrapperPregunta preguntaWpp: wrppPreguntas){
            for(SB_Cuenta_Pregunta__c pregunta: preguntasHija){
                if(preguntaWpp.DependenciaSi.Super_Ball_Pregunta__c == pregunta.Super_Ball_Pregunta__c){
                    preguntaWpp.DependenciaSi = pregunta;
                }
                if(preguntaWpp.DependenciaNo.Super_Ball_Pregunta__c == pregunta.Super_Ball_Pregunta__c){
                    preguntaWpp.DependenciaNo = pregunta;
                }
            }
        }
        
        List<SB_Cuenta_Pregunta__c> preguntasPadresAActualizar = new List<SB_Cuenta_Pregunta__c>();
        for(WrapperPregunta preguntaWpp: wrppPreguntas){
            if(preguntaWpp.DependenciaSi != null){
                preguntaWpp.pregunta.DependenciaSi__c = preguntaWpp.DependenciaSi.id;
            }
            
            if(preguntaWpp.DependenciaNo != null){
                preguntaWpp.pregunta.DependenciaNo__c = preguntaWpp.DependenciaNo.id;
            }
            preguntasPadresAActualizar.add(preguntaWpp.pregunta);
        }
        
        system.debug(preguntasPadresAActualizar);
        update preguntasPadresAActualizar;
        
        TraerInfoDeCadaNodo();
    }
    
    public void TraerInfoDeCadaNodo(){
        TodosLosNodos = [select id, Nodo_Padre__c, name, Descripci_n__c, posicion__c, 
                         (select id, Pregunta__c, Super_Ball_Nodo__c, posicion__c,
                          DependenciaSi__c, DependenciaNo__c, respuesta__c, DependenciaSi__r.pregunta__c, DependenciaNo__r.pregunta__c,
                          Super_Ball_Pregunta__c, DependenciaSi__r.respuesta__c, DependenciaNo__r.respuesta__c 
                          from SB_Cuenta_Preguntas__r 
                          where esHija__c != true order by posicion__c asc),
                         (select id, name, Super_Ball_Nodo__c, estado__c, Super_Ball_Solucion__c, posicion__c from SB_Cuenta_Soluciones__r order by posicion__c asc),
                         (select id, name, contacto__c, Super_Ball_Nodo__c, Super_Ball_Interlocutor__c from SB_Cuenta_Interlocutores__r order by createdDate asc),
                         (select id, name, link__c, Super_Ball_Nodo__c from Super_Ball_Recursos__r order by createdDate asc)
                         from Super_Ball_Nodo__c 
                         where Nodo_Padre__c =: idNodoPadre
                         order by posicion__c asc];
    }
    
    public void guardar(){
        
        system.debug('entre al guardar');
        
        List<SB_Cuenta_Solucion__c> solucionesAGuardar = new List<SB_Cuenta_Solucion__c>();
        List<SB_Cuenta_Interlocutor__c> interlocutoresAGuardar = new List<SB_Cuenta_Interlocutor__c>();
        List<SB_Cuenta_Pregunta__c> preguntasAGuardar = new List<SB_Cuenta_Pregunta__c>();
        
        for(Super_Ball_Nodo__c nodo: todosLosNodos){
            solucionesAGuardar.addAll(nodo.SB_Cuenta_Soluciones__r);
            interlocutoresAGuardar.addAll(nodo.SB_Cuenta_Interlocutores__r);
            preguntasAGuardar.addAll(nodo.SB_Cuenta_Preguntas__r);
        }
        
        update solucionesAGuardar;
        update interlocutoresAGuardar;
        update preguntasAGuardar;
        
        List<SB_Cuenta_Pregunta__c> subPreguntas = new List<SB_Cuenta_Pregunta__c>();
        
        
        for(SB_Cuenta_Pregunta__c pregunta: preguntasAGuardar){
            
            if(pregunta.DependenciaSi__c != null){
                SB_Cuenta_Pregunta__c subPre = new SB_Cuenta_Pregunta__c();
                subPre.id = pregunta.DependenciaSi__c;
                subPre.respuesta__c = pregunta.DependenciaSi__r.respuesta__c;
                subPreguntas.add(subPre);
            }
            
            if(pregunta.DependenciaNo__c != null){
                SB_Cuenta_Pregunta__c subPre2 = new SB_Cuenta_Pregunta__c();
                subPre2.id = pregunta.DependenciaNo__c;
                subPre2.respuesta__c = pregunta.DependenciaNo__r.respuesta__c;
                subPreguntas.add(subPre2);
            }
        }
        
        update subPreguntas;
    }
    
    public void renderizar(){
        system.debug('as');
    }
    
    public PageReference irAMapaDeLaCuenta(){
        
        String url = Page.PruebaVis.getURL();
        return new PageReference (url + '?id=' + idCuenta+'&idNodo='+IdNodoPadre);
    }
    
    public PageReference irAMenu(){
        
        String url = Page.PantallaPrincipalPowerBalls.getURL();
        return new PageReference (url + '?id=' + idCuenta); 
    }
//================================================
    
    Public Class WrapperPregunta{
        
        public SB_Cuenta_Pregunta__c pregunta{get;set;}
        public SB_Cuenta_Pregunta__c DependenciaSi{get;set;}
        public SB_Cuenta_Pregunta__c DependenciaNo{get;set;}
        
        public WrapperPregunta(SB_Cuenta_Pregunta__c preguntaPrincipal){
            pregunta = preguntaPrincipal;
        }
    }
}