# Examples

The `ballerinax/constantcontact` connector provides practical examples illustrating usage in various scenarios.

1. [Contact list onboarding](./contact_list_onboarding/contact_list_onboarding.md) - Find or create a contact list, add a contact to it, and read the contact back.
2. [Email campaign drafting](./email_campaign_drafting/email_campaign_drafting.md) - Draft an email campaign with one email activity and inspect the created campaign.

## Prerequisites

1. Create a Constant Contact application and obtain an OAuth 2.0 access token with the scopes the example needs, such as `contact_data` and `campaign_data`.

2. For each example, create a `Config.toml` file with the required configurations, as described in the example's own document.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
