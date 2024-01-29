# gunicorn_config.py

# Number of worker processes
workers = 4

# Bind the server to all IP addresses of your host
bind = '0.0.0.0:5000'

# Timeout in seconds
timeout = 180
