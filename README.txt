1. sql.gz-дамп указываем в common.sh

2. Последовательно выполняем следующие команды

./prepare.sh
./upload16.sh
./migrate16.sh
./migrate17.sh
./migrate18.sh
./dowload18.sh

3. Заливаем свежий файл backup*.sql.gz

4. filestore переносим отдельно
