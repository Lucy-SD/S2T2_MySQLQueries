USE tienda;

-- 1. List the name of all the products in the product table.

SELECT nombre FROM producto;

-- 2. Lists the names and prices of all the products in the product table.

SELECT nombre, precio FROM producto;

-- 3. List all the columns in the product table.

SELECT * FROM producto;

-- 4. List the name of the products, the price in euros, and the price in US dollars (USD).

SELECT nombre, precio, precio * 1.10 U$S
FROM producto;

-- 5. List the product name, the price in euros, and the price in US dollars (USD). Use the following column alies: product name, euros, dollars.

SELECT nombre, precio euros, precio * 1.10 dolares
FROM producto;

-- 6. Lists the names and prices of all the products in the product table, converting the names to upperce.

SELECT UPPER(nombre) nombre, precio
FROM producto;


-- 7. Lists the names and prices of all the products in the product table, converting the names to lowerce.

SELECT LOWER(nombre) nombre, precio
FROM producto;

-- 8. List the name of all the manufacturers in one column, and in another column capitalize the first two characters of the manufacturer's name.

SELECT nombre, UPPER(LEFT(nombre, 2)) iniciales
FROM fabricante;

-- 9. Lists the names and prices of all the products in the product table, rounding the price value.

SELECT nombre, ROUND(precio) redondeado FROM
producto;

-- 10. Lists the names and prices of all products in the product table, truncating the price value to display it without any decimal places.

SELECT nombre, TRUNCATE(precio, 0) precio_redondeado
FROM producto;

-- 11. List the code of the manufacturers that have products in the product table.

SELECT codigo_fabricante
FROM producto;

-- 12. List the code of the manufacturers that have products in the product table, eliminating codes that appear repeatedly. 

SELECT DISTINCT codigo_fabricante
FROM producto;

-- 13. List the names of the manufacturers in cending order.

SELECT nombre
FROM fabricante
ORDER BY nombre;

-- 14. List the names of the manufacturers in descending order.

SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

-- 15. Lists the names of the products sorted, first, by name in cending order and, second, by price in descending order.

SELECT nombre, precio
FROM producto
ORDER BY nombre, precio DESC;

-- 16. Returns a list with the first 5 rows of the manufacturer table.

SELECT *
FROM fabricante
LIMIT 5;

-- 17. Returns a list with 2 rows starting from the fourth row of the manufacturer table. The fourth row must also be included in the response.

SELECT *
FROM fabricante
LIMIT 2 OFFSET 3;

-- 18. List the name and price of the cheapest product. (Use only ORDER BY and LIMIT clauses.) NOTE: You couldn't use MIN(price) here, you would need GROUP BY.

SELECT nombre, precio
FROM producto
ORDER BY precio LIMIT 1;

-- 19. List the name and price of the most expensive product. (Use only ORDER BY and LIMIT clauses.) NOTE : You couldn't use MAX(price) here, you would need GROUP BY.

SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- 20. Lists the name of all products from the manufacturer whose manufacturer code is equal to 2.

SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

-- 21. Returns a list with the product name, price and manufacturer name of all products in the databe.

SELECT p.nombre producto, p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 22. Returns a list with the product name, price, and manufacturer name of all products in the databe. Sorts the result by manufacturer name, in alphabetical order.

SELECT p.nombre producto , p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY fabricante;

-- 23. Returns a list with the product code, product name, manufacturer code and manufacturer name of all the products in the databe.

SELECT p.codigo codigo_producto, p.nombre producto, 
f.codigo codigo_fabricante, f.nombre fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 24. Returns the product name, its price and the name of its manufacturer, of the cheapest product.

SELECT p.nombre producto, p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON f.codigo = p.codigo_fabricante
ORDER BY p.precio LIMIT 1;

-- 25. Returns the product name, its price and the name of its manufacturer, of the most expensive product.

SELECT p.nombre producto, p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON f.codigo = p.codigo_fabricante
ORDER BY p.precio DESC LIMIT 1;

-- 26. Returns a list of all products from the manufacturer "Lenovo".

SELECT p.nombre producto
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Lenovo";

-- 27. Returns a list of all products from the manufacturer "Crucial" that have a price greater than €200.

SELECT p.nombre producto
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Crucial" AND precio > 200;

-- 28. Returns a list with all products from manufacturers "Asus", "Hewlett-Packard", and "Seagate". Without using the IN operator.

SELECT p.nombre producto
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Asus"
OR f.nombre = "Hewlett-Packard" OR f.nombre = "Seagate";

-- 29. Returns a list with all products from manufacturers us, "Hewlett-Packard", and "Seagate". Using the IN operator.

SELECT p.nombre producto
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

-- 30. Returns a list with the name and price of all products from manufacturers whose names end with the vowel e.

SELECT p.nombre producto, p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE LOWER(RIGHT(f.nombre, 1)) = 'e';

-- 31. Returns a list with the name and price of all products whose manufacturer name contains the character w in their name.

SELECT p.nombre producto, p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE LOWER(f.nombre) LIKE '%w%';

-- 32. Returns a list with the product name, price and manufacturer name of all products that have a price greater than or equal to €180. Sorts the result, first, by price (in descending order) and, second, by name (in ascending order).

SELECT p.nombre producto, p.precio, f.nombre fabricante
FROM producto p
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre;

-- 33. Returns a list with the manufacturer code and name, only of those manufacturers that have sociated products in the databe.

SELECT DISTINCT p.codigo_fabricante codigo_fabricante, f.nombre nombre_fabricante
FROM fabricante f
JOIN producto p ON p.codigo_fabricante = f.codigo;

-- 34. Returns a list of all manufacturers that exist in the databe, along with the products that each of them h. The list should also show those manufacturers that do not have sociated products.

SELECT f.nombre fabricante, p.nombre producto
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. Returns a list where only those manufacturers that do not have any sociated products appear.

SELECT f.nombre fabricante, p.nombre producto
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- 36. Returns all products from the manufacturer "Lenovo". (Without using INNER JOIN).

SELECT nombre productos
FROM producto
WHERE codigo_fabricante =(
	SELECT codigo
	FROM fabricante
	WHERE nombre = "Lenovo");

-- 37. Returns all data for products that have the same price the most expensive product from the manufacturer "Lenovo". (Without using INNER JOIN).

SELECT *
FROM producto p
WHERE p.precio = (
	SELECT MAX(pp.precio)
	FROM producto pp
	WHERE pp.codigo_fabricante = (
		SELECT f.codigo
        FROM fabricante f
        WHERE f.nombre = "Lenovo"
));

-- 38. List the name of the most expensive product from the manufacturer "Lenovo".

SELECT p.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Lenovo"
ORDER BY precio DESC
LIMIT 1;

-- 39. List the name of the cheapest product from the manufacturer "Hewlett-Packard".

SELECT p.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Hewlett-Packard"
ORDER BY precio
LIMIT 1;

-- 40. Returns all products in the databe that have a price greater than or equal to the most expensive product from the manufacturer "Lenovo".

SELECT nombre producto
FROM producto
WHERE precio >= (
	SELECT MAX(p.precio)
	FROM producto p
	JOIN fabricante f ON p.codigo_fabricante = f.codigo
	WHERE f.nombre = "Lenovo");

-- 41. List all products from the manufacturer "Asus" that are priced higher than the average price of all their products.

SELECT p.nombre producto, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Asus"
AND p.precio > (
	SELECT AVG(p2.precio)
	FROM producto p2
	JOIN fabricante f2 ON p2.codigo_fabricante = f2.codigo
	WHERE f2.nombre = "Asus"
);