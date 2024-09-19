SELECT * FROM employeedb.employee;
SELECT e.rowid, e.id_emp, e.name_emp, e.age, g.gol_name
FROM employee e
INNER JOIN golongan g ON e.gol = g.gol;