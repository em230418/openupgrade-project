1. sql.gz-дамп указываем в common.sh

2. Последовательно выполняем следующие команды

./prepare.sh
./upload11.sh
./migrate12.sh
./migrate13.sh
./migrate14.sh
./migrate15.sh
./migrate16.sh
./migrate17.sh
./dowload17.sh

3. Заливаем свежий файл backup*.sql.gz

4. filestore переносим отдельно
