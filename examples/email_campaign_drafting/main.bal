// Drafts an email campaign and reads back the campaign and its primary email activity. Creation is gated by a flag.

import ballerina/io;
import ballerinax/constantcontact;

configurable string accessToken = ?;
configurable string campaignName = ?;
configurable string fromName = ?;
configurable string fromEmail = ?;
configurable string replyToEmail = ?;
configurable string subject = ?;
configurable string htmlContent = ?;
configurable boolean createCampaign = false;

public function main() returns error? {
    constantcontact:Client cc = check new ({auth: {token: accessToken}});

    // Step 1: Show the most recent campaigns.
    constantcontact:PagedEmailCampaignResponse recent = check cc->listEmailCampaigns('limit = 10);
    foreach constantcontact:EmailCampaigns c in recent?.campaigns ?: [] {
        io:println("Existing campaign: ", c?.name ?: "", " (", c?.currentStatus ?: "", ")");
    }
    if !createCampaign {
        io:println("Set createCampaign = true to create the draft campaign.");
        return;
    }

    // Step 2: Create the draft campaign with one email activity.
    constantcontact:EmailCampaign campaign = check cc->createEmailCampaign({
        name: campaignName,
        emailCampaignActivities: [
            {
                formatType: 5,
                fromName,
                fromEmail,
                replyToEmail,
                subject,
                htmlContent
            }
        ]
    });
    string campaignId = campaign?.campaignId ?: "";
    if campaignId == "" {
        return error("The campaign ID was not returned by the API");
    }
    io:println("Created campaign: ", campaignId);

    // Step 3: Read the campaign back and inspect its primary email activity.
    constantcontact:EmailCampaign fetched = check cc->getEmailCampaign(campaignId);
    constantcontact:ActivityReference[] activities = fetched?.campaignActivities ?: [];
    if activities.length() == 0 {
        return error("The campaign has no email activities");
    }
    string activityId = activities[0]?.campaignActivityId ?: "";
    if activityId == "" {
        return error("The campaign activity ID was not returned by the API");
    }
    constantcontact:EmailCampaignActivity activity = check cc->getEmailCampaignActivity(activityId);
    io:println("Activity subject: ", activity.subject, ", status: ", activity?.currentStatus ?: "");
}
