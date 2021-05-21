create database teste;

USE teste;

create table Departamento(
cod_departamento int auto_increment primary key,
nome varchar(25) not null unique
);

create table Professor(
cod_professor int auto_increment primary key,
nome varchar(60) not null,
departamento_cod int not null,
constraint fk_departamento foreign key(departamento_cod) references Departamento(cod_departamento)
);

create table Curso(
cod_curso int auto_increment primary key,
nome varchar(15) not null,
departamento_cod int not null,
constraint fk_departamento2 foreign key(departamento_cod) references departamento(cod_departamento)
);

create table disciplina(
cod_disciplina int auto_increment primary key,
nome varchar(20) not null,
numero_aluno int unsigned not null unique,
carga_horaria time not null default 0,
departamento_cod int not null,
constraint fk_departamento3 foreign key(departamento_cod) references departamento(cod_departamento) 
);

create table prof_disciplina(
disciplina_cod int not null,
professor_cod int not null,
primary key(disciplina_cod, professor_cod),
constraint fk_disciplina_prof foreign key(disciplina_cod) references disciplina(cod_disciplina),
constraint fk_professor foreign key(professor_cod) references professor(cod_professor)
);

create table curso_disciplina(
disciplina_cod int not null,
curso_cod int not null,
primary key(disciplina_cod, curso_cod),
constraint fk_disciplina_curso foreign key(disciplina_cod) references disciplina(cod_disciplina),
constraint fk_curso foreign key(curso_cod) references curso(cod_curso)
);

create table Turma(
cod_turma int auto_increment primary key,
periodo enum('NOITE' ,'TARDE', 'MANHÃ')not null,
data_inicio date not null,
data_termino date not null,
numero_aluno int unsigned not null unique,
curso_cod int not null,
constraint fk_curso_turma foreign key(curso_cod) references curso(cod_curso)
);

create table Aluno(
ra int auto_increment primary key,
nomecompleto varchar(60) not null,
genero enum('M' ,'F') not null,
status boolean not null,
cpf varchar(11) not null unique,
whatsapp varchar(15) not null unique,
email varchar(50),
curso_cod int not null,
turma_cod int not null,
constraint fk_curso_aluno foreign key(curso_cod) references curso(cod_curso),
constraint fk_turma_aluno foreign key(turma_cod) references turma(cod_turma)
);
alter table aluno add status enum('Matriculado','Matriculada','Trancado','Desmatriculado','Desmatriculada') after genero;

create table endereço(
cod_endereço int auto_increment primary key,
cep varchar(8) not null unique,
rua varchar(60) not null,
numero int unsigned not null,
complemento varchar (20),
aluno_ra int not null,
constraint fk_endereço_aluno foreign key(aluno_ra) references aluno(ra)
);

create table telefone(
cod_telefone int auto_increment primary key,
numero varchar(15),
aluno_ra int not null,
constraint fk_tel_aluno foreign key(aluno_ra) references aluno(ra)
);

create table aluno_disc(
aluno_ra int not null,
disciplina_cod int not null,
primary key(aluno_ra,disciplina_cod),
constraint fk_aluno foreign key(aluno_ra) references aluno(ra),
constraint fk_disciplina_aluno foreign key(disciplina_cod) references disciplina(cod_disciplina)
);

create table Historico(
cod_historico int auto_increment primary key,
data_inicio date not null,
data_fim date not null,
aluno_ra int not null,
constraint fk_historico_aluno foreign key(aluno_ra) references aluno(ra)
);

create table Historico_disc(
historico_cod int not null,
disciplina_cod int not null,
primary key(historico_cod,disciplina_cod),
constraint fk_historico foreign key(historico_cod) references historico(cod_historico),
constraint fk_disciplina_historico foreign key(disciplina_cod) references disciplina(cod_disciplina),
frequecia varchar(4) not null,
nota decimal(2,1) not null
);

insert into departamento values(
default,'Secretaria da educação');

insert into professor values(
default,'Yuri Fabriccio','1');

insert into professor values(
default,'Marcus Antonio','1'),
(default,'Fabriccio Silva','1');

insert into curso values(
default,'Informatica','1'),
(default,'Engenharia','1'),
(default,'Direito','1'),
(default,'Medicina','1');

insert into disciplina values(
default,'software','123','80:00','1'),
(default,'probabilidade','345','80:00','1'),
(default,'Leis Federais','567','80:00','1'),
(default,'TiposdeCirurgias','789','80:00','1');
 select * from disciplina;

insert into prof_disciplina values(
'1','3'),
('4','1'),
('2','2');

insert into curso_disciplina values(
'1','1'),
('2','2'),
('3','3'),
('4','4');

insert into turma values(
default,'NOITE','2000-03-29','2004-10-29','123','1'),
(default,'TARDE','2000-03-29','2004-10-29','345','2'),
(default,'MANHÃ','2000-03-29','2004-10-29','567','3'),
(default,'NOITE','2000-03-29','2004-10-29','789','4');

insert into aluno values(
default,'Yuri Fernandes','M','Matriculado','12345678912','122233445','Yuri@gmail.com','1','5'),
(default,'Carlos Souza','M','Matriculado','23456789123','345234567','Carlos@gmail.com','3','3'),
(default,'Marcela Silva','F','Matriculada','34567891234','958738987','Marcela@gmail.com','2','8'),
(default,'Flavia Oliveira','F','Matriculada','45678912345','984739873','Flavia@gmail.com','4','4');

update aluno set nomecompleto= 'Fernando Salvador' where ra=17;

insert into endereço values(
default , '45356356','PadariaLoka','267','','17'),
(default,'75897236','SantoRoxo','335','',18),
(default,'35618793','PalmeirasPorcada','4567','',19),
(default,'13456837','cachorroVelho','6765','',20);

insert into telefone values(
default,'234564879','17'),
(default,'453678376','18'),
(default,'647289765','19'),
(default,'563797537','20');

insert into historico values(
default,'2000-03-29','2004-10-29','17'),
(default,'1999-03-29','2003-10-29','18'),
(default,'1998-03-29','2002-10-29','19'),
(default,'1997-03-29','2001-10-29','20');

insert into aluno_disc values(
'17','1'),
('18','3'),
('19','2'),
('20','4');

insert into historico_disc values(
'1','1','100','8.2'),
('2','3','50','9.9'),
('3','2','90','5.5'),
('4','4','30','0.0');


