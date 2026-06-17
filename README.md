# Share Now sample

Share Now helps colleagues exchange information in Microsoft Teams. Users can share content with their team and discover items that others have recommended.

![Share Now](images/shareNow.gif)

> Note: This sample will only provision [single tenant](https://learn.microsoft.com/azure/active-directory/develop/single-and-multi-tenant-apps#who-can-sign-in-to-your-app) Azure Active Directory app. For multi-tenant support, please refer to this [wiki](https://aka.ms/teamsfx-multi-tenant).

## What this sample shows
- How to host the tab app frontend on Azure.
- How to host the tab app backend on Azure.
- How to host the message extension bot on Azure.
- How to connect to Azure SQL Database and perform CRUD operations.

## Prerequisites
- [Node.js](https://nodejs.org/), supported versions: 16, 18
- A Microsoft 365 account. If you do not have one, apply through the [Microsoft 365 Developer Program](https://developer.microsoft.com/en-us/microsoft-365/dev-program)
- [Teams Toolkit for Visual Studio Code](https://aka.ms/teams-toolkit) version 5.0.0 or later, or [TeamsFx CLI](https://aka.ms/teamsfx-cli)
- An [Azure subscription](https://azure.microsoft.com/en-us/free/)

## Project structure
- `tabs/`: React tab app shown in Teams
- `api/`: Azure Functions backend for posts and votes
- `bot/`: Teams message extension bot
- `infra/`: Azure infrastructure templates

## Quick start
### Deploy the app to Azure
> These instructions use **Visual Studio Code**. If you prefer the CLI experience, see [Try the sample with TeamsFx CLI](cli.md).
1. Clone the repo to your local workspace or directly download the source code.
1. Open the project in Visual Studio Code.
1. Open **env/.env.dev.user** and set values for `SQL_USER_NAME` and `SQL_PASSWORD`.
1. Open the command palette and select `Teams: Provision`. The toolkit provisions the Azure resources, including Azure SQL.
1. After provisioning completes, open the command palette and select `Teams: Deploy`.
1. Open **env/.env.dev** and find the database name in `PROVISIONOUTPUT__AZURESQLOUTPUT__DATABASENAME`. Then [add your computer IP address to the server-level firewall rule from the database overview page](https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-configure#from-the-database-overview-page).
1. In the Azure portal, find the database by `databaseName` and use [Query editor](https://docs.microsoft.com/en-us/azure/azure-sql/database/connect-query-portal) with the following SQL to create the tables:
    ```sql
    CREATE TABLE [TeamPostEntity](
	    [PostID] [int] PRIMARY KEY IDENTITY,
	    [ContentUrl] [nvarchar](400) NOT NULL,
	    [CreatedByName] [nvarchar](50) NOT NULL,
	    [CreatedDate] [datetime] NOT NULL,
	    [Description] [nvarchar](500) NOT NULL,
	    [IsRemoved] [bit] NOT NULL,
	    [Tags] [nvarchar](100) NULL,
	    [Title] [nvarchar](100) NOT NULL,
	    [TotalVotes] [int] NOT NULL,
	    [Type] [int] NOT NULL,
	    [UpdatedDate] [datetime] NOT NULL,
	    [UserID] [uniqueidentifier] NOT NULL,
    )
    GO
    CREATE TABLE [UserVoteEntity](
	    [VoteID] [int] PRIMARY KEY IDENTITY,
	    [PostID] [int] NOT NULL,
	    [UserID] [uniqueidentifier] NOT NULL,
    )
    GO
    ```
### Preview the app in Teams
1. After deployment completes, preview the app running in Azure. In Visual Studio Code, open `Run and Debug`, select `Launch Remote (Edge)` or `Launch Remote (Chrome)`, and press `F5` or the green run button.
1. The app looks like this the first time it runs:

	![Share Now](images/StartPage.png)

1. Add new content by selecting the **Suggest content** button.
1. Update content that you created by selecting the three-dot menu (`...`) and then **Update**.
1. Delete content that you created by selecting the three-dot menu (`...`) and then **Delete**.
1. Add or remove your vote by selecting the ![vote icon](images/voteIconME.png) icon on a post.
1. Search all content or only your own content in the compose box or command box by filtering on the title or tags.

### (Optional) Run the app locally
To debug the project locally, configure an Azure SQL Database:
1. [Create an Azure SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?tabs=azure-portal)
1. [Add your computer IP address to the Azure SQL Server firewall allowlist](https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-configure#from-the-database-overview-page)
1. Use [Query editor](https://docs.microsoft.com/en-us/azure/azure-sql/database/connect-query-portal) with the following SQL to create the tables:
    ```sql
    CREATE TABLE [TeamPostEntity](
	    [PostID] [int] PRIMARY KEY IDENTITY,
	    [ContentUrl] [nvarchar](400) NOT NULL,
	    [CreatedByName] [nvarchar](50) NOT NULL,
	    [CreatedDate] [datetime] NOT NULL,
	    [Description] [nvarchar](500) NOT NULL,
	    [IsRemoved] [bit] NOT NULL,
	    [Tags] [nvarchar](100) NULL,
	    [Title] [nvarchar](100) NOT NULL,
	    [TotalVotes] [int] NOT NULL,
	    [Type] [int] NOT NULL,
	    [UpdatedDate] [datetime] NOT NULL,
	    [UserID] [uniqueidentifier] NOT NULL,
    )
    GO
    CREATE TABLE [UserVoteEntity](
	    [VoteID] [int] PRIMARY KEY IDENTITY,
	    [PostID] [int] NOT NULL,
	    [UserID] [uniqueidentifier] NOT NULL,
    )
    GO
    ```
1. Open **env/.env.local** and set the following values for the Azure SQL Database you created:
    ```
    SQL_ENDPOINT=
    SQL_DATABASE_NAME=
    ```
1. Open **env/.env.local.user** and set the following values for the Azure SQL Database you created:
    ```
    SQL_USER_NAME=
    SQL_PASSWORD=
    ```
1. Open `Run and Debug` (`Ctrl+Shift+D`) and select `Debug (Edge)` or `Debug (Chrome)`.
1. Press `F5` to open a browser window, then select your package to view the Share Now sample app.



## Version History

|Date| Author| Comments|
|---|---|---|
|May 13 2021| xzf0587 | onboard |
|May 18, 2022| xzf0587 | update to support Teams Toolkit v4.0.0|
|Apr 3, 2023| xzf0587 | update to support Teams Toolkit v5.0.0|

## Feedback
We really appreciate your feedback! If you encounter any issue or error, please report issues to us following the [Supporting Guide](https://github.com/OfficeDev/TeamsFx-Samples/blob/dev/SUPPORT.md). Meanwhile you can make [recording](https://aka.ms/teamsfx-record) of your journey with our product, they really make the product better. Thank you!
