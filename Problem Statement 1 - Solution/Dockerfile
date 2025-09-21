# Ubuntu as base image
FROM ubuntu:22.04

# Environment variables to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update Package list and install required packages
RUN apt-get update && \
    apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Add cowsay to PATH
ENV PATH="/usr/games:${PATH}"

# Create a non-root user for security
RUN useradd -m -u 1000 wisecow

# Set working directory
WORKDIR /app

# Copy the wisecow script
COPY wisecow.sh /app/wisecow.sh

# Make the script executable
RUN chmod +x /app/wisecow.sh

# Change ownership to the wisecow user
RUN chown -R wisecow:wisecow /app

# Switch to non-root user
USER wisecow

# Expose port 4499
EXPOSE 4499

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD nc -z localhost 4499 || exit 1

# Run the wisecow application
CMD ["/app/wisecow.sh"]
