#!/bin/bash

# Переменные
BACKUP_PATH="/var/opt/gitlab/backups"
REMOTE_HOST="remote-host"
REMOTE_PATH="remote-dir"

# Создаем резервную копию
sudo gitlab-backup create

# Копируем созданную резервную копию на удаленный хост
rsync -avz --delete $BACKUP_PATH/ $REMOTE_HOST:$REMOTE_PATH
