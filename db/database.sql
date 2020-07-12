CREATE DATABASE schedule;

DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS classrooms;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS faculties;

CREATE TABLE groups(
	id serial PRIMARY KEY,
	course INT NOT NULL,
--	faculty VARCHAR(2) NOT NULL
);

CREATE TABLE faculties(
	id serial PRIMARY KEY,
	name VARCHAR(2) NOT NULL,
	subject_list TEXT[]
);

CREATE TABLE classrooms(
	id serial PRIMARY KEY,
	room_nr INT NOT NULL, 
	start_time TIME[6], 
	para INT[6]
);

CREATE TABLE subjects(
	id serial PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE classes(
	subject_id 	INT NOT NULL,
	classroom_id INT NOT NULL,
	day DATE NOT NULL,
	start_time TIME NOT NULL,
	class_type  VARCHAR(10) NOT NULL
);

ALTER TABLE classes
ADD CONSTRAINT pkey_classes   	PRIMARY KEY	(subject_id, classroom_id,),	
ADD CONSTRAINT fkey_subject_id FOREIGN KEY (subject_id) REFERENCES subjects(id),
ADD CONSTRAINT fkey_classroom_id  FOREIGN KEY (classroom_id) REFERENCES classrooms(id);

-- PARA = 90 min; BREAK = 10 min
ALTER TABLE classrooms ADD CONSTRAINT para_check CHECK (para BETWEEN 1 AND 7);
ALTER TABLE classrooms ADD CONSTRAINT time_check CHECK (start_time >= '8:30');


-- INSERT DATA FROM CSV FILE
COPY subjects	(name, faculty)								FROM '\BMSTU_Practice_3thCourse\db\subjects.csv' 	DELIMITER ',' CSV;
COPY groups		(course, faculty) 							FROM '\BMSTU_Practice_3thCourse\db\groups.csv' 		DELIMITER ',' CSV;
COPY faculties	(name, subject_list)						FROM '\BMSTU_Practice_3thCourse\db\faculties.csv' 	DELIMITER ',' CSV;
COPY classrooms	(room_nr, start_time, para) 				FROM '\BMSTU_Practice_3thCourse\db\classrooms.csv'	DELIMITER ',' CSV;
COPY classes	(classroom_id, day, start_time, class_type) FROM '\BMSTU_Practice_3thCourse\db\classes.csv' 	DELIMITER ',' CSV;

-- INSERT DATA MANUALLY
insert into classrooms (room_nr, start_time, para)
values
	(
		508,
		'{"8:30", "10:10", "8:30", "11:50", "8:30", "10:10"}',
		'{4, 2, 5, 2, 3, 5}'
	);

insert into faculties (name, subject_list)
values
	('IU', '{"Programming in C", "Logic and Theory Algorithms", "Data Structure", "DBMS", "Computer Design"}'),
	('MT', '{"Probability Theory", "Advanced Mathematics", "Discrete mathematics", "Decision Theory", "Mathematical statistics"}'),
	('FN', '{"Physics", "Mechatronics System", "Electric drive of machines", "Analysis of machine structures", "Basics of machine tools development"}');