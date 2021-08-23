-- ѕрактическое задание по теме Ујдминистрирование MySQLФ (эта тема изучаетс€ по вашему желанию)

-- 1. —оздайте двух пользователей которые имеют доступ к базе данных shop. 
-- ѕервому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop Ч любые операции в пределах базы данных shop.

use shop;

DROP USER IF EXISTS shop;
CREATE USER shop IDENTIFIED WITH password BY '123';
GRANT ALL ON shop.* TO shop;

DROP USER IF EXISTS shop_read;
CREATE USER shop_read IDENTIFIED WITH password BY '123';
GRANT SELECT ON shop.* TO shop_read;

-- 2. (по желанию) ѕусть имеетс€ таблица accounts содержаща€ три столбца id, name, password, 
-- содержащие первичный ключ, им€ пользовател€ и его пароль. 
-- —оздайте представление username таблицы accounts, предоставл€ющий доступ к столбца id и name. 
-- —оздайте пользовател€ user_read, который бы не имел доступа к таблице accounts, однако, 
-- мог бы извлекать записи из представлени€ username.

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50),
	password VARCHAR(50)
);

DROP VIEW IF EXISTS username;
CREATE VIEW username(id, name) AS
SELECT id, name FROM accounts;

DROP USER IF EXISTS shop_read;
CREATE USER shop_read;
GRANT SELECT ON shop.accounts TO shop_read;