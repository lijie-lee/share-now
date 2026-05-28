# Getting Started with Share Now Sample

Share Now promotes the exchange of information between colleagues by enabling users to share content within the Teams environment. Users engage the app to share items of interest and discover new shared content.

![Share Now](images/shareNow.gif)

> Note: This sample will only provision [single tenant](https://learn.microsoft.com/azure/active-directory/develop/single-and-multi-tenant-apps#who-can-sign-in-to-your-app) Azure Active Directory app. For multi-tenant support, please refer to this [wiki](https://aka.ms/teamsfx-multi-tenant).

## This sample illustrates
- How to host your tab app frontend on Azure.
- How to host your tab app backend on Azure.
- How to host your app's message extension bot on Azure.
- How to connect to Azure SQL Database and perform CRUD operations.

## Prerequisites
- [Node.js](https://nodejs.org/), supported versions: 16, 18
- A Microsoft 365 account. If you do not have one, apply via the [Microsoft 365 Developer Program](https://developer.microsoft.com/en-us/microsoft-365/dev-program)
- [Teams Toolkit Visual Studio Code Extension](https://aka.ms/teams-toolkit) version 5.0.0 and higher or [TeamsFx CLI](https://aka.ms/teamsfx-cli)
- An [Azure subscription](https://azure.microsoft.com/en-us/free/)

## Minimal path to awesome
### Deploy the app to Azure
> Here are the instructions to run the sample in **Visual Studio Code**. You can also run the app using TeamsFx CLI. See [Try the Sample with TeamsFx CLI](cli.md).
1. Clone the repo to your local workspace or directly download the source code.
1. Open the project in Visual Studio Code.
1. Open **env/.env.dev.user** and set `SQL_USER_NAME` and `SQL_PASSWORD`.
1. Open the command palette and select `Teams: Provision`. The toolkit provisions Azure SQL for you.
1. Once provisioning is complete, open the command palette and select `Teams: Deploy`.
1. Open **env/.env.dev** to get the database name from `PROVISIONOUTPUT__AZURESQLOUTPUT__DATABASENAME`. [Add your computer IP address to the server-level firewall rule from the database overview page](https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-configure#from-the-database-overview-page).
1. In the Azure portal, find the database using `databaseName` and use [query editor](https://docs.microsoft.com/en-us/azure/azure-sql/database/connect-query-portal) with the query below to create a table:
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
1. Once deployment is completed, you can preview the app running in Azure. In Visual Studio Code, open `Run and Debug`, select `Launch Remote (Edge)` or `Launch Remote (Chrome)` from the dropdown list, and press `F5` (or the green arrow button) to open a browser.
1. The app will look like this when it runs for the first time:

	![Share Now](images/StartPage.png)

1. You can add new content by clicking the "Suggest content" button.
1. You can update content you created by clicking "..." and then selecting "update".
1. You can delete content you created by clicking "..." and then selecting "delete".
1. You can add or remove your vote by clicking the icon ![vote icon](images/voteIconME.png) on a content item.
1. You can search all content (or only your own content) in the compose box or command box by filtering on title or tags, then share with your colleagues.

### (Optional) Run the app locally
To debug the project, configure an Azure SQL Database for local use:
1. [Create an Azure SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?tabs=azure-portal)
1. [Add your computer IP address to the Azure SQL Server firewall allowlist](https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-configure#from-the-database-overview-page)
1. Use [query editor](https://docs.microsoft.com/en-us/azure/azure-sql/database/connect-query-portal) with the query below to create tables:
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
1. Open **env/.env.local** and set the following values using the Azure SQL Database you just created:
    ```
    SQL_ENDPOINT=
    SQL_DATABASE_NAME=
    ```
1. Open **env/.env.local.user** and set the following values using the Azure SQL Database you just created:
    ```
    SQL_USER_NAME=
    SQL_PASSWORD=
    ```
1. Open Debug View (`Ctrl+Shift+D`) and select "Debug (Edge)" or "Debug (Chrome)" in the dropdown list.
1. Press `F5` to open a browser window, then select your package to view the Share Now sample app.



## Version History

|Date| Author| Comments|
|---|---|---|
|May 13 2021| xzf0587 | Onboard |
|May 18, 2022| xzf0587 | Updated to support Teams Toolkit v4.0.0 |
|April 3, 2023| xzf0587 | Updated to support Teams Toolkit v5.0.0 |

## Feedback
We really appreciate your feedback! If you encounter an issue or error, please report it by following the [Supporting Guide](https://github.com/OfficeDev/TeamsFx-Samples/blob/dev/SUPPORT.md). You can also make a [recording](https://aka.ms/teamsfx-record) of your experience with our product—your feedback helps us make it better. Thank you!
