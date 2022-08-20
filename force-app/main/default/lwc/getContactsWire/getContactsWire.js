import { LightningElement, api, wire } from 'lwc';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import getRelatedContacts from '@salesforce/apex/AccountController.getRelatedContacts';
const COLUMNS = [
    { label: 'First Name', fieldName: FIRST_NAME.fieldApiName, type: 'text' },
    { label: 'Last Name', fieldName: LAST_NAME.fieldApiName, type: 'text' }
];
export default class WireApexProperty extends LightningElement {
    @api recordId;
    @wire(getRelatedContacts, { accountId: '$recordId' })
    contacts;
}