# Tests

The test suite runs against a mock server (`tests/mock_service.bal`) and covers 25 operations across accounts, activities, contacts, contact lists, tags, custom fields, segments and email campaigns. Read-only list operations also run against the live API when `IS_LIVE_SERVER=true`.

## Running Tests

```bash
bal test
```

The mock tests need no credentials. To run the live tests, set the following environment variables:

```bash
export IS_LIVE_SERVER=true
export CONSTANT_CONTACT_ACCESS_TOKEN=<access-token>
bal test --groups live_tests
```
