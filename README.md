# Crawl4AI MCP Server - Elast.io Deployment

This repository contains a production-ready deployment configuration for the Crawl4AI MCP Server on Elast.io platform using Docker.

## What is Crawl4AI MCP?

Crawl4AI MCP is a Model Context Protocol (MCP) server that provides advanced web crawling and content extraction capabilities powered by the crawl4ai library. It enables:

- 🔍 Advanced web crawling with JavaScript support
- 🌐 Universal content extraction from web pages, PDFs, Office documents
- 🤖 AI-powered content summarization and analysis
- 🎬 YouTube transcript extraction
- 🔍 Google Search integration

## Quick Deploy on Elast.io

1. **Push this repository to your GitHub account**

2. **Import in Elast.io:**
   - Select "Import from GitHub"
   - Choose "Docker Compose" method
   - Select this repository

3. **Use the following configuration:**

   **Build Command:**
   ```
   pip install --no-cache-dir -r requirements.txt && playwright install chromium
   ```

   **Install Command:**
   ```
   playwright install-deps
   ```

   **Run Command:**
   ```
   python -m crawl4ai_mcp.server --transport http --host 0.0.0.0 --port 8000
   ```

4. **Set Environment Variables:**
   - `PYTHONUNBUFFERED=1`
   - `FASTMCP_LOG_LEVEL=INFO`
   - `CRAWL4AI_BROWSER_TYPE=chromium`
   - `CRAWL4AI_HEADLESS=true`
   - `PLAYWRIGHT_BROWSERS_PATH=/ms-playwright`
   - `DISPLAY=:99`

   Optional (for AI features):
   - `OPENAI_API_KEY` - Your OpenAI API key
   - `ANTHROPIC_API_KEY` - Your Anthropic API key
   - `GOOGLE_SEARCH_API_KEY` - Your Google Search API key
   - `GOOGLE_SEARCH_ENGINE_ID` - Your Google Search Engine ID

5. **Configure Reverse Proxy:**
   - Target: `172.17.0.1`
   - Port: `8000`

## Local Development

### Using Docker Compose

```bash
# Build and run
docker-compose up --build

# Access the server
curl http://localhost:8000/health
```

### Manual Setup

```bash
# Install dependencies
pip install -r requirements.txt

# Install Playwright browsers
playwright install chromium
playwright install-deps

# Run the server
python -m crawl4ai_mcp.server --transport http --host 0.0.0.0 --port 8000
```

## Features

- **Web Crawling Tools:**
  - Single page crawling
  - Deep site crawling
  - Batch URL processing
  - Fallback crawling strategies

- **AI-Powered Analysis:**
  - Intelligent content extraction
  - Automatic summarization
  - Entity extraction

- **Media Processing:**
  - PDF to markdown conversion
  - Office document processing
  - YouTube transcript extraction

- **Search Integration:**
  - Google Search with filters
  - Search and crawl combined workflows

## Project Structure

```
crawl-mcp-elast/
├── Dockerfile              # Docker container configuration
├── docker-compose.yml      # Docker Compose configuration
├── requirements.txt        # Python dependencies
├── .env.example           # Environment variables template
├── DEPLOYMENT.md          # Detailed deployment instructions
├── README.md              # This file
└── crawl4ai_mcp/          # Application source code
```

## Security

- All sensitive API keys should be stored as environment variables in Elast.io
- Never commit API keys or secrets to the repository
- The application runs as a non-root user in Docker for security

## Documentation

- [DEPLOYMENT.md](DEPLOYMENT.md) - Detailed deployment instructions for Elast.io
- [Original Crawl4AI MCP](https://github.com/exelmedia/crawl-mcp) - Upstream project

## Troubleshooting

See [DEPLOYMENT.md](DEPLOYMENT.md) for common issues and solutions.

## License

This deployment configuration is provided as-is. The Crawl4AI MCP Server is subject to its own license terms.

## Support

For deployment issues:
- Check [DEPLOYMENT.md](DEPLOYMENT.md)
- Review Elast.io documentation
- Contact Elast.io support

For application issues:
- Visit the [original Crawl4AI MCP repository](https://github.com/exelmedia/crawl-mcp)
