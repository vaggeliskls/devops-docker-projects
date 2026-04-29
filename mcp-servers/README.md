# MCP Servers

A local MCP server that exposes Confluence and Jira as tools to Claude via the [Model Context Protocol](https://modelcontextprotocol.io). Runs as a Docker container using the `streamable-http` transport on port `8080`.

## Prerequisites

- Docker

## Setup

### 1. Configure credentials

Copy `.env` and fill in your Atlassian credentials:

```
CONFLUENCE_URL=https://<your-org>.atlassian.net
CONFLUENCE_USERNAME=you@example.com
CONFLUENCE_API_TOKEN=<your-token>

JIRA_URL=https://<your-org>.atlassian.net
JIRA_USERNAME=you@example.com
JIRA_API_TOKEN=<your-token>
```

Generate an API token at: https://id.atlassian.com/manage-profile/security/api-tokens

#### Required API Scopes

When creating your service account or API token, ensure the following scopes are granted:

**Confluence:**
- `read:confluence-content.all`
- `read:confluence-space.summary`

**Jira:**
- `read:jira-work`
- `read:jira-user`

### 2. Start the server

```sh
docker compose up -d
```

The server will be available at `http://localhost:8080/mcp`.

---

## Claude MCP CLI

### Add the server to Claude

```sh
claude mcp add --transport http atlassian http://localhost/atlassian/mcp
```

### List registered MCP servers

```sh
claude mcp list
```

### Remove the server from Claude

```sh
claude mcp remove atlassian
```

---

## Docker commands

| Command | Description |
|---|---|
| `docker compose up -d` | Start the server (detached) |
| `docker compose down` | Stop and remove the container |
| `docker compose restart` | Restart the container |
| `docker compose logs -f` | Tail live server logs |

---

## Available tools

The server exposes 44 read-only tools across two toolsets.

### Jira

| Tool | Description |
|---|---|
| `jira_search` | Search issues using JQL |
| `jira_get_issue` | Get details of a specific issue |
| `jira_get_all_projects` | List all Jira projects |
| `jira_get_project_issues` | List issues in a project |
| `jira_get_agile_boards` | List agile boards |
| `jira_get_board_issues` | Get issues on a board |
| `jira_get_sprints_from_board` | List sprints for a board |
| `jira_get_sprint_issues` | Get issues in a sprint |
| `jira_get_transitions` | Get available transitions for an issue |
| `jira_get_worklog` | Get worklogs for an issue |
| `jira_get_user_profile` | Get a user's profile |
| `jira_get_issue_watchers` | Get watchers of an issue |
| `jira_batch_get_changelogs` | Get changelogs for multiple issues |
| `jira_get_issue_sla` | Get SLA info for an issue |
| `jira_get_issue_development_info` | Get linked PRs/branches for an issue |

### Confluence

| Tool | Description |
|---|---|
| `confluence_search` | Search pages using CQL |
| `confluence_get_page` | Get a specific page by ID |
| `confluence_get_page_children` | List child pages |
| `confluence_get_space_page_tree` | Get full page tree of a space |
| `confluence_get_comments` | Get comments on a page |
| `confluence_get_labels` | Get labels on a page |
| `confluence_get_page_history` | Get revision history of a page |
| `confluence_get_page_views` | Get view analytics for a page |
| `confluence_get_attachments` | List attachments on a page |

---

## Notes

- The server runs in `READ_ONLY_MODE=true` — no writes are possible.
- The server uses FastMCP `streamable-http` transport, so plain `curl` requires `Accept: application/json, text/event-stream` and a valid `mcp-session-id` header.
