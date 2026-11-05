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

listener http:Listener ep0 = new (9090);

service / on ep0 {
    # DELETE a List
    #
    # + listId - Unique ID of the list to delete
    # + return - returns can be any of following types 
    # http:Accepted (Request accepted; the list delete activity status)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:UnsupportedMediaType (Unsupported Media Type.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function delete contact_lists/[string listId]() returns ActivityDeleteListResponseAccepted|http:Unauthorized|http:Forbidden|http:NotFound|http:UnsupportedMediaType|http:InternalServerError|http:ServiceUnavailable {
        return <ActivityDeleteListResponseAccepted>{body: {activityId: "d1e2f3a4-5555-4666-8777-d88899900011", state: "initialized", percentDone: 0, createdAt: "2024-03-07T09:00:00Z", updatedAt: "2024-03-07T09:00:00Z"}, headers: {}};
    }

    # DELETE a Tag
    #
    # + tagId - The ID that uniquely identifies a tag in UUID format
    # + return - returns can be any of following types 
    # http:Accepted (The asynchronous request was successfully accepted. To view the results of the activity request, use the href link returned in the response)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:NotAcceptable (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function delete contact_tags/[string tagId]() returns ActivityGenericAccepted|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:NotAcceptable|http:InternalServerError {
        return <ActivityGenericAccepted>{body: {activityId: "d1e2f3a4-5555-4666-8777-d88899900012", state: "initialized", percentDone: 0, createdAt: "2024-03-07T09:00:00Z", updatedAt: "2024-03-07T09:00:00Z"}};
    }

    # DELETE a Contact
    #
    # + contactId - Unique ID of contact to DELETE
    # + return - returns can be any of following types 
    # http:NoContent (Request successful; No content returned)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:UnsupportedMediaType (Unsupported Media Type.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function delete contacts/[string contactId]() returns http:NoContent|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:UnsupportedMediaType|http:InternalServerError|http:ServiceUnavailable {
        return http:NO_CONTENT;
    }

    # GET a Summary of Account Details
    #
    # + extra_fields - Use the `extra_fields` query parameter to include the `physical_address` and/or `company_logo` details in the response body. Use a comma separated list to include both (physical_address, company logo)
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get account/summary(@http:Query {name: "extra_fields"} "physical_address"|"company_logo"? extraFields) returns Customer|http:BadRequest|http:Unauthorized|http:Forbidden|http:InternalServerError|http:ServiceUnavailable {
        return {firstName: "Jane", lastName: "Doe", organizationName: "Acme Corp", contactEmail: "jane.doe@example.com", contactPhone: "555-0100", website: "https://www.example.com", countryCode: "US", stateCode: "MA", timeZoneId: "America/New_York", encodedAccountId: "a1b2c3d4e5f6"};
    }

    # GET Activity Status Collection
    #
    # + 'limit - Specifies the number of results displayed per page of output, from 1 - 500, default = 50
    # + state - Use this parameter to filter the response to include only activities in one of the following states: cancelled, completed, failed, processing, or timed_out
    # + return - returns can be any of following types 
    # http:Ok (Request Successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get activities("processing"|"completed"|"cancelled"|"failed"|"timed_out"? state, int 'limit = 50) returns Activities|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError|http:ServiceUnavailable {
        return {activities: [{activityId: "d1e2f3a4-5555-4666-8777-d88899900011", state: "completed", percentDone: 100, createdAt: "2024-03-07T09:00:00Z", updatedAt: "2024-03-07T09:05:00Z", sourceFileName: "contacts.csv"}]};
    }

    # GET custom_fields Collection
    #
    # + 'limit - Specifies the number of results displayed per page of output, from 1 - 100, default = 50
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get contact_custom_fields(int 'limit = 50) returns CustomFields|http:BadRequest|http:Unauthorized|http:Forbidden|http:InternalServerError|http:ServiceUnavailable {
        return {customFields: [{customFieldId: "9c0d1e2f-3333-4444-8555-b66677788899", name: "loyalty_level", label: "Loyalty Level", 'type: "string", createdAt: "2024-01-15T09:00:00Z", updatedAt: "2024-01-15T09:00:00Z"}]};
    }

    # GET Lists Collection
    #
    # + 'limit - Use to specify the number of results displayed per page of output, from 1 - 500, default = 50
    # + includeCount - Set `include_count` to `true` to return the total number of contact lists that meet your selection criteria
    # + include_membership_count - Use to include the total number of contacts per list. Set to  `active`, to count only active (mailable) contacts, or `all` to count all contacts
    # + name - Use to get details for a single list by entering the full name of the list
    # + status - Use to get lists by status. Accepts comma-separated status values
    # + channel_type - Use to return lists by channel type. The default value is `email`
    # + includeSmsMembershipCount - Set to `true` to return the total number of SMS members in each list. Only applicable when `channel_type` is `sms`. Default is `false`
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get contact_lists(@http:Query {name: "include_membership_count"} "all"|"active"? includeMembershipCount, string? name, "all"|"active"|"deleted"? status, @http:Query {name: "channel_type"} "email"|"sms"? channelType, @http:Query {name: "include_sms_membership_count"} boolean? includeSmsMembershipCount, int 'limit = 50, @http:Query {name: "include_count"} boolean includeCount = false) returns ContactListArray|http:BadRequest|http:Unauthorized|http:Forbidden|http:InternalServerError|http:ServiceUnavailable {
        return {lists: [{listId: "5f6a7b8c-1111-4222-8333-944455566677", name: "Newsletter Subscribers", description: "Customers subscribed to the monthly newsletter", favorite: true,
            createdAt: "2024-01-10T09:00:00Z", updatedAt: "2024-02-15T12:30:00Z", membershipCount: 120}]};
    }

    # GET a List
    #
    # + listId - The system generated ID that uniquely identifies a contact list
    # + include_membership_count - Returns the total number of contacts per list that meet your selection criteria. Set the `include_membership_count` to `active`, to count only active contacts, or `all` to include all contacts in the count
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get contact_lists/[string listId](@http:Query {name: "include_membership_count"} "all"|"active"? includeMembershipCount) returns ContactList|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError|http:ServiceUnavailable {
        return {listId: "5f6a7b8c-1111-4222-8333-944455566677", name: "Newsletter Subscribers", description: "Customers subscribed to the monthly newsletter", favorite: true,
            createdAt: "2024-01-10T09:00:00Z", updatedAt: "2024-02-15T12:30:00Z", membershipCount: 120};
    }

    # GET Details for All Tags
    #
    # + 'limit - Use to specify the number of tag results (up to `500`) to display per page of output. The default is `50`
    # + includeCount - Returns the total number of contacts (`contacts_count`) to which a tag applies
    # + return - returns can be any of following types 
    # http:Ok (Request Successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get contact_tags(int 'limit = 50, @http:Query {name: "include_count"} boolean includeCount = false) returns Tags|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError {
        return {tags: [{tagId: "7a8b9c0d-2222-4333-8444-a55566677788", name: "VIP Customer", tagSource: "Contact", contactsCount: 42, createdAt: "2024-01-12T09:00:00Z", updatedAt: "2024-02-01T11:00:00Z"}]};
    }

    # GET Tag Details
    #
    # + tagId - The ID that uniquely identifies a tag (UUID format)
    # + includeCount - Use to include (`true`) or exclude (`false`) the total number of tagged contacts (`contacts_count`) from the results
    # + return - returns can be any of following types 
    # http:Ok (Request Successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get contact_tags/[string tagId](@http:Query {name: "include_count"} boolean includeCount = false) returns Tag|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError {
        return {tagId: "7a8b9c0d-2222-4333-8444-a55566677788", name: "VIP Customer", tagSource: "Contact", contactsCount: 42, createdAt: "2024-01-12T09:00:00Z", updatedAt: "2024-02-01T11:00:00Z"};
    }

    # GET Contacts Collection
    #
    # + status - Use the `status` query parameter to search for contacts by status. This parameter accepts one or more comma separated values: `all`, `active`, `deleted`, `not_set`, `pending_confirmation`, `temp_hold`, and `unsubscribed`
    # + email - Use the `email` query parameter to search for a contact using a specific email address
    # + lists - Use the `lists` query parameter to search for contacts that are members of one or more specified lists. Use a comma to separate multiple `list_id` values, up to a maximum of 25
    # + segmentId - Use to get contacts that meet the segment criteria for a single specified `segment_id`. This query parameter can only be combined with the limit query parameter. When using the `segment_id` query parameter, the V3 API may return a 202 response code instead of a 200 response. The 202 response code indicates that your request has been accepted, but not fully completed. Retry sending your API request to return the completed results and a 200 response code
    # + tags - Use to get contact details for up to 50 specified tags. Use a comma to separate each `tag_id`
    # + updatedAfter - Use `updated_after` to search for contacts that have been updated after the date you specify. To search for updated contacts within a date range, specify both `updated_after` and `updated_before` dates. Accepts ISO-8601 formatted dates
    # + updatedBefore - Use `updated_before` to search for contacts that have been updated before a specified date. To search for updated contacts within a date range, specify both `updated_after` and `updated_before` dates. Accepts ISO-8601 formatted dates
    # + createdAfter - Use `created_after` to search for contacts created after a specified date. To search for contacts created within a date range, specify both `created_after` and `created_before` dates. Accepts ISO-8601 formatted dates
    # + createdBefore - Use `created_before` to search for contacts created before a specified date. To search for contacts created within a date range, specify both `created_after` and `created_before` dates. Accepts ISO-8601 formatted dates
    # + optoutAfter - Use `optout_after` to search for contacts that unsubscribed after a specified date
    # + optoutBefore - Use `optout_before` to search for contacts that unsubscribed before a specified date
    # + include - Use `include` to specify which contact sub-resources to include in the response. Use a comma to separate multiple sub-resources. Valid values: `custom_fields`, `list_memberships`, `taggings`, `notes`,`phone_numbers`, `street_addresses`
    # + sms_status - Use to get contacts by their SMS status. This parameter accepts one or more comma separated values: `all`, `explicit`, `unsubscribed`, `pending_confirmation`, `not_set`
    # + includeCount - Set `include_count=true` to include the total number of contacts (`contacts_count`) that meet all search criteria in the response body
    # + 'limit - Specifies the number of results displayed per page of output in the response, from 1 - 500, default = 50
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:Accepted (Request accepted; the contacts collection is being prepared)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get contacts("all"|"active"|"deleted"|"not_set"|"pending_confirmation"|"temp_hold"|"unsubscribed"? status, string? email, string? lists, @http:Query {name: "segment_id"} string? segmentId, string? tags, @http:Query {name: "updated_after"} string? updatedAfter, @http:Query {name: "updated_before"} string? updatedBefore, @http:Query {name: "created_after"} string? createdAfter, @http:Query {name: "created_before"} string? createdBefore, @http:Query {name: "optout_after"} string? optoutAfter, @http:Query {name: "optout_before"} string? optoutBefore, "custom_fields"|"list_memberships"|"phone_numbers"|"street_addresses"|"taggings"|"notes"? include, @http:Query {name: "sms_status"} "all"|"explicit"|"unsubscribed"|"pending_confirmation"|"not_set"? smsStatus, @http:Query {name: "include_count"} boolean? includeCount, int 'limit = 50) returns Contacts|ContactsAccepted|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError|http:ServiceUnavailable {
        return <Contacts>{contactsCount: 1, contacts: [{contactId: "a1b2c3d4-0001-4e5f-8a9b-1c2d3e4f5a6b", firstName: "Jane", lastName: "Doe", companyName: "Acme Corp", jobTitle: "Marketing Manager",
            emailAddress: {address: "jane.doe@example.com", permissionToSend: "implicit", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"},
            listMemberships: ["5f6a7b8c-1111-4222-8333-944455566677"], taggings: ["7a8b9c0d-2222-4333-8444-a55566677788"],
            createSource: "Account", updateSource: "Account", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"}]};
    }

    # GET a Contact
    #
    # + contactId - Unique ID of contact to GET
    # + include - Use `include` to specify which contact sub-resources to include in the response. Use a comma to separate multiple sub-resources. Valid values: `custom_fields`, `list_memberships`, `phone_numbers`, `street_addresses`, `notes`, and `taggings`
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function get contacts/[string contactId]("custom_fields"|"list_memberships"|"phone_numbers"|"street_addresses"|"taggings"|"notes"? include) returns ContactResource|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError|http:ServiceUnavailable {
        return {contactId: "a1b2c3d4-0001-4e5f-8a9b-1c2d3e4f5a6b", firstName: "Jane", lastName: "Doe", companyName: "Acme Corp", jobTitle: "Marketing Manager",
            emailAddress: {address: "jane.doe@example.com", permissionToSend: "implicit", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"},
            listMemberships: ["5f6a7b8c-1111-4222-8333-944455566677"], taggings: ["7a8b9c0d-2222-4333-8444-a55566677788"],
            createSource: "Account", updateSource: "Account", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"};
    }

    # GET a Collection of Email Campaigns
    #
    # + 'limit - Specifies the number of campaigns to display on each page of output that is returned (from return 1 - 500). The default returns 50 campaigns per page
    # + beforeDate - Use to return email campaigns with `updated_at` timestamps that are before a specific date and time (in ISO-8601 format). Use with the `after_date` query parameter to get email campaigns sent within a specific date range
    # + afterDate - Use to return email campaigns with last `updated_at` timestamps that are after a specific date and time (in ISO-8601 format). Use with the `before_date` query parameter to get email campaigns sent within a specific date range
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:TooManyRequests (Too many requests. You exceeded the request rate limit.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get emails(@http:Query {name: "before_date"} string? beforeDate, @http:Query {name: "after_date"} string? afterDate, int:Signed32 'limit = 50) returns PagedEmailCampaignResponse|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {campaigns: [{campaignId: "c1d2e3f4-4444-4555-8666-c77788899900", name: "Spring Sale Announcement", currentStatus: "Draft", 'type: "NEWSLETTER", typeCode: 1, createdAt: "2024-03-05T14:00:00Z", updatedAt: "2024-03-06T16:45:00Z"}]};
    }

    # GET Details About a Single Email Campaign
    #
    # + campaignId - The ID (UUID format) that uniquely identifies this email campaign
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:TooManyRequests (Too many requests. You exceeded the request rate limit.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get emails/[string campaignId]() returns EmailCampaign|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {campaignId: "c1d2e3f4-4444-4555-8666-c77788899900", name: "Spring Sale Announcement", currentStatus: "Draft", 'type: "NEWSLETTER", typeCode: 1, createdAt: "2024-03-05T14:00:00Z", updatedAt: "2024-03-06T16:45:00Z", campaignActivities: [{campaignActivityId: "e1f2a3b4-6666-4777-8888-e99900011122", role: "primary_email"}]};
    }

    # GET a Single Email Campaign Activity
    #
    # + campaignActivityId - The unique ID for an email campaign activity
    # + include - Use the `include` query parameter to enter a comma separated list of additional email campaign activity properties for the V3 API to return. Valid values are `physical_address_in_footer`, `permalink_url`, `html_content`, and `document_properties`
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:TooManyRequests (Too many requests. You exceeded the request rate limit.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get emails/activities/[string campaignActivityId]("physical_address_in_footer"|"permalink_url"|"html_content"|"document_properties"? include) returns EmailCampaignActivity|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {campaignActivityId: "e1f2a3b4-6666-4777-8888-e99900011122", campaignId: "c1d2e3f4-4444-4555-8666-c77788899900", role: "primary_email", fromName: "Acme Marketing", fromEmail: "marketing@example.com", replyToEmail: "reply@example.com", subject: "Spring Sale - 20% off everything", preheader: "Save big this week only", currentStatus: "Draft", formatType: 5};
    }

    # GET all Segments
    #
    # + 'limit - The number of segments to return on a page
    # + sortBy - Specify the segment sort order to use. Sort by name (`sort_by=name`) in ascending order, or sort by date (`sort_by=date`) in descending order with the most recently updated segments listed first
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:UnsupportedMediaType (Unsupported Media Type.)
    # http:TooManyRequests (Too many requests. You exceeded the request rate limit.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get segments(string 'limit = "1000", @http:Query {name: "sort_by"} string sortBy = "date") returns SegmentsDTO|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:UnsupportedMediaType|http:TooManyRequests|http:InternalServerError {
        return {segments: [{segmentId: 101, name: "Engaged Subscribers", createdAt: "2024-02-01T10:00:00Z", editedAt: "2024-02-10T10:00:00Z"}]};
    }

    # GET a Segment's Details
    #
    # + segmentId - The system-generated unique ID that identifies a segment
    # + return - returns can be any of following types 
    # http:Ok (The segment was successfully returned)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:NotFound (The requested resource was not found.)
    # http:UnsupportedMediaType (Unsupported Media Type.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function get segments/[int:Signed32 segmentId]() returns SegmentDetail|http:BadRequest|http:Unauthorized|http:NotFound|http:UnsupportedMediaType|http:InternalServerError {
        return {segmentId: 101, name: "Engaged Subscribers", segmentCriteria: "{\"version\":\"1.0.0\",\"criteria\":{\"type\":\"and\",\"group\":[]}}", createdAt: "2024-02-01T10:00:00Z", editedAt: "2024-02-10T10:00:00Z"};
    }

    # POST (create) a custom_field
    #
    # + payload - The JSON payload required to create a new custom field 
    # + return - returns can be any of following types 
    # http:Created (New custom field successfully created)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:Conflict (Conflict. The resource you are creating or updating conflicts with an existing resource.)
    # http:UnsupportedMediaType (Unsupported Media Type; the payload must be in JSON format, and Content-Type must be application/json.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function post contact_custom_fields(@http:Payload CustomFieldRequest payload) returns CustomField|http:BadRequest|http:Unauthorized|http:Forbidden|http:Conflict|http:UnsupportedMediaType|http:InternalServerError|http:ServiceUnavailable {
        return {customFieldId: "9c0d1e2f-3333-4444-8555-b66677788899", name: "loyalty_level", label: "Loyalty Level", 'type: "string", createdAt: "2024-01-15T09:00:00Z", updatedAt: "2024-01-15T09:00:00Z"};
    }

    # POST (create) a List
    #
    # + payload - JSON payload defining the new contact list 
    # + return - returns can be any of following types 
    # http:Created (New list successfully created)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:Conflict (Conflict. The resource you are creating or updating conflicts with an existing resource.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function post contact_lists(@http:Payload ListInput payload) returns ContactListPutPost|http:BadRequest|http:Unauthorized|http:Forbidden|http:Conflict|http:InternalServerError|http:ServiceUnavailable {
        return {listId: "5f6a7b8c-1111-4222-8333-944455566677", name: "Newsletter Subscribers", description: "Customers subscribed to the monthly newsletter", favorite: true,
            createdAt: "2024-01-10T09:00:00Z", updatedAt: "2024-02-15T12:30:00Z"};
    }

    # POST (Create) a Tag
    #
    # + payload - The JSON payload to use to create a new tag 
    # + return - returns can be any of following types 
    # http:Created (Request Successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:Conflict (Conflict. The resource you are creating or updating conflicts with an existing resource.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function post contact_tags(@http:Payload TagPost payload) returns Tag|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:Conflict|http:InternalServerError {
        return {tagId: "7a8b9c0d-2222-4333-8444-a55566677788", name: "VIP Customer", tagSource: "Contact", contactsCount: 42, createdAt: "2024-01-12T09:00:00Z", updatedAt: "2024-02-01T11:00:00Z"};
    }

    # POST (create) a Contact
    #
    # + payload - The JSON payload defining the contact 
    # + return - returns can be any of following types 
    # http:Created (New contact successfully created)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:Conflict (Conflict. The resource you are creating or updating conflicts with an existing resource.)
    # http:UnsupportedMediaType (Unsupported Media Type; the payload must be in JSON format, and Content-Type must be application/json)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function post contacts(@http:Payload ContactPostRequest payload) returns ContactResource|http:BadRequest|http:Unauthorized|http:Forbidden|http:Conflict|http:UnsupportedMediaType|http:InternalServerError|http:ServiceUnavailable {
        return {contactId: "a1b2c3d4-0001-4e5f-8a9b-1c2d3e4f5a6b", firstName: "Jane", lastName: "Doe", companyName: "Acme Corp", jobTitle: "Marketing Manager",
            emailAddress: {address: "jane.doe@example.com", permissionToSend: "implicit", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"},
            listMemberships: ["5f6a7b8c-1111-4222-8333-944455566677"], taggings: ["7a8b9c0d-2222-4333-8444-a55566677788"],
            createSource: "Account", updateSource: "Account", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"};
    }

    # Create or Update a Contact
    #
    # + payload - A JSON request body payload that contains the contact resource you are creating or updating. The request body must contain the `email_address` property and `list_memberships` array, or the `sms_channel` object 
    # + return - returns can be any of following types 
    # http:Ok (Contact successfully updated)
    # http:Created (Contact successfully created.)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:Conflict (Conflict. You sent simultaneous requests that are attempting to modify the same contact.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function post contacts/sign_up_form(@http:Payload ContactCreateOrUpdateInput payload) returns ContactCreateOrUpdateResponseOk|ContactCreateOrUpdateResponse|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:Conflict|http:InternalServerError|http:ServiceUnavailable {
        return <ContactCreateOrUpdateResponseOk>{body: {action: "created", contactId: "a1b2c3d4-0001-4e5f-8a9b-1c2d3e4f5a6b"}};
    }

    # POST (Create) a New Email Campaign
    #
    # + payload - A JSON request body that contains the email content 
    # + return - returns can be any of following types 
    # http:Ok (Request successful. NOTE: If you created an email campaign using a legacy (V7) format, Constant Contact successfully converted it to the newer custom code format)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:Conflict (Conflict. The resource you are creating or updating conflicts with an existing resource.)
    # http:UnsupportedMediaType (Unsupported Media Type.)
    # http:TooManyRequests (Too many requests. You exceeded the request rate limit.)
    # http:InternalServerError (There was a problem with our internal service.)
    resource function post emails(@http:Payload EmailCampaignComplete payload) returns EmailCampaignOk|http:BadRequest|http:Unauthorized|http:Forbidden|http:Conflict|http:UnsupportedMediaType|http:TooManyRequests|http:InternalServerError {
        return <EmailCampaignOk>{body: {campaignId: "c1d2e3f4-4444-4555-8666-c77788899900", name: "Spring Sale Announcement", currentStatus: "Draft", 'type: "NEWSLETTER", typeCode: 1, createdAt: "2024-03-05T14:00:00Z", updatedAt: "2024-03-06T16:45:00Z", campaignActivities: [{campaignActivityId: "e1f2a3b4-6666-4777-8888-e99900011122", role: "primary_email"}]}};
    }

    # PUT (update) a List
    #
    # + listId - Unique ID of the contact list to update
    # + payload - JSON payload containing updates to the specified contact list 
    # + return - returns can be any of following types 
    # http:Ok (Request successful)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function put contact_lists/[string listId](@http:Payload ListInput payload) returns ContactListPutPost|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:InternalServerError|http:ServiceUnavailable {
        return {listId: "5f6a7b8c-1111-4222-8333-944455566677", name: "Newsletter Subscribers", description: "Customers subscribed to the monthly newsletter", favorite: true,
            createdAt: "2024-01-10T09:00:00Z", updatedAt: "2024-02-15T12:30:00Z"};
    }

    # PUT (update) a Contact
    #
    # + contactId - Unique ID of contact to update
    # + payload - JSON payload defining the contact object, with updates. Any properties left blank or not included in the PUT payload are overwritten with null value - does not apply to contact subresources 
    # + return - returns can be any of following types 
    # http:Ok (Contact resource has been updated)
    # http:BadRequest (Bad request. Either the JSON was malformed or there was a data validation error.)
    # http:Unauthorized (The Access Token used is invalid.)
    # http:Forbidden (Forbidden request. You lack the necessary scopes, you lack the necessary user privileges, or the application is deactivated.)
    # http:NotFound (The requested resource was not found.)
    # http:Conflict (Conflict. The resource you are creating or updating conflicts with an existing resource.)
    # http:InternalServerError (There was a problem with our internal service.)
    # http:ServiceUnavailable (Our internal service is temporarily unavailable.)
    resource function put contacts/[string contactId](@http:Payload ContactPutRequest payload) returns ContactResource|http:BadRequest|http:Unauthorized|http:Forbidden|http:NotFound|http:Conflict|http:InternalServerError|http:ServiceUnavailable {
        return {contactId: "a1b2c3d4-0001-4e5f-8a9b-1c2d3e4f5a6b", firstName: "Jane", lastName: "Doe", companyName: "Acme Corp", jobTitle: "Marketing Manager",
            emailAddress: {address: "jane.doe@example.com", permissionToSend: "implicit", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"},
            listMemberships: ["5f6a7b8c-1111-4222-8333-944455566677"], taggings: ["7a8b9c0d-2222-4333-8444-a55566677788"],
            createSource: "Account", updateSource: "Account", createdAt: "2024-03-01T10:15:30Z", updatedAt: "2024-03-02T08:00:00Z"};
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type ActivityDeleteListResponseAccepted record {|
    *http:Accepted;
    ActivityDeleteListResponse body;
    record {|string Location?;|} headers;
|};

public type ActivityGenericAccepted record {|
    *http:Accepted;
    ActivityGeneric body;
|};

public type ContactCreateOrUpdateResponseOk record {|
    *http:Ok;
    ContactCreateOrUpdateResponse body;
|};

public type ContactsAccepted record {|
    *http:Accepted;
    Contacts body;
|};

public type EmailCampaignOk record {|
    *http:Ok;
    EmailCampaign body;
|};
