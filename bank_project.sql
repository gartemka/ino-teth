create table Banks(
    bank_id INT PRIMARY KEY,
    bank_name VARCHAR(225) NOT NULL
); -- для хран инф о банках

create table Branches (
    Branch_id INT PRIMARY KEY,
    bank_id INT,
    city VARCHAR(225) NOT NULL,
    FOREING KEY (bank_id) PREFERENCES Banks(bank_id)
); -- для филиалов в разн городах

create table Customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    social_id_status INT,
    FOREING KEY (social_id_status) PREFERENCES SosialStatus(social_id_status)
); --для клиентов

create table Account(
    Account_id INT PRIMARY KEY,
    customer_id INT,
    balance DEMICAL(10,3) NOT NULL,
    FOREING KEY (customer_id) PREFERENCES Customers(customer_id)
); --для аккков

create table Cards(
    Card_id INT PRIMARY KEY,
    Account_id INT,
    card_balance DEMICAL(10,3) NOT NULL,
    FOREING KEY (Account_id) PREFERENCES Account(Account_id)
); --для карт

INSERT INTO Banks VALUES (1, 'Bank A'), (2, 'Bank B');
INSERT INTO SocialStatus VALUES (1, 'Pensioner'), (2, 'Disabled'), (3, 'Employee');
INSERT INTO Branches VALUES (1, 1, 'City X'), (2, 1, 'City Y'), (3, 2, 'City X');
INSERT INTO Customers VALUES (1, 'John Doe', 1), (2, 'Jane Smith', 2), (3, 'Alice Brown', 3);
INSERT INTO Accounts VALUES (1, 1, 500.00), (2, 2, 1000.00), (3, 3, 700.00);
INSERT INTO Cards VALUES (1, 1, 200.00), (2, 1, 100.00), (3, 2, 300.00), (4, 2, 200.00);
--заполн

select distinct b.bank_name
from Banks B
join Branches br on b.bank_id = br.bank_id
where br.city = 'City X';
-- 3. Запрос для получения списка банков, у которых есть филиалы в городе

SELECT c.customer_name, ca.card_balance, b.bank_name
FROM Cards ca
JOIN Account a ON ca.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
JOIN Banks b ON a.bank_id = b.bank_id;
-- 4. Запрос для получения списка карточек с указанием имени владельца, баланса и названия банка


SELECT a.account_id, a.balance - SUM(c.card_balance) AS balance_difference
FROM Accounts a
JOIN Cards c ON a.account_id = c.account_id
GROUP BY a.account_id
HAVING a.balance <> SUM(c.card_balance);
--5. Запрос для получения списка банковских аккаунтов, у которых баланс не совпадает с суммой баланса по карточкам:

