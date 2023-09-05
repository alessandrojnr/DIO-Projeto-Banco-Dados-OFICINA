-- inserindo dados e queries no BD OFICINA
use oficina;

insert into clients (id_client, name_client, address, phone)
			values(1, 'João Batista de Jesus', 'Rua Maria Isabel 503, Centro - Sao Paulo', 99164738272),
				  (2, 'Leticia Arantela', 'Av das Hortensias 444, Centro - Gramado', 58724904439),
                  (3, 'Juvena de Souza', 'Rua Alameda das Flores 179, Centro - Rio de Janeiro', 54987612354),
                  (4, 'Lucas da Rocha', 'Clarimundo Marques Pires 888, Santa Monica - Ribeirão Preto', 78943256738),
                  (5, 'Joaquim Teixeira', 'Rua Benedito Ramos 510, Centro - Araraquara', 89632144578);
                  
insert into car(id_car, model, car_year, license)
			values(1, 'Corsa', 2004,'JWA2972'),
				  (2, 'Jeep', 2023,'MPZ6513'),
				  (3, 'Onix', 2021,'KOV8135'),
                  (4, 'Civic', 2020,'HPI9958'),
                  (5, 'Fiat Toro', 2019, 'NEO9135');
                

insert into service(id_service, description_service, value_service, status_service, start_service)
			values(1, 'Troca de oleo', 299.99,'Finalizado', '2023-06-10'),
				  (2, 'Manutencao de embreagem', 800.59,'Finalizado', '2023-04-15'),
                  (3, 'Balanceamento', 550,'Aguardando peça', '2023-03-08'),
                  (4, 'Revisao dos componentes do freio', 1450.90,'Em manutenção', '2023-08-28'),
                  (5, 'Manutencao no sistema de arrefecimento', 1800.99, null, '2023-01-08');
                  
insert into scheduling(id_schedule, id_client, id_car, id_service, type_service)
			values(1, 1, 1,1, 'Troca de oleo'),
				  (2, 2, 2,2, 'Balanceamento'),
                  (3, 3, 3,3, 'Revisao'),
                  (4, 4, 4,4, 'Troca de Filtros'),
                  (5, 5, 5,5, 'Revisao');
                
insert into car_parts(id_parts, name_parts, value_parts, quantity_storage)
			values(1, 'Chave para filtro de oleo com 3 garras', 150, 4),
				  (2, 'chave de roda', 250, 2),
                  (3, 'Radiador', 980, 1),
                  (4, 'Filtro', 40, 8),
                  (5, 'Disco de Freios', 80, 50);

insert into orders(id_orders, id_schedule, id_parts, total_quantity_parts)
			values(1, 1, 1, 2),
				  (2, 2, 2, 1),
                  (3, 3, 3, 1),
                  (4, 4, 4, 2),
                  (5, 5, 5, 2);

                 
insert into payments(id_payments, value_final, type_payment,date_payments)
			values(1, 150, 'Cartão crédito 3x sem juros', '2023-09-05'),
				  (2, 250, 'Cartão crédito 1x sem juros','2023-09-01'),
                  (3, 980, 'Cartão crédito 2x sem juros', '2023-08-27'),
                  (4, 40, 'Dinheiro/pix', '2023-08-30'),
                  (5, 80, 'Cartão débito','2023-08-31');

                  
-- queries

-- Recuperando informações do veículo de um cliente e pagamento por cartão de credito em 3x:
SELECT id_client, name_client, model, license, type_payment
FROM clients
INNER JOIN car ON id_client = id_car
INNER JOIN payments ON type_payment = id_client
HAVING type_payment ='Cartão crédito 3x sem juros' ;



-- Listando todos os agendamentos de cliente com detalhes do veículo e serviço:
SELECT name_client, model, description_service
FROM clients C
INNER JOIN car ON C.id_client = car.id_car
INNER JOIN service OS ON C.id_client = OS.id_service;


-- Mostre a quantidade de servicos realizados para cada cliente:
SELECT name_client, COUNT(id_schedule) AS 'Quantidade de Servicos'
FROM clients C
LEFT JOIN scheduling S ON C.id_client = S.id_client
GROUP BY name_client;


-- Verificar o estoque de peças para serviço de Troca de Oleo:
SELECT  quantity_storage
FROM car_parts CP
INNER JOIN service OS ON  CP.id_parts = OS.id_service
WHERE OS.description_service = 'Troca de oleo';

-- Obter detalhes de pagamento para um agendamento QUE SEJA MAIOR QUE 200 REAIS:
SELECT date_payments, type_service
FROM payments P
INNER JOIN scheduling S ON P.id_payments = S.id_schedule
GROUP BY date_payments, type_service
HAVING sum(P.value_final) > 200;


-- Mostre no estoque os valores das peças entre 200 reais e 1500 reais:
SELECT *
FROM car_parts
WHERE value_parts between 200 AND 1500;