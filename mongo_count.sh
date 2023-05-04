#!/bin/bash

# Установка значений переменных
MONGODB_URI="mongodb://localhost:27017/db"            # URI базы данных MongoDB
DB_NAME="db"                                           # Название базы данных
COLLECTION_NAME="collection_name"                                 # Название коллекции
ID_ARRAY=("ObjectId(\"id\")" "ObjectId(\"id\")")     # Массив ObjectId поисковых запросов

# Формирование массива фильтров
#FILTERS=()
for OBJECT_ID in "${ID_ARRAY[@]}"
do
  COUNT=$(mongo --quiet $MONGODB_URI --eval "db.${COLLECTION_NAME}.count({subject: $OBJECT_ID})")
  echo "Количество записей в коллекции $COLLECTION_NAME базы данных $DB_NAME id $OBJECT_ID: $COUNT"
done
