create table students (
  studentid int primary key,
  studentname varchar(50),
  age int,
  email varchar(100)
);

create table class (
  classid int primary key,
  classname varchar(50)
);

create table classstudent (
  studentid int,
  classid int,
  primary key (studentid, classid),
  foreign key (studentid) references students(studentid),
  foreign key (classid) references class(classid)
);

create table subjects (
  subjectid int primary key,
  subjectname varchar(50)
);

create table marks (
  subject_id int,
  student_id int,
  mark int,
  primary key (subject_id, student_id),
  foreign key (subject_id) references subjects(subjectid),
  foreign key (student_id) references students(studentid)
);
insert into students values 
(1, 'nguyen quang an', 18, 'an@yahoo.com'),
(2, 'nguyen cong vinh', 20, 'vinh@gmail.com'),
(3, 'nguyen van quyen', 19, 'quyen'),
(4, 'pham thanh binh', 25, 'binh@com'),
(5, 'nguyen van tai em', 30, 'taiem@sport.vn');
insert into class values 
(1, 'c0706l'),
(2, 'c0708g');
insert into classstudent values 
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2),
(5, 1);
insert into subjects values 
(1, 'sql'),
(2, 'java'),
(3, 'c'),
(4, 'visual basic');
insert into marks values  
(1, 1, 9), (1, 3, 7), (1, 4, 3);

select * from students;

select * from subjects;

select 
student_id, avg(mark) as averagemark
from marks
group by student_id;

select 
distinct subjectname
from subjects s
join marks m on s.subjectid = m.subject_id
where m.mark > 9;

select student_id, avg(mark) as averagemark
from marks
group by student_id
order by averagemark desc;

update subjects
set subjectname = concat('day la mon hoc ', subjectname);

alter table classstudent drop foreign key classstudent_ibfk_1;
alter table classstudent drop foreign key classstudent_ibfk_2;
alter table marks drop foreign key marks_ibfk_1;
alter table marks drop foreign key marks_ibfk_2;
alter table students add column status bit default 1;
update students set status = 0;