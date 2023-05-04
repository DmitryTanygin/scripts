#!/bin/bash

# Установка значений переменных
MONGODB_URI="mongodb://localhost:27017/openschool"            # URI базы данных MongoDB
DB_NAME="openschool"                                           # Название базы данных
COLLECTION_NAME="lessons"                                 # Название коллекции
ID_ARRAY=("ObjectId(\"5b76c3f64ec1cd3415d7d90f\")" "ObjectId(\"5b76c3f64ec1cd3415d7d90e\")")     # Массив ObjectId поисковых запросов

# Формирование массива фильтров
#FILTERS=()
for OBJECT_ID in "${ID_ARRAY[@]}"
do
  COUNT=$(mongo --quiet $MONGODB_URI --eval "db.${COLLECTION_NAME}.count({subject: $OBJECT_ID})")
  echo "Количество записей в коллекции $COLLECTION_NAME базы данных $DB_NAME id предмета $OBJECT_ID: $COUNT"
done
