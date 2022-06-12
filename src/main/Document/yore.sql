create database yore;
use yore;

drop table postreply;
drop table post;
drop table rcpreply;
drop table rcptype;
drop table cook;
drop table category;
drop table rcp;
drop table user;

create table user
(
	u_no int primary key auto_increment comment '회원번호',
	u_id varchar(20) comment '아이디',
	u_pw varchar(100) comment '비밀번호',
	u_name varchar(100) comment '이름',
	u_gender varchar(2) comment '성별',
	u_birthdate date comment '생년월일',
	u_joindate datetime default now() comment '가입일자',
	u_resign varchar(2) default 'N' comment '탈퇴여부',
	u_level varchar(2) default 'U' comment '권한'
);

insert into user (u_id,u_pw,u_name,u_gender,u_birthdate,u_resign,u_level)
values ('jeon',md5('jeon'),'관리자','M',19951105,'N','A');

create table post
(
	p_no int primary key auto_increment comment '게시물번호',
	u_no int comment '작성자회원번호',
	foreign key (u_no) references user(u_no),
	p_title varchar(200) comment '제목',
	p_type varchar(20) comment '구분',
	p_contents text comment '내용',
	p_writer varchar(20) comment '작성자',
	p_date datetime default now() comment '작성일',
	p_views int default 0 comment '조회수',
	p_subject varchar(10) comment '말머리'
);

create table postreply
(
	r_no int primary key auto_increment comment '댓글번호', 
	p_no int comment '게시물번호',
	foreign key (p_no) references post(p_no),
	u_no int comment '작성자회원번호',
	foreign key (u_no) references user(u_no),
	r_contents text comment '댓글내용',
	r_date datetime default now() comment '작성일',
	r_u_no int comment '댓글작성자회원번호',
	foreign key (r_u_no) references user(u_no),
	r_name varchar(20) comment '작성자'
);

create table rcp
(
	rcp_no int primary key auto_increment comment '레시피번호', 
	u_no int comment '작성자회원번호',
	foreign key (u_no) references user(u_no),
	rcp_title varchar(250) comment '제목',
	rcp_type varchar(20) comment '구분',
	rcp_writer varchar(100) comment '작성자',
	rcp_views int default 0 comment '조회수',
	rcp_date datetime default now() comment '작성일'
);

create table rcpreply
(
	rcp_r_no int primary key auto_increment comment '댓글번호', 
	rcp_no int comment '레시피번호',
	foreign key (rcp_no) references rcp(rcp_no),
	u_no int comment '작성자회원번호',
	foreign key (u_no) references user(u_no),
	rcp_r_contents text comment '댓글내용',
	rcp_r_date datetime default now() comment '작성일',
	rcp_r_u_no int comment '댓글작성자회원번호',
	foreign key (rcp_r_u_no) references user(u_no),
	rcp_r_name varchar(20) comment '작성자'
);

create table category
(
	rcp_no int comment '레시피번호',
	foreign key (rcp_no) references rcp(rcp_no),
	u_no int comment '작성자회원번호',
	foreign key (u_no) references user(u_no),
    cat_no int primary key auto_increment comment '요리종류번호',
    cat_mcode varchar(2) comment '대분류코드',
    cat_mname varchar(50) comment '대분류명',
    cat_scode varchar(2) comment '중분류코드',
    cat_sname varchar(50) comment '중분류명',
    rcp_type varchar(20) comment '구분'
);

create table cook
(
	cook_no int primary key auto_increment comment '과정번호', 
	rcp_no int comment '레시피번호',
	foreign key (rcp_no) references rcp(rcp_no),
	u_no int comment '작성자회원번호',
	foreign key (u_no) references user(u_no),
	cook_explain text comment '조리과정설명',
	cook_attach varchar(256) comment '첨부파일명',
	cook_sumbnail varchar(256) comment '썸네일사진',
	rcp_type varchar(20) comment '구분'
);

alter table user convert to character set utf8mb4 collate utf8mb4_general_ci;
alter table post convert to character set utf8mb4 collate utf8mb4_general_ci;
alter table postreply convert to character set utf8mb4 collate utf8mb4_general_ci;
alter table rcp convert to character set utf8mb4 collate utf8mb4_general_ci;
alter table rcpreply convert to character set utf8mb4 collate utf8mb4_general_ci;
alter table category convert to character set utf8mb4 collate utf8mb4_general_ci;
alter table cook convert to character set utf8mb4 collate utf8mb4_general_ci;

insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('A','종류별','','');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('A','종류별','A','밑반찬');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('A','종류별','B','국/탕');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('A','종류별','C','디저트');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('A','종류별','D','면/만두');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('A','종류별','E','양념/소스');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('B','상황별','','');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('B','상황별','A','손님접대');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('B','상황별','B','술안주');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('B','상황별','C','다이어트');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('B','상황별','D','도시락');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('B','상황별','E','간식');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('C','재료별','','');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('C','재료별','A','소고기');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('C','재료별','B','돼지고기');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('C','재료별','C','닭고기');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('C','재료별','D','해물류');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('C','재료별','E','곡물류');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','','');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','A','볶음');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','B','끓이기');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','C','부침');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','D','조림');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','E','무침');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','F','튀김');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('D','방법별','G','찜');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('E','테마별','','');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('E','테마별','A','여성/뷰티');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('E','테마별','B','엄마/아기');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('E','테마별','C','건강/질병');
insert into category (cat_mcode,cat_mname,cat_scode,cat_sname) values ('E','테마별','D','제철요리');


