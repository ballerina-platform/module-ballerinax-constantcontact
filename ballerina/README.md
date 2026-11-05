## Overview

[Constant Contact](https://www.constantcontact.com/) is an email marketing platform for small businesses, offering contact management, email campaigns, automation, event management, social posting and reporting.

The Constant Contact connector lets Ballerina applications call version 3 of the Constant Contact API. It covers account services, contacts, contact lists, tags and custom fields, segments, bulk activities, email campaigns and their reports, automations, events, social posts and partner account management.

### Key features

- Create, update, import and delete contacts, contact lists, tags and custom fields
- Draft, schedule and send email campaigns, and run A/B tests on campaign activities
- Track campaign performance with email, SMS and landing page reports
- Manage events, registrations, social posts and automation workflows
- Provision and manage partner client accounts and webhook subscriptions

## Setup guide

To use the Constant Contact connector, you need an OAuth 2.0 access token for your Constant Contact account.

1. Sign in to the [Constant Contact developer portal](https://developer.constantcontact.com/) with your Constant Contact account.

2. Open **My Applications** and create a new application.

3. Copy the application's **API Key** (client ID) and create a **client secret**.

4. Add a redirect URI for your application and select the scopes it needs, such as `contact_data`, `campaign_data` and `account_read`. If you configure the connector with a refresh token, also select the optional `offline_access` scope, which is required for a refresh token to be issued.

5. Authorize the application using the OAuth 2.0 authorization code flow against `https://authz.constantcontact.com/oauth2/default/v1/authorize`, then exchange the code at `https://authz.constantcontact.com/oauth2/default/v1/token`.

6. Keep the returned access token, or the refresh token together with the client ID and client secret, to configure the connector.

## Quickstart

To use the `constantcontact` connector in your Ballerina application, update the `.bal` file as follows:

Step 1: Import the connector.

```ballerina
import ballerinax/constantcontact;
```

Step 2: Create a `Config.toml` file with your access token.

```toml
accessToken = "<access-token>"
```

Then declare the matching configurable.

```ballerina
configurable string accessToken = ?;
```

Step 3: Initialize the client.

```ballerina
final constantcontact:Client constantContactClient = check new ({auth: {token: accessToken}});
```

Step 4: Invoke an operation.

```ballerina
public function main() returns error? {
    constantcontact:Activities _ = check constantContactClient->listActivities();
}
```

## Examples

The `Constant Contact` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-constantcontact/tree/main/examples/), covering the following use cases:

- [Contact list onboarding](../examples/contact_list_onboarding/contact_list_onboarding.md) - Find or create a contact list, add a contact to it, and read the contact back.
- [Email campaign drafting](../examples/email_campaign_drafting/email_campaign_drafting.md) - Draft an email campaign with one email activity and inspect the created campaign.

