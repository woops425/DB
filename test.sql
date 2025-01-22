CREATE DATABASE testdb;

USE testdb;

CREATE TABLE IF NOT EXISTS tasks (
	task_id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	start_date DATE,
	status TINYINT NOT NULL,
	priority TINYINT NOT NULL,
	description TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = INNODB;

DESCRIBE tasks;

INSERT INTO tasks(title, status, priority)
VALUES('Learn MySQL INSERT Statement',0, 2);

select * from tasks;

delete from tasks where task_id=1;COURSEENROLSTUDENTCOURSE
