#!/bin/bash

set -e

current_day=$(date '+%Y-%m-%d')

# Structure:
# ./
#  |- daily
#     |- 2021-07-05
#        |- <backup_name>.sql
#  |- weekly
#  |- monthly

cd /path/to/backup_dir
mkdir -p "./daily/$current_day"

# Create daily backup
docker exec -t <container_name> pg_dumpall -c -U <user> > "./daily/$current_day/<backup_name>.sql"

# Rotate daily backups
day_of_week=$(date '+%u')

if [ $day_of_week -eq 7 ]
then
        mkdir -p "./weekly/$current_day"
        daily_dir="./daily/$current_day"
        weekly_dir="./weekly/$current_day"
        cp -r "$daily_dir/." "$weekly_dir/."
fi

# Rotate montlhy backups
week_number=$(date '+%-W')
week_mod_four=$((week_number%4))

if [ $week_mod_four -eq 3 ] && [ $day_of_week -eq 7 ]
then
        mkdir -p "./monthly/$current_day"
        weekly_dir="./weekly/$current_day"
        monthly_dir="./monthly/$current_day"
        cp -r "$weekly_dir/." "$monthly_dir/."
fi

# Cleanup
find ./daily/. ! -name . -prune -type d | sort -r | tail -n+15 | xargs -I{} rm -r {}
find ./weekly/. ! -name . -prune -type d | sort -r | tail -n+3 | xargs -I{} rm -r {}
find ./monthly/. ! -name . -prune -type d | sort -r | tail -n+3 | xargs -I{} rm -r {}
