/*
Este archivo se ha generado y no es el código fuente actual para esta
clase global gestionada.
Este archivo de solo lectura muestra los métodos, las variables, las propiedades
y los constructores globales de la clase.
Para permitir al código compilar, todos los métodos devuelven nulo.
*/
global class BoardController {
    global BoardController() {

    }
    @RemoteAction
    global static List<taskfeed1__Template__c> GetTaskTemplates() {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.AgileTask> GetTemplateTasks(Id templateId, Id boardId, Id listId) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards InsertTemplateTasks(Id templateId, Id boardId, Id listId) {
        return null;
    }
    @RemoteAction
    global static String UploadAttachment(String filename, String fileContent, String id) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.Person> addContributor(String boardId, String userId) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards assignTaskContributor(String taskId, String userId, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards assignTask(String taskId, String userId, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards changeBoard(String taskId, String boardId, Decimal taskVersion, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards changeList(String taskId, String listId, Decimal taskVersion, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards completeTask(String taskId, Decimal version, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards createTask(String name, String boardId, String listId, String relatedRecordId, String relatedRelationshipName, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards createTask(String name, String boardId, String listId, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards deleteTask(String taskId, Decimal version, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.ResponseWrapper dismissNotification(taskfeed1.TaskHelper2.RequestWrapper reqWrapper) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.ResponseWrapper dismissNotifications(taskfeed1.TaskHelper2.RequestWrapper reqWrapper) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.BoardController.FilterSearchResult> filterTypeahead2(taskfeed1.TaskHelper2.CustomLabel customLabel, String qry, taskfeed1.TaskHelper2.Filters filters) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.BoardController.FilterSearchResult> filterTypeahead(taskfeed1.TaskHelper2.CustomLabel customLabel, String qry) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.BoardController.FilterSearchResult> filterTypeahead(taskfeed1.TaskHelper2.CustomLabel customLabel, String qry, taskfeed1.TaskHelper2.Filters filters) {
        return null;
    }
    @RemoteAction
    global static List<SObject> findSObjects(String obj, String qry, String addFields) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.Board> getBoardsForBoardSwitcher(taskfeed1.TaskHelper2.Filters filters) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards getChanges(taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.FeedItemWrapper> getCombinedFeed(taskfeed1.TaskHelper2.Filters filters) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.CustomLabel> getCustomLabels() {
        return null;
    }
    @RemoteAction
    global static Boolean getIsFollowing(Id parentId) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.Board> getMyBoards() {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.ResponseWrapper getNotifications(taskfeed1.TaskHelper2.RequestWrapper reqWrapper) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.CustomLabel> getRecommendedCustomLabels(taskfeed1.TaskHelper2.Filters filters) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards getTasks(taskfeed1.TaskHelper2.Filters filters, Decimal timestamp) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards inboxDragEnd(String listName, String taskIdCSV, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards logWork(taskfeed1.TaskHelper2.TimeLog newLog, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static List<taskfeed1.TaskHelper2.Person> removeContributor(String boardId, String userId) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards renameTask(String taskId, String newName, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards setDurationTask(String taskId, String durationString, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards setPredecessor(String taskId, String predecessorTaskId, Decimal taskVersion, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards taskDragEnd(String boardId, String listId, String taskIdCSV, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static Boolean toggleFollow(Id parentId) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards updateTaskStartEndDate2(String taskId, String startDateString, String endDateString, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards updateTaskStartEndDate3(String taskId, String action, String startDateString, String endDateString, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
    @RemoteAction
    global static taskfeed1.TaskHelper2.Boards updateTaskStartEndDate(String taskId, Long startTimeStamp, Long endTimeStamp, taskfeed1.TaskHelper2.Filters filters, Decimal timestamp, List<taskfeed1.TaskHelper2.BoardSummary> boardSummaries) {
        return null;
    }
global class FilterSearchResult {
}
}
