SELECT
	ROUND(AVG(price), 1) AS СРЕДНЯЯ_ЦЕНА,
	ROUND(AVG((price - (SELECT AVG(price) FROM PRODUCT WHERE ware = 'Meat')) * (price - (SELECT AVG(price) FROM PRODUCT WHERE ware = 'Meat'))), 1) AS ДИСПЕРСИОННАЯ_ЦЕНА
FROM PRODUCT
WHERE ware = 'Meat';
