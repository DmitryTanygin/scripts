#!/bin/bash

# Переменная с именем файла для копирования
FILE=example.txt
REMOTE_PATH=/path/to/dir

# Цикл для копирования файла на каждый удаленный хост
for host in $(cat ~/hosts.txt); do
  scp $FILE $host:$REMOTE_PATH
done
