public with sharing class ContactController {
        @AuraEnabled(cacheable=true)
        public static List<Contact> getContacts() {
          //  throw new AuraHandledException('Forced error');
            return [
                SELECT Id, Name,FirstName,LastName, Title, Email, Phone
                FROM Contact WITH SECURITY_ENFORCED
           ]; 
          // throw new AuraHandledException('Forced error');

          //first change

        }

    }

