# Ballerina Constant Contact connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-constantcontact/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-constantcontact/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-constantcontact.svg)](https://github.com/ballerina-platform/module-ballerinax-constantcontact/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/constantcontact.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fconstantcontact)

## Overview

[Constant Contact](https://www.constantcontact.com/) is an email marketing platform for small businesses, offering contact management, email campaigns, automation, event management, social posting and reporting.

The Constant Contact connector lets Ballerina applications call version 3 of the Constant Contact API. It covers account services, contacts, contact lists, tags and custom fields, segments, bulk activities, email campaigns and their reports, automations, events, social posts and partner account management.

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

- [Contact list onboarding](examples/contact_list_onboarding/contact_list_onboarding.md) - Find or create a contact list, add a contact to it, and read the contact back.
- [Email campaign drafting](examples/email_campaign_drafting/email_campaign_drafting.md) - Draft an email campaign with one email activity and inspect the created campaign.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`constantcontact` package](https://central.ballerina.io/ballerinax/constantcontact/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
