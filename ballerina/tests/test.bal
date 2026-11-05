// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.cc.email/v3" : "http://localhost:9090";
final string token = isLiveServer ? os:getEnv("CONSTANT_CONTACT_ACCESS_TOKEN") : "test_token";

final Client constantContact = check new ({
    auth: {token},
    httpVersion: isLiveServer ? http:HTTP_2_0 : http:HTTP_1_1
}, serviceUrl);

const string CONTACT_ID = "a1b2c3d4-0001-4e5f-8a9b-1c2d3e4f5a6b";
const string LIST_ID = "5f6a7b8c-1111-4222-8333-944455566677";
const string TAG_ID = "7a8b9c0d-2222-4333-8444-a55566677788";
const string CAMPAIGN_ID = "c1d2e3f4-4444-4555-8666-c77788899900";
const string ACTIVITY_ID = "e1f2a3b4-6666-4777-8888-e99900011122";

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetAccountSummary() returns error? {
    Customer response = check constantContact->getAccountSummary();
    test:assertTrue(response?.encodedAccountId !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListActivities() returns error? {
    Activities response = check constantContact->listActivities();
    test:assertTrue(response?.activities !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListContacts() returns error? {
    Contacts response = check constantContact->listContacts();
    test:assertTrue(response?.contacts !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListLists() returns error? {
    ContactListArray response = check constantContact->listLists();
    test:assertTrue(response?.lists !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListTags() returns error? {
    Tags response = check constantContact->listTags();
    test:assertTrue(response?.tags !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListCustomFields() returns error? {
    CustomFields response = check constantContact->listCustomFields();
    test:assertTrue(response?.customFields !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListEmailCampaigns() returns error? {
    PagedEmailCampaignResponse response = check constantContact->listEmailCampaigns();
    test:assertTrue(response?.campaigns !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListSegments() returns error? {
    SegmentsDTO response = check constantContact->listSegments();
    if !isLiveServer {
        test:assertTrue(response.segments.length() > 0);
    }
}

@test:Config {groups: ["mock_tests"]}
function testGetSegment() returns error? {
    SegmentDetail response = check constantContact->getSegment(101);
    test:assertEquals(response?.segmentId, 101);
}

@test:Config {groups: ["mock_tests"]}
function testGetContact() returns error? {
    ContactResource response = check constantContact->getContact(CONTACT_ID);
    test:assertEquals(response?.contactId, CONTACT_ID);
}

@test:Config {groups: ["mock_tests"]}
function testCreateContact() returns error? {
    ContactResource response = check constantContact->createContact({
        firstName: "Jane",
        lastName: "Doe",
        createSource: "Account",
        emailAddress: {address: "jane.doe@example.com", permissionToSend: "implicit"}
    });
    test:assertTrue(response?.contactId !is ());
}

@test:Config {groups: ["mock_tests"]}
function testUpdateContact() returns error? {
    ContactResource response = check constantContact->updateContact(CONTACT_ID, {
        firstName: "Jane",
        lastName: "Doe",
        updateSource: "Account"
    });
    test:assertEquals(response?.firstName, "Jane");
}

@test:Config {groups: ["mock_tests"]}
function testCreateOrUpdateContact() returns error? {
    ContactCreateOrUpdateResponse response = check constantContact->createOrUpdateContact({
        emailAddress: "jane.doe@example.com",
        firstName: "Jane",
        listMemberships: [LIST_ID]
    });
    test:assertTrue(response?.contactId !is ());
}

@test:Config {groups: ["mock_tests"]}
function testDeleteContact() returns error? {
    ContactResource created = check constantContact->createContact({
        firstName: "Temp",
        lastName: "Contact",
        createSource: "Account",
        emailAddress: {address: "temp.contact@example.org", permissionToSend: "implicit"}
    });
    error? response = constantContact->deleteContact(created?.contactId ?: CONTACT_ID);
    test:assertTrue(response is ());
}

@test:Config {groups: ["mock_tests"]}
function testGetList() returns error? {
    ContactList response = check constantContact->getList(LIST_ID);
    test:assertEquals(response.listId, LIST_ID);
}

@test:Config {groups: ["mock_tests"]}
function testCreateList() returns error? {
    ContactListPutPost response = check constantContact->createList({name: "Newsletter Subscribers", favorite: true});
    test:assertTrue(response.listId.length() > 0);
}

@test:Config {groups: ["mock_tests"]}
function testUpdateList() returns error? {
    ContactListPutPost response = check constantContact->updateList(LIST_ID, {name: "Newsletter Subscribers"});
    test:assertEquals(response.listId, LIST_ID);
}

@test:Config {groups: ["mock_tests"]}
function testDeleteList() returns error? {
    ContactListPutPost created = check constantContact->createList({name: "Temporary List"});
    ActivityDeleteListResponse response = check constantContact->deleteList(created.listId);
    test:assertTrue(response?.activityId !is ());
}

@test:Config {groups: ["mock_tests"]}
function testGetTag() returns error? {
    Tag response = check constantContact->getTag(TAG_ID);
    test:assertEquals(response?.tagId, TAG_ID);
}

@test:Config {groups: ["mock_tests"]}
function testCreateTag() returns error? {
    Tag response = check constantContact->createTag({name: "VIP Customer"});
    test:assertTrue(response?.tagId !is ());
}

@test:Config {groups: ["mock_tests"]}
function testDeleteTag() returns error? {
    Tag created = check constantContact->createTag({name: "Temporary Tag"});
    ActivityGeneric response = check constantContact->deleteTag(created?.tagId ?: TAG_ID);
    test:assertTrue(response.activityId.length() > 0);
}

@test:Config {groups: ["mock_tests"]}
function testCreateCustomField() returns error? {
    CustomField response = check constantContact->createCustomField({label: "Loyalty Level", 'type: "string"});
    test:assertTrue(response?.customFieldId !is ());
}

@test:Config {groups: ["mock_tests"]}
function testGetEmailCampaign() returns error? {
    EmailCampaign response = check constantContact->getEmailCampaign(CAMPAIGN_ID);
    test:assertEquals(response?.campaignId, CAMPAIGN_ID);
}

@test:Config {groups: ["mock_tests"]}
function testCreateEmailCampaign() returns error? {
    EmailCampaign response = check constantContact->createEmailCampaign({
        name: "Spring Sale Announcement",
        emailCampaignActivities: [
            {
                formatType: 5,
                fromName: "Acme Marketing",
                fromEmail: "marketing@example.com",
                replyToEmail: "reply@example.com",
                subject: "Spring Sale - 20% off everything",
                htmlContent: "<html><body><p>Spring sale is here.</p></body></html>"
            }
        ]
    });
    test:assertTrue(response?.campaignId !is ());
}

@test:Config {groups: ["mock_tests"]}
function testGetEmailCampaignActivity() returns error? {
    EmailCampaignActivity response = check constantContact->getEmailCampaignActivity(ACTIVITY_ID);
    test:assertEquals(response?.campaignActivityId, ACTIVITY_ID);
}
