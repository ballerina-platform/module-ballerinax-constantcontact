# Contact list onboarding

This example onboards a new subscriber. It reuses a contact list with the configured name or creates it, adds or updates the contact with that list membership, and reads the contact back to confirm the membership.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Constant Contact OAuth 2.0 access token
- Push the connector to the local repository:
  ```bash
  cd ballerina
  bal pack && bal push --repository=local
  ```
- Create a `Config.toml` in this directory:
  ```toml
  accessToken = "<access-token>"
  listName = "Newsletter Subscribers"
  contactEmail = "<contact-email>"
  contactFirstName = "<first-name>"
  contactLastName = "<last-name>"
  ```

## Run the example

```bash
bal run
```
