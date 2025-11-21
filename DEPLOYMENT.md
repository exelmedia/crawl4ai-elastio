# Elast.io Deployment Configuration

## Overview
This document contains the exact configuration for deploying Crawl4AI MCP Server on Elast.io using Docker Compose.

## Deployment Steps

### 1. Import from GitHub
In Elast.io, select **Import from GitHub** and choose **Docker Compose** method.

### 2. Build Command
```
pip install --no-cache-dir -r requirements.txt && playwright install chromium
```

### 3. Install Command
```
playwright install-deps
```

### 4. Run Command
```
python -m crawl4ai_mcp.server --transport http --host 0.0.0.0 --port 8000
```

### 5. Environment Variables

Add the following environment variables in Elast.io:

**Required:**
- `PYTHONUNBUFFERED=1`
- `FASTMCP_LOG_LEVEL=INFO`
- `CRAWL4AI_BROWSER_TYPE=chromium`
- `CRAWL4AI_HEADLESS=true`
- `PLAYWRIGHT_BROWSERS_PATH=/ms-playwright`
- `DISPLAY=:99`

**Optional (for AI features):**
- `OPENAI_API_KEY` - Your OpenAI API key
- `ANTHROPIC_API_KEY` - Your Anthropic API key
- `GOOGLE_SEARCH_API_KEY` - Your Google Search API key
- `GOOGLE_SEARCH_ENGINE_ID` - Your Google Search Engine ID

**Important:** Store sensitive API keys securely in Elast.io environment variables, not in code.

### 6. Reverse Proxy Configuration

**Target:** 172.17.0.1  
**Port:** 8000

## Testing the Deployment

Once deployed, you can test the server by accessing:
```
https://your-service.vm.elestio.app/
```

## Health Check

The server includes a health check endpoint that you can use to verify it's running:
```
GET https://your-service.vm.elestio.app/health
```

## Troubleshooting

### Common Issues

1. **Browser Installation Fails**
   - Ensure the install command runs successfully
   - Check that all system dependencies are installed

2. **Port Not Accessible**
   - Verify reverse proxy configuration
   - Ensure port 8000 is exposed in Dockerfile

3. **Environment Variables Not Working**
   - Check that variables are properly set in Elast.io dashboard
   - Avoid using special characters or quotes in Elast.io interface

## Notes

- This configuration is optimized for Elast.io Docker deployment
- The server runs in HTTP mode for web access
- Playwright browsers are installed during the build process
- All sensitive data should be stored in environment variables

## Support

For issues specific to:
- Crawl4AI MCP: https://github.com/exelmedia/crawl-mcp
- Elast.io platform: https://elest.io/support
