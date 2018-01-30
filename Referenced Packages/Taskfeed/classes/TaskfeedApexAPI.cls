/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
global class TaskfeedApexAPI {
    global TaskfeedApexAPI() {

    }
    global static List<taskfeed1__List__c> GetListsFromTemplate(Blob blobBody, Id boardId) {
        return null;
    }
    global static List<taskfeed1__List__c> GetListsFromTemplate(Document doc, Id boardId) {
        return null;
    }
    global static List<taskfeed1__List__c> GetListsFromTemplate(Id attachmentId, Id boardId) {
        return null;
    }
    global static List<taskfeed1__List__c> GetListsFromTemplate(String templateName, Id boardId) {
        return null;
    }
    global static List<taskfeed1__Task__c> GetTasksFromTemplate(Attachment attach, Id boardId, Id listId) {
        return null;
    }
    global static List<taskfeed1__Task__c> GetTasksFromTemplate(Blob blobBody, Id boardId, Id listId) {
        return null;
    }
    global static List<taskfeed1__Task__c> GetTasksFromTemplate(Document doc, Id boardId, Id listId) {
        return null;
    }
    global static List<taskfeed1__Task__c> GetTasksFromTemplate(Id attachmentId, Id boardId, Id listId) {
        return null;
    }
    global static List<taskfeed1__Task__c> GetTasksFromTemplate(String documentName, Id boardId, Id listId) {
        return null;
    }
    global static void ShareBoard(Map<Id,List<Id>> mBoardToUserIds) {

    }
    global static void archiveTasks(List<taskfeed1__Task__c> tasks) {

    }
    global static void execEmailDailySummaryBatch() {

    }
    global static void execInboxDueDateBatch() {

    }
    global static void execTaskContributorMigrationBatch() {

    }
    global static void scheduleEmailDailySummaryBatch() {

    }
    global static void scheduleInboxDueDateBatch() {

    }
    global static void scheduleTaskArchiveBatch() {

    }
}
