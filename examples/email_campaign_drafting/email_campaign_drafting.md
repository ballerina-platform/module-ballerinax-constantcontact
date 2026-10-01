# Email campaign drafting

This example lists recent email campaigns and, when `createCampaign` is set to `true`, drafts a new campaign with a single email activity. It then reads the campaign and its primary email activity back.

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
  campaignName = "Spring Sale Announcement"
  fromName = "<sender-name>"
  fromEmail = "<verified-sender-email>"
  replyToEmail = "<reply-to-email>"
  subject = "Spring sale"
  htmlContent = "<html><body><p>Spring sale is here.</p></body></html>"
  createCampaign = false
  ```

## Run the example

```bash
bal run
```
