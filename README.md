# 🚀 DevOps Docker Projects

This repository contains multiple useful Docker-related projects that any developer or DevOps engineer may find helpful.

## 📌 Projects

1. [Docker Command on Disk Threshold](https://github.com/vaggeliskls/devops-docker-projects/tree/main/docker-prune-disk-threshold): This project monitors hard disk usage at regular intervals. When the threshold is reached, a Docker-related command can be executed and notification with a webhook.
  
3. [OpenLDAP Server](https://github.com/vaggeliskls/devops-docker-projects/tree/main/open-ldap-server): This project provides an OpenLDAP server along with an administration interface for managing LDAP entries efficiently.
   
4. [Windows GitHub Custom Runner](https://github.com/vaggeliskls/windows-github-custom-runner): A custom GitHub Actions runner for Windows environments in a container.
   
5. [Windows in docker container](https://github.com/vaggeliskls/windows-in-docker-container): Run Windows inside a Docker container for testing and development purposes.
   
7. [Docusaurus to pdf](https://github.com/vaggeliskls/docusaurus-to-pdf): Convert Docusaurus documentation to a PDF file effortlessly.

8. [Buttercup Webdav Server](https://github.com/vaggeliskls/buttercup-webdav-server): A WebDAV server tailored for Buttercup, enabling secure and efficient password storage.

9. [WebDav server](https://github.com/vaggeliskls/webdav-server): A simple and powerful WebDAV server for file sharing and remote storage management.

10. [MCP Servers](https://github.com/vaggeliskls/devops-docker-projects/tree/main/mcp-servers): Local MCP server exposing Confluence and Jira as tools to Claude via the Model Context Protocol. Runs as a Docker container using `streamable-http` transport.

### Claude MCP Remote Configuration

Once the MCP server is running (see the [mcp-servers README](https://github.com/vaggeliskls/devops-docker-projects/tree/main/mcp-servers)), manage it with the Claude Code CLI:

| Command | Description |
|---|---|
| `claude mcp add atlassian --transport http http://localhost/atlassian/mcp` | Add the MCP server |
| `claude mcp remove atlassian` | Remove the MCP server |
| `claude mcp list` | List all configured MCP servers |

Or add it manually to `~/.claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "atlassian": {
      "type": "http",
      "url": "http://localhost/atlassian/mcp"
    }
  }
}
```

## 💡 Contribution

Feel free to contribute by submitting pull requests or opening issues.

## ⭐ Support

If you find this repository useful, consider giving it a star ⭐ to show your support!
