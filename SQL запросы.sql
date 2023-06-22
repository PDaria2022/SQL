-- Найти информацию о всех контрактах, связанных с сотрудниками департамента «Logistic». Вывести: contract_id, employee_name

SELECT ex.contract_id, em.name FROM executor ex
 JOIN employees em ON em.id = ex.tab_no
 JOIN department de ON de.id = em.department_id AND de.name = 'Logistic'



--Найти среднюю стоимость контрактов, заключенных сотрудников Ivan Ivanov. Вывести: среднее значение amount

SELECT AVG(co.amount) FROM executor ex
 JOIN contract co ON co.id = ex.contract_id
 JOIN employees em ON em.id = ex.tab_no AND em.name = 'Ivan Ivanov'


--Найти самую часто встречающуюся локации среди всех заказчиков. Вывести: location, count


SELECT location, COUNT(customer.id) FROM customer
GROUP BY location 
HAVING COUNT(customer.id) = 
    (SELECT COUNT(customer.id) FROM customer
     GROUP BY location 
     ORDER BY COUNT(customer.id)
     DESC
	 LIMIT 1)


--Найти контракты одинаковой стоимости. Вывести count, amount

SELECT amount, COUNT(contract.id) FROM contract
GROUP BY amount
HAVING COUNT(contract.id) > 1


--Найти заказчика с наименьшей средней стоимостью контрактов. Вывести customer_name, среднее значение amount

SELECT customer_name, ROUND(AVG(co.amount), 2) FROM customer cu
JOIN contract co ON cu.id = co.customer_id
GROUP BY customer_name
HAVING AVG(co.amount)=
(SELECT AVG(co.amount) FROM customer cu
JOIN contract co ON cu.id = co.customer_id
GROUP BY customer_name
ORDER BY AVG(co.amount)
LIMIT 1)


--Найти отдел, заключивший контрактов на наибольшую сумму. Вывести: department_name, sum


SELECT de.name, SUM(co.amount) FROM executor ex
 JOIN employees em ON em.id = ex.tab_no
 JOIN department de ON de.id = em.department_id
 JOIN contract co ON co.id = ex.contract_id
 GROUP BY de.name
HAVING SUM(co.amount) = 
 (SELECT SUM(co.amount) FROM executor ex
 JOIN employees em ON em.id = ex.tab_no
 JOIN department de ON de.id = em.department_id
 JOIN contract co ON co.id = ex.contract_id
 GROUP BY de.name
 ORDER BY SUM(co.amount)
 DESC
 LIMIT 1) 



