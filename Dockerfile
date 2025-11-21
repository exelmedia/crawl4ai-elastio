# Use Python 3.11 slim image for smaller size
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies for headless browsers and crawl4ai
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    software-properties-common \
    libnss3 \
    libnspr4 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libxss1 \
    libasound2 \
    fonts-liberation \
    libappindicator3-1 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgtk-3-0 \
    libx11-6 \
    libxext6 \
    libxfixes3 \
    libxtst6 \
    xdg-utils \
    libavcodec58 \
    libavformat58 \
    libgtk-4-1 \
    libxslt1.1 \
    libevent-2.1-7 \
    libwebpdemux2 \
    libenchant-2-2 \
    libsecret-1-0 \
    libhyphen0 \
    libgles2 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome for additional headless browser option
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install playwright browsers
RUN playwright install chromium firefox webkit

# Set up browser environment variables for headless operation
ENV DISPLAY=:99
ENV CHROME_BIN=/usr/bin/google-chrome
ENV CHROMIUM_BIN=/usr/bin/chromium-browser
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# Configure headless browser settings for optimal performance
ENV CHROME_FLAGS="--no-sandbox --disable-dev-shm-usage --disable-gpu --disable-extensions --disable-default-apps --disable-translate --disable-device-discovery-notifications --disable-software-rasterizer --disable-background-timer-throttling --disable-backgrounding-occluded-windows --disable-renderer-backgrounding --disable-features=TranslateUI --disable-ipc-flooding-protection --disable-hang-monitor --disable-prompt-on-repost --no-first-run --no-default-browser-check --disable-logging --disable-permission-action-reporting"

# Copy the application code
COPY crawl4ai_mcp/ ./crawl4ai_mcp/

# Create non-root user for security
RUN useradd --create-home --shell /bin/bash app && chown -R app:app /app
USER app

# Set additional runtime environment variables for browser optimization
ENV PYTHONUNBUFFERED=1
ENV CRAWL4AI_BROWSER_TYPE=chromium
ENV CRAWL4AI_HEADLESS=true

# Expose port for HTTP mode
EXPOSE 8000

# Default command runs the MCP server in HTTP mode
CMD ["python", "-m", "crawl4ai_mcp.server", "--transport", "http", "--host", "0.0.0.0", "--port", "8000"]
