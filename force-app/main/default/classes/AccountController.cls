public class AccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecords(String recordType, String picklistField, String picklistValue) {
        String query = 'SELECT Id, Name, Industry, Type, IsActive FROM Account WHERE RecordType.Name = :recordType';
        
        // Check if picklist field and value are provided
        if (!String.isBlank(picklistField) && !String.isBlank(picklistValue)) {
            query += ' AND ' + picklistField + ' = \'' + picklistValue + '\'';
        }
        
        return Database.query(query);
    }

}