// Onboards a new subscriber: finds or creates a contact list, adds the contact to it, and reads the contact back.

import ballerina/io;
import ballerinax/constantcontact;

configurable string accessToken = ?;
configurable string listName = ?;
configurable string contactEmail = ?;
configurable string contactFirstName = ?;
configurable string contactLastName = ?;

public function main() returns error? {
    constantcontact:Client cc = check new ({auth: {token: accessToken}});

    // Step 1: Reuse the list if it already exists, otherwise create it. Filtering by name
    // server-side finds the list without paging through every list in the account.
    constantcontact:ContactListArray existing = check cc->listLists(name = listName);
    constantcontact:ContactList[] lists = existing?.lists ?: [];
    string? listId = ();
    foreach constantcontact:ContactList l in lists {
        if l.name == listName {
            listId = l.listId;
            break;
        }
    }
    if listId is () {
        constantcontact:ContactListPutPost created = check cc->createList({name: listName, favorite: false});
        listId = created.listId;
        io:println("Created list: ", created.name);
    } else {
        io:println("Using existing list: ", listName);
    }
    string targetListId = check listId.ensureType();

    // Step 2: Create or update the contact and add it to the list.
    constantcontact:ContactCreateOrUpdateResponse upserted = check cc->createOrUpdateContact({
        emailAddress: contactEmail,
        firstName: contactFirstName,
        lastName: contactLastName,
        listMemberships: [targetListId]
    });
    string contactId = upserted?.contactId ?: "";
    if contactId == "" {
        return error("The contact ID was not returned by the API");
    }
    io:println("Contact ", upserted?.action ?: "processed", ": ", contactId);

    // Step 3: Read the contact back to confirm its list membership.
    constantcontact:ContactResource contact = check cc->getContact(contactId, include = "list_memberships");
    io:println("List memberships: ", contact?.listMemberships ?: []);
}
