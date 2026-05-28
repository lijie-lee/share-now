# Share Now Project Description

Share Now is a Microsoft Teams sample app that helps colleagues share useful content and discover posts from others.

## What the project includes

- **Teams tab frontend (`tabs/`)**: UI for suggesting content, browsing posts, voting, and managing your own entries.
- **Azure Functions backend (`api/`)**: APIs for creating, updating, deleting, querying posts, and handling votes.
- **Message extension bot (`bot/`)**: Search and sharing experience from the Teams compose/command box.
- **Azure SQL integration**: Stores shared posts and user votes.

## Core user flow

1. Users create content suggestions in the tab.
2. Users view, search, and filter shared content.
3. Users vote on content.
4. Users update or remove their own content.
5. Users share content directly in Teams conversations via message extension.
