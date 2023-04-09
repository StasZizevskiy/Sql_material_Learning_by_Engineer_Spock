select *
from Products as t1 inner join Categories as t2 on t1.CategoryID = t2.CategoryID

select t2.City, count(*), count(distinct t2.CustomerID)
from Orders as t1 inner join Customers as t2 on t1.CustomerID = t2.CustomerID
where t2.Country = 'Germany'
group by t2.City
order by count(*) desc

select *
from Products

select t2.ProductName, sum(t1.UnitPrice*t1.Quantity*(1-t1.Discount)) as sum
from [Order Details] as t1 inner join Products as t2 on t1.ProductID = t2.ProductID
where CategoryID = 1
group by t2.ProductName

select *
from Customers as t1 inner join Orders as t2 on t1.CustomerID = t2.CustomerID


select distinct t3.ContactName
from Orders as t1 inner join Employees as t2 on t1.EmployeeID = t2.EmployeeID
				  inner join Customers as t3 on t1.CustomerID = t3.CustomerID
where t2.FirstName = 'Robert' and t2.LastName = 'King' 

select count(*)
from Employees as t1 inner join Orders as t2 on t1.EmployeeID = t2.EmployeeID
where t1.FirstName = 'Andrew' and t1.LastName = 'Fuller'

select sum(t2.Quantity*t2.UnitPrice*(1-t2.Discount))
from Orders as t1 inner join [Order Details] as t2 on t1.OrderID = t2.OrderID
where t1.OrderDate like '%1997%'

select t1.CategoryName, count(t2.ProductName)
from Categories as t1 inner join Products as t2 on t1.CategoryID = t2.CategoryID
group by t1.CategoryName

select t3.FirstName, t3.LastName
from Orders as t1 inner join Customers as t2 on t1.CustomerID = t2.CustomerID
                  inner join Employees as t3 on t1.EmployeeID = t3.EmployeeID
where t2.ContactName = 'Francisco Chang'

select *
from Customers

select *
from Employees
