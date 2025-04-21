public class OppBatchClass implements Database.Batchable<sObject>, Database.stateful{
    integer count = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id from Opportunity]);
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> opp){
        
    }
    
    public void finish(Database.BatchableContext bc){
        
    }

}