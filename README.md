# Docker Rsync over SSL Backup

Minimal Alpine Linux Docker container with rsync (over SSL) backup capability.

## Environment Configuration

- `RSYNC_SSL_CERT` - required
- `RSYNC_SSL_KEY` - required
- `RSYNC_SSL_CA_CERT` - required
- `RSYNC_SSL_PORT` - default 8873
- `RSYNC_ARGS` - rsync args
- `RSYNC_SSL_TIMEOUT` - default 0

- `BACKUP_PATH` - Defaults to `/mnt/data`
- `BACKUP_EXCLUDE_PATH` - Paths to exclude
- `REMOTE` - Remote hostname (required)
- `REMOTE_MODULE` - Defaults to `backup`

## Status

Stable used in production.
