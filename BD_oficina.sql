-- Banco de dados para o cenário de OFICINA
create database oficina;
use oficina;

-- tabale cliente
create table clients(
	id_client int auto_increment primary key,
    name_client varchar(255),
    address varchar(255),
    phone char(11)
);

-- tabela carros
create table car(
	id_car int auto_increment primary key,
    model varchar(25) not null,
    car_year char(4),
    license char(8)unique not null ,
    constraint fk_client_car foreign key(id_car) references clients(id_client)
);

-- tabela de serviços
create table service(
	id_service int auto_increment primary key,
    description_service varchar(255),
    value_service float,
    status_service enum("Finalizado","Aguardando peça","Em manutenção","Orçamento") default "Orçamento",
    start_service date
);

-- tabale de agendamento de serviço
create table scheduling(
	id_schedule int auto_increment primary key,
    id_client int,
    id_car int,
    id_service int,
    type_service varchar(100) not null,
    constraint fk_clients_schedule foreign key (id_client) references clients (id_client),
    constraint fk_car_schedule foreign key (id_car) references car(id_car),
    constraint fk_service_schedule foreign key (id_service) references service(id_service)
);

-- tabela de peças 
create table car_parts(
	id_parts int auto_increment primary key unique,
    name_parts varchar(48) not null,
    value_parts float,
    quantity_storage int default 0
);

-- tabela de mão de obra sobre o serviço prestado
create table orders (
	id_orders int auto_increment primary key unique,
    id_schedule int,
    id_parts int,
    total_quantity_parts int,
    constraint fk_schedule_orders foreign key (id_schedule) references scheduling (id_schedule),
	constraint fk_parts_orders foreign key (id_parts) references car_parts(id_parts)
);

-- tabela de pagamentos
	create table payments(
		id_payments int primary key,
        value_final float,
        type_payment enum('Cartão crédito 3x sem juros', 'Cartão crédito 2x sem juros', 'Cartão crédito 1x sem juros','Cartão débito', 'Dinheiro/pix') default 'Dinheiro/pix',
        constraint fk_schedule_payment foreign key (id_payments) references scheduling (id_schedule)
);
alter table payments add date_payments date;