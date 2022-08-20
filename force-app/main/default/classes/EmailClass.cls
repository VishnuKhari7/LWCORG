public class EmailClass {
    
    public static void sendEmail(){
        List<ContentDocumentLink> cdlList = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = 'a005i000003qzdnAAA'];
        system.debug('cdlList' + cdlList);
        List<ContentVersion> cvList = [SELECT VersionData, FileExtension FROM ContentVersion WHERE ContentDocumentId = :cdlList[0].ContentDocumentId AND IsLatest = true];
        system.debug('cvList' + cvList);
        Blob fileData = cvList[0].VersionData; // <= This step converts the version data into a blob for the attachment
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        Messaging.EmailFileAttachment emlAtt = new Messaging.EmailFileAttachment();
        emlAtt.setFilename('MyFile.' + cvList[0].FileExtension);
        emlAtt.setBody(fileData);
        attachments.add(emlAtt);
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set the recipient address
        message.setToAddresses(new String[] { 'akshaya.7896@gmail.com' });
        message.setSubject('Document Form Colleage');
        message.setPlainTextBody('PFA Document');
        message.setSenderDisplayName('PCET Colleage');
        // Attach files to the message
        message.setFileAttachments(attachments);
        //send email 
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
        } catch (Exception e) {
            system.debug(e);
        }
    
    }
    
}