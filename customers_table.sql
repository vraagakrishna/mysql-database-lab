create table customers(
customer_id int auto_increment primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) not null,
phone varchar(20),
country_code varchar(5),
date_of_birth date,
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);