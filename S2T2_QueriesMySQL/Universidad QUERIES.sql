USE Universidad;

-- 1. Returns a list with the first lastname, second lastname, and name of all students. The list must be sorted alphabetically from lowest to highest by first lastname, second lastname, and name.

SELECT apellido1 primer_apellido, apellido2 segundo_apellido, nombre
FROM persona
WHERE tipo = "alumno"
ORDER BY apellido1, apellido2, nombre;

-- 2. Find out the name and both surnames of students who have not registered their telephone number in the database.

SELECT nombre, CONCAT(apellido1, " ", apellido2) apellidos
FROM persona
WHERE tipo = "alumno"
AND telefono IS NULL;

-- 3. Returns the list of students who were born in 1999.

SELECT nombre, CONCAT(apellido1, " ", apellido2) apellidos
FROM persona
WHERE tipo = "alumno"
AND YEAR(fecha_nacimiento) = 1999;

-- 4. Returns the list of teachers who have not registered their telephone number in the database and whose NIF ends in K.

SELECT nombre, CONCAT(apellido1, " ", apellido2) apellidos
FROM persona
WHERE tipo = "profesor"
AND telefono IS NULL
AND LOWER(RIGHT(nif, 1)) = 'k';

-- 5. Returns the list of subjects taught in the first semester, in the third year of the degree that has the identifier 7.

SELECT nombre asignatura
FROM asignatura
WHERE cuatrimestre = 1
AND curso = 3
AND id_grado = 7;

-- 6. Returns a list of professors along with the name of the department they are linked to. The list should return four columns, first lastname, second lastname, name, and department name. The result will be sorted alphabetically from lowest to highest by last nameS and name.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre departamento
FROM persona p
JOIN profesor pro ON p.id = pro.id_profesor
JOIN departamento d ON pro.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7. Returns a list with the name of the subjects, start year and end year of the school year of the student with NIF 26902806M.

SELECT a.nombre asignatura, c.anyo_inicio inicio, c.anyo_fin finalizacion,
CONCAT(p.apellido1, " ", p.apellido2) apellidos, p.nombre
FROM persona p
JOIN alumno_se_matricula_asignatura al ON p.id = al.id_alumno
JOIN asignatura a ON al.id_asignatura = a.id
JOIN curso_escolar c ON al.id_curso_escolar = c.id
WHERE p.nif = "26902806M";

-- 8. Returns a list with the names of all the departments that have professors who teach a subject in the Degree in Computer Engineering Ingenieria Informática g.id = 4 (Plan 2015).

SELECT DISTINCT d.nombre departamento
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura a ON p.id_profesor = a.id_profesor
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)";

-- 9. Returns a list of all students who have enrolled in a subject during the 2018/2019 school year.

SELECT DISTINCT p.nombre, CONCAT(p.apellido1, " ", p.apellido2) apellidos
FROM persona p
JOIN alumno_se_matricula_asignatura al ON p.id = al.id_alumno
JOIN curso_escolar c ON al.id_curso_escolar = c.id
WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019;

-- * Solve the following 6 queries using LEFT JOIN and RIGHT JOIN clauses.

-- 1. Returns a list with the names of all professors and the departments they are associated with. The list should also show those professors who do not have any associated departments. The list should return four columns, department name, first lastname, second lastname and professor's name. The result will be sorted alphabetically from lowest to highest by department name, last names and first name.

SELECT p.apellido1 primer_apellido, p.apellido2 segundo_apellido,
p.nombre, d.nombre departamento
FROM persona p
LEFT JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN departamento d ON prof.id_departamento = d.id
WHERE p.tipo = "profesor"
ORDER BY d.nombre, p.apellido1, p.apellido2;

-- 2. Returns a list of teachers who are not associated with a department.

SELECT p.apellido1 primer_apellido, p.apellido2 segundo_apellido, p.nombre
FROM persona p
LEFT JOIN profesor prof ON p.id = prof.id_profesor
WHERE p.tipo = "profesor" AND prof.id_departamento IS NULL;

-- 3. Returns a list of departments that do not have associated professors.

SELECT d.nombre departamento
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
WHERE prof.id_profesor IS NULL;

-- 4. Returns a list of teachers who do not teach any subjects.

SELECT CONCAT(p.apellido1, " ", p.apellido2) apellidos, p.nombre
FROM persona p
LEFT JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor
WHERE p.tipo = "profesor" AND a.id IS NULL;

-- 5. Returns a list of subjects that do not have an assigned teacher.

SELECT a.nombre asignatura
FROM asignatura a
LEFT JOIN profesor prof ON a.id_profesor = prof.id_profesor
WHERE prof.id_profesor IS NULL;

-- 6. Returns a list of all departments that have not taught subjects in any school year.

SELECT DISTINCT d.nombre departamento
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL;


-- * Summary queries:

-- 1. Returns the total number of students there are.

SELECT COUNT(*) total_alumnos
FROM persona
WHERE tipo = "alumno";

-- 2. Calculate how many students were born in 1999.

SELECT COUNT(*) alumnos_99
FROM persona
WHERE tipo = "alumno"
AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calculate how many professors there are in each department. The result should only show two columns, one with the name of the department and another with the number of professors in that department. The result should only include departments that have associate professors and should be sorted from highest to lowest by the number of professors.

SELECT d.nombre departamento, COUNT(*) profesores
FROM profesor prof
JOIN departamento d ON prof.id_departamento = d.id
GROUP BY d.nombre
ORDER BY profesores DESC;

-- 4. Returns a list of all departments and the number of professors in each of them. Note that there may be departments that do not have associated professors. These departments must also appear in the list.

SELECT d.nombre departamento, COUNT(prof.id_profesor) profesores
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
GROUP BY d.nombre
ORDER BY profesores DESC;

-- 5. Returns a list with the names of all the degrees in the database and the number of subjects each has. Note that there may be degrees that do not have associated subjects. These degrees must also appear in the list. The result must be ordered from highest to lowest by the number of subjects.

SELECT g.nombre grado, COUNT(a.id) asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY asignaturas DESC;

-- 6. Returns a list with the name of all the degrees existing in the database and the number of subjects each one has, of the degrees that have more than 40 associated subjects.

SELECT g.nombre grado, COUNT(a.id) asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING COUNT(a.id) > 40
ORDER BY asignaturas DESC;

-- 7. Returns a list showing the name of the degrees and the sum of the total number of credits for each type of subject. The result should have three columns: name of the degree, type of subject, and the sum of the credits for all subjects of that type.

SELECT g.nombre grado, a.tipo tipo_asignatura, SUM(a.creditos) total_creditos
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY SUM(a.creditos) DESC;

-- 8. Returns a list showing how many students have enrolled in a subject in each of the school years. The result should show two columns, one column with the year the school year started and another with the number of students enrolled.

SELECT c.anyo_inicio inicio, COUNT(DISTINCT(al.id_alumno)) alumnos
FROM curso_escolar c
LEFT JOIN alumno_se_matricula_asignatura al ON c.id = al.id_curso_escolar
GROUP BY inicio
ORDER BY inicio;

-- 9. Returns a list with the number of subjects taught by each teacher. The list must take into account those teachers who do not teach any subjects. The result will show five columns: id, name, first name, second name and number of subjects. The result will be sorted from highest to lowest by the number of subjects.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) num_asignaturas
FROM persona p
LEFT JOIN asignatura a ON p.id = a.id_profesor
WHERE p.tipo = "profesor"
GROUP BY p.id
ORDER BY num_asignaturas DESC;

-- 10. Returns all the data of the youngest student.

SELECT *
FROM persona
WHERE tipo = "alumno"
ORDER BY fecha_nacimiento DESC
LIMIT 1;

-- 11. Returns a list of professors who have an associated department and who do not teach any subjects.

SELECT p.nombre, CONCAT(p.apellido1, " ", p.apellido2) apellidos, d.nombre departamento
FROM persona p
JOIN profesor prof ON p.id = prof.id_profesor
JOIN departamento d ON prof.id_departamento = d.id
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor
WHERE a.nombre IS NULL;