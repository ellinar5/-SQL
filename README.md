# Аналитика SQL
## Использованное ПО для SQL
Для начала хочу сказать что используется  SQL lite [на данное платформе](https://sqliteonline.com/)

А также [данное приложение для Windows](https://sqlitebrowser.org/dl/)

## Основная база данных
За основу баз данных используется [данный файл](/images/wares_20240802.sqlite3)

Как наглядно выглядит данная база данных:
![бд](/images/ВизуализацияОсновнойTаблицы.png)

## О самих заданий
<details>
<summary>
1 пак задач
</summary>

## **Краткая справка о пакете**

Данный пакет задач посвящен основам работы с SQL, включая выполнение простых запросов, сортировку данных, операции с заданиями и простую агрегацию. Задачи направлены на освоение ключевых навыков взаимодействия с реляционными базами данных, такими как извлечение уникальных значений, фильтрация, сортировка, вычисление агрегатных функций (минимум, максимум, среднее, дисперсия) и работа с подзапросами.

## **Основные навыки, используемые для решения задач**

## 1. **Выбор уникальных значений**

Использование ключевого слова DISTINCT для исключения дубликатов в результатах запроса.

Пример:
``` bash
SELECT DISTINCT company FROM MANUFACTURER;
```

## **2. Агрегатные функции**

Применение функций COUNT, MIN, MAX, AVG для вычисления количества, минимального, максимального и среднего значений.

Пример:
``` bash
SELECT COUNT(DISTINCT company) FROM MANUFACTURER;
```

## **3.Фильтрация данных**

Использование WHERE для отбора записей по условию, включая операторы LIKE для поиска по шаблону.

Пример:
``` bash
SELECT DISTINCT company FROM MANUFACTURER WHERE company LIKE 'A%' OR company LIKE 'B%';
```

## **4.Сортировка результатов**

Применение ORDER BY для сортировки данных в алфавитном или числовом порядке.

Пример:
``` bash
SELECT DISTINCT company FROM MANUFACTURER ORDER BY company ASC;
```

## **5.Операции с множествами**

Использование EXCEPT для вычитания одного набора данных из другого.

Пример:
``` bash
SELECT DISTINCT WARE FROM PRODUCT
EXCEPT
SELECT WARE FROM MATERIAL;
```

## **6.Подзапросы**

Выполнение вложенных запросов для вычисления промежуточных результатов, например, для расчёта дисперсии.

Пример:
``` bash
SELECT ROUND(AVG(price), 1) AS Средняя_цена, 
       ROUND(AVG((price - (SELECT AVG(price) FROM PRODUCT WHERE ware = 'Meat')) * 
             (price - (SELECT AVG(price) FROM PRODUCT WHERE ware = 'Meat'))), 1) AS Дисперсионная_цена
FROM PRODUCT
WHERE ware = 'Meat';
```

## **7.Округление чисел**

Использование функции ROUND для округления результатов до заданного количества знаков после запятой.

## **8.Работа с соединениями таблиц**

Понимание связей между таблицами (например, CATEGORY, MANUFACTURER, PRODUCT, MATERIAL) для корректного составления запросов.

</details>

<details>
<summary>
2 пак задач
</summary>

## **Краткая справка о пакете**

Данный пакет задач продолжает изучение SQL, фокусируясь на более сложных запросах, включая работу с соединениями таблиц, операциями с множествами, подзапросами и анализом производственных цепочек. Задачи направлены на развитие навыков составления комплексных SQL-запросов, требующих глубокого понимания структуры базы данных и взаимосвязей между таблицами. Основные темы включают сортировку, фильтрацию, агрегацию, а также анализ данных с использованием множественных условий.

## **Основные навыки, используемые для решения задач**

## **1.Соединение таблиц (JOIN)**
Использование INNER JOIN, LEFT JOIN и других типов соединений для объединения данных из нескольких таблиц.

Пример:
``` bash
SELECT DISTINCT MANUFACTURER.company 
FROM MANUFACTURER 
JOIN PRODUCT ON MANUFACTURER.RECIPE_ID = PRODUCT.RECIPE_ID 
WHERE PRODUCT.ware = 'Drinking water';
```

## **2.Операции с множествами (INTERSECT, EXCEPT)**
Применение операций для нахождения пересечений или различий между наборами данных.

Пример:
``` bash
SELECT MANUFACTURER.COMPANY
FROM PRODUCT
JOIN MANUFACTURER ON MANUFACTURER.RECIPE_ID = PRODUCT.RECIPE_ID
JOIN CATEGORY ON PRODUCT.ware = CATEGORY.ware
WHERE CATEGORY.CLASS = 'Fuel'
INTERSECT
SELECT MANUFACTURER.COMPANY
FROM PRODUCT
JOIN MANUFACTURER ON MANUFACTURER.RECIPE_ID = PRODUCT.RECIPE_ID
JOIN CATEGORY ON PRODUCT.ware = CATEGORY.ware
WHERE CATEGORY.CLASS = 'Food';
```

## **3.Сложные условия фильтрации (WHERE, HAVING)**
Использование условий для отбора данных, включая комбинации с AND, OR, и LIKE.

Пример:
``` bash
WHERE CATEGORY.CLASS = 'Raw food';
```

## **4.Сортировка результатов (ORDER BY)**
Упорядочивание данных по одному или нескольким столбцам в возрастающем или убывающем порядке.

Пример:
``` bash
ORDER BY PRODUCT.ware ASC, MANUFACTURER.company ASC;
```

## **5.Агрегатные функции (COUNT, GROUP BY, HAVING)**
Группировка данных и применение агрегатных функций для анализа.

Пример:
``` bash
GROUP BY MANUFACTURER.COMPANY
HAVING COUNT(DISTINCT PRODUCT.ware) >= 2;
```

## **6.Подзапросы**
Использование вложенных запросов для выполнения промежуточных вычислений.

Пример:
``` bash
WHERE CATEGORY.CLASS = 'Mineral';
```

## **7.Анализ производственных цепочек**
Построение запросов для выявления последовательностей производства, где продукты одной стадии используются как материалы для другой.

Пример:
``` bash
-- Пример запроса для анализа цепочек (условный)
SELECT DISTINCT m1.COMPANY
FROM PRODUCT p1
JOIN MATERIAL m ON p1.WARE = m.WARE
JOIN PRODUCT p2 ON m.RECIPE_ID = p2.RECIPE_ID
JOIN MANUFACTURER m1 ON p1.RECIPE_ID = m1.RECIPE_ID
JOIN MANUFACTURER m2 ON p2.RECIPE_ID = m2.RECIPE_ID
WHERE m1.COMPANY = m2.COMPANY;
```

## **8.Уникальные комбинации данных (DISTINCT)**
Исключение дубликатов в результатах запросов.

Пример:
``` bash
SELECT DISTINCT MANUFACTURER.company, PRODUCT.ware;
```

## **9.Работа с категориями и классификациями**
Использование таблицы CATEGORY для фильтрации данных по типам товаров.

Пример:
``` bash
JOIN CATEGORY ON PRODUCT.ware = CATEGORY.ware
WHERE CATEGORY.CLASS = 'Raw food';
```
