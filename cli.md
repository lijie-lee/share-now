## Try the Sample with TeamsFx CLI

1. Install [Node.js](https://nodejs.org/en/download/) (use the LTS release)
1. To install the TeamsFx CLI, use the npm package manager:
    ```
    npm install -g @microsoft/teamsfx-cli
    ```
1. Create a Share Now project:
    ```
    teamsfx new template share-now
    ```
1. Provision the project to Azure. You will be asked to input admin name and password for SQL:
    ```
    teamsfx provision
    ```
1. Deploy:
    ```
    teamsfx deploy
    ```
1. Open **env/.env.dev** file, you can find the database name in the `PROVISIONOUTPUT__AZURESQLOUTPUT__DATABASENAME` output. In the Azure portal, find the database and use the [query editor](https://learn.microsoft.com/azure/azure-sql/database/connect-query-portal) with the following query to create the required tables:
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
1. Refer to [manually add user](https://github.com/OfficeDev/TeamsFx/blob/dev/docs/fx-core/sql-help.md#step-2-add-database-user-manually) to add a user to the database.
1. Once you have successfully created the DB tables and added a user, you can preview the app running in Azure. In Visual Studio Code, open `Run and Debug` and select `Launch Remote (Edge)` or `Launch Remote (Chrome)` in the dropdown list and press `F5` or the green arrow button to open a browser.
