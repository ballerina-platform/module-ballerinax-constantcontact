_Author_:  Dimuthu Madushan \
_Created_: 2026/09/30 \
_Updated_: 2026/10/05 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Constant Contact.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/constantcontact/constantcontact/3.0.193/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. **Swagger 2.0 converted to OpenAPI 3.0**

   The source is a Swagger 2.0 document. `bal openapi flatten` and `bal openapi align` convert it to OpenAPI 3.0 and set the server URL to `https://api.cc.email/v3` (the `host` and `basePath` of the source).

2. **Removed the binary `example` on the `file` property of the contact CSV import body**

   `flatten` emitted the source's `x-example` as a YAML `!!binary` value, which cannot be serialized to JSON. The `x-example` was removed from the `file` form parameter of `POST /activities/contacts_file_import` in `docs/spec/openapi.yaml`.

3. **Stable operation IDs**

   Operation IDs such as `retrieveEmailCampaignUsingGET`, `postTagAddContact` and `getEvent_2` were replaced by `list*`/`get*`/`create*`/`update*`/`delete*` names (for example `listEmailCampaigns`, `createTagAddContactsActivity`, `getEvent`). The decisions are persisted in `ai-mappings.json`, keyed by path and method. Schema names were kept as they are in the source.

4. **Descriptions for generic success responses**

   103 success responses on 98 operations were described only as `Request successful`, `Request was successful`, `OK`, `Accepted` or `successful operation`. These descriptions become the `# + return` documentation of the client methods, so they were rewritten in `docs/spec/openapi.yaml` to describe what is returned. Details the originals carried, such as `queued for processing` on the bulk activity endpoints and the legacy (V7) conversion note on `createEmailCampaign`, were kept.

   <details>
   <summary>Rewritten descriptions</summary>

   | Operation | Status | Original | Rewritten |
   |---|---|---|---|
   | `cancelPartnerAccountPlan` | 200 | Request successful | The billing plan cancellation details |
   | `createAccountEmailAddress` | 201 | Request successful. | The added account email address |
   | `createAutomation` | 201 | Request successful | The created automation |
   | `createContactDeleteActivity` | 201 | Request successful. Activity queued for processing. | The bulk contact delete activity, queued for processing |
   | `createContactsExport` | 201 | Request successful, queued for processing. | The contact export activity, queued for processing |
   | `createCustomFieldDeleteActivity` | 201 | Request successful. Activity queued for processing. | The custom field delete activity, queued for processing |
   | `createEmailCampaign` | 200 | Request successful. NOTE: If you created an email campaign using a legacy (V7) format, Constant Contact successfully converted it to the newer custom code format. | The created email campaign. A campaign created in the legacy (V7) format is converted to the custom code format |
   | `createEmailCampaignAbTest` | 201 | Request successful. | The created A/B test |
   | `createEmailSchedule` | 201 | Request successful. | The created schedule |
   | `createListAddContactsActivity` | 201 | Request successful. Activity queued for processing. | The add-to-lists activity, queued for processing |
   | `createListDeleteActivity` | 201 | Request successful. Activity queued for processing. | The list delete activity, queued for processing |
   | `createListRemoveContactsActivity` | 201 | Request successful. Activity queued for processing. | The remove-from-lists activity, queued for processing |
   | `createNonOpenerResend` | 201 | Request successful. | The created resend to non-openers activity |
   | `createPartnerAccount` | 201 | Request successful. | The provisioned client account |
   | `createPartnerSsoUser` | 201 | Request successful. | The SSO user was created under the client account |
   | `createPhysicalAddress` | 201 | Request successful | The created physical address |
   | `createSocialPost` | 200 | OK | The created social media post |
   | `createTag` | 201 | Request Successful | The created tag |
   | `createTagAddContactsActivity` | 201 | Request successful. Activity queued for processing. | The tagging activity, queued for processing |
   | `createTagDeleteActivity` | 201 | Request successful. Activity queued for processing. | The tag delete activity, queued for processing |
   | `createTagRemoveContactsActivity` | 201 | Request successful. Activity queued for processing. | The tag removal activity, queued for processing |
   | `deleteContact` | 204 | Request successful; No content returned | The contact was deleted; no content is returned |
   | `deleteCustomField` | 204 | Request successful; No content returned | The custom field was deleted; no content is returned |
   | `deleteList` | 202 | Accepted | Request accepted; the list delete activity status |
   | `deleteNonOpenerResend` | 204 | Request successful. | The resend to non-openers activity was deleted; no content is returned |
   | `getAccountSummary` | 200 | Request successful | The account summary details |
   | `getActivity` | 200 | Request Successful | The status of the activity |
   | `getAutomation` | 200 | Request successful | The requested automation |
   | `getCampaignPerformanceStats` | 200 | Request was successful | The campaign performance statistics |
   | `getCompanyLogo` | 200 | Request successful | The company logo for the account |
   | `getContact` | 200 | Request successful | The requested contact |
   | `getContactActivitySummary` | 200 | successful operation | Summary of activity counts for the contact |
   | `getContactConsentCounts` | 200 | Request successful | Contact counts by consent state |
   | `getContactOpenClickRate` | 200 | Request Successful | The contact's average open and click rates |
   | `getContactTracking` | 200 | successful operation | Activity details for the contact |
   | `getContactsExport` | 200 | Request Successful | The exported contacts file |
   | `getCustomField` | 200 | Request successful | The requested custom field |
   | `getEmailBounces` | 200 | Request was successful | A page of email bounce tracking activities |
   | `getEmailCampaign` | 200 | Request successful. | The requested email campaign |
   | `getEmailCampaignAbTest` | 200 | Request successful. | The A/B test details |
   | `getEmailCampaignActivity` | 200 | Request successful. | The requested email campaign activity |
   | `getEmailCampaignActivityPreview` | 200 | Request successful. | The HTML preview of the email campaign activity |
   | `getEmailCampaignActivityStats` | 200 | Request was successful. | The statistics for the email campaign activities |
   | `getEmailCampaignStats` | 200 | Request was successful. | The statistics for the email campaigns |
   | `getEmailCampaignSummaries` | 200 | Request was successful. | A page of email campaign summaries |
   | `getEmailClicks` | 200 | Request was successful | A page of email click tracking activities |
   | `getEmailDidNotOpens` | 200 | Request was successful | A page of contacts who did not open the email |
   | `getEmailForwards` | 200 | Request was successful | A page of email forward tracking activities |
   | `getEmailLinksReport` | 200 | Request was successful | The email links report |
   | `getEmailOpens` | 200 | Request was successful | A page of email open tracking activities |
   | `getEmailOptouts` | 200 | Request was successful | A page of email opt-out tracking activities |
   | `getEmailSends` | 200 | Request was successful | A page of email send tracking activities |
   | `getEmailUniqueOpens` | 200 | Request was successful | A page of unique email open tracking activities |
   | `getEvent` | 200 | Request Successful | The event details |
   | `getEventRegistration` | 200 | Request Successful | The registration details |
   | `getLandingPageContactOpens` | 200 | Request was successful. | A page of contact opens of the landing page |
   | `getLandingPageUniqueContactAdds` | 200 | Request was successful. | A page of unique contacts added from the landing page |
   | `getLandingPageUniqueContactClicks` | 200 | Request was successful. | A page of unique contact clicks on the landing page |
   | `getLandingPageUniqueContactOpens` | 200 | Request was successful. | A page of unique contact opens of the landing page |
   | `getLandingPageUniqueContactSmsOptIns` | 200 | Request was successful. | A page of unique contact SMS opt-ins from the landing page |
   | `getLandingPageUniqueContactUpdates` | 200 | Request was successful. | A page of unique contact updates from the landing page |
   | `getList` | 200 | Request successful | The requested list |
   | `getNonOpenerResend` | 200 | Request successful. | The resend to non-openers details |
   | `getPartnerAccountPlan` | 200 | Request successful. | The billing plan for the client account |
   | `getPhysicalAddress` | 200 | Request successful | The physical address for the account |
   | `getSmsCampaignSummaries` | 200 | Request was successful. | A page of SMS campaign summaries |
   | `getSmsEngagementHistory` | 200 | Request successful | The SMS engagement history for the contact |
   | `getTag` | 200 | Request Successful | The requested tag |
   | `getUserPrivileges` | 200 | Request successful. | The privileges granted to the user |
   | `getWebhookSubscription` | 200 | Request successful | The webhook topic subscription |
   | `importContactsCsv` | 201 | Request successful. Activity queued for processing. | The CSV contact import activity, queued for processing |
   | `importContactsJson` | 201 | Request successful. Activity queued for processing. | The JSON contact import activity, queued for processing |
   | `listAccountEmailAddresses` | 200 | Request successful. | The account email addresses |
   | `listActivities` | 200 | Request Successful | The collection of activity statuses |
   | `listAutomations` | 209 | Request successful | The collection of automations |
   | `listContactIdXrefs` | 200 | Request successful | The V2 to V3 contact ID cross-references |
   | `listContacts` | 200 | Request successful | The collection of contacts |
   | `listContacts` | 202 | Accepted | Request accepted; the contacts collection is being prepared |
   | `listCustomFields` | 200 | Request successful | The collection of custom fields |
   | `listEmailCampaignIdXrefs` | 200 | Request successful. | The V2 to V3 email campaign ID cross-references |
   | `listEmailCampaigns` | 200 | Request successful. | A page of email campaigns |
   | `listEmailSchedules` | 200 | Request successful. | The schedule for the email campaign activity |
   | `listEmailSendHistory` | 200 | Request successful. | The send history of the email campaign activity |
   | `listEvents` | 200 | Request Successful | A page of events |
   | `listListIdXrefs` | 200 | Request successful | The V2 to V3 list ID cross-references |
   | `listLists` | 200 | Request successful | The collection of lists |
   | `listPartnerAccounts` | 200 | Request successful. | The partner client accounts |
   | `listSegments` | 200 | Request successful. | The collection of segments |
   | `listSocialConnections` | 200 | Request successful | The social network connections |
   | `listSocialHashtagGroups` | 200 | Request successful | A page of hashtag groups |
   | `listSocialProfiles` | 200 | Request successful | The social media profiles |
   | `listTags` | 200 | Request Successful | The collection of tags |
   | `listWebhookSubscriptions` | 200 | Request successful | The webhook topic subscriptions |
   | `renameEmailCampaign` | 200 | Request successful. | The renamed email campaign |
   | `sendPartnerAccountRequest` | 200 | Request successful. The response body schema returned by this method corresponds to the specific API request you provided in the request body. | The response to the proxied request; its schema depends on the API request sent in the body |
   | `updateAccountSummary` | 200 | Request successful | The updated account details |
   | `updateAutomation` | 200 | Request successful | The updated automation |
   | `updateCompanyLogo` | 200 | Request successful | The updated company logo |
   | `updateList` | 200 | Request successful | The updated list |
   | `updatePartnerAccountPlan` | 200 | Request successful. | The updated billing plan |
   | `updatePhysicalAddress` | 200 | Request successful | The updated physical address |
   | `updateTag` | 200 | Request Successful | The updated tag |
   | `updateWebhookSubscription` | 200 | Request successful. | The updated webhook topic subscription |

   </details>

5. **Mock server only: status code `209` remapped**

   `listAutomations` documents a `209` response that `bal openapi --mode service` rejects. The mock-only copy of the spec maps it to `200`; the published spec is unchanged.

6. **Generated client patched: multipart body of `importContactsCsv`**

   The generated client converts the `ActivitiesContactsFileImportBody` payload to JSON before building the multipart body, so the CSV file was sent as a JSON text part (`{"fileContent":[101,...]}`) with no file name. `client.bal` was edited by hand to pass the form fields to `createBodyParts` directly:

   ```ballerina
   mime:Entity[] bodyParts = check createBodyParts({
       "file": payload.file,
       "sms_permission_to_send": payload.smsPermissionToSend,
       "list_ids": payload.listIds
   });
   ```

   `file` is now sent as a file part with its name, and the wire names `sms_permission_to_send` and `list_ids` are kept. When `smsPermissionToSend` is not set, no part is sent for it. This is a change to generated code, not to the spec, so it must be re-applied to `client.bal` whenever the client is regenerated.

7. **Description for the `api_key` security definition**

   The `api_key` entry in `securityDefinitions` had no description. `API key issued for the application, sent in the x-api-key header` was added in `docs/spec/openapi.yaml`; it becomes the documentation of the `xApiKey` field of the connection config.

8. **Description for the contact CSV import request body**

   A Swagger 2.0 `formData` operation has no place for a request body description, so `CSV file and import options for bulk contact import` is added to the generated `requestBody` of `POST /activities/contacts_file_import` in the aligned spec by the generation pipeline (a description-fill step). It is re-created whenever the pipeline is run.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

Note: The license year is hardcoded to 2024, change if necessary.
