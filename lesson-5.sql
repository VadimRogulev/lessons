use vk;

-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.

UPDATE users
	SET created_at = NOW() AND updated_at = NOW();

-- 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������
--    ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10.
--    ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

ALTER TABLE users MODIFY COLUMN created_at varchar(256); # ����������� ������� � VARCHAR
ALTER TABLE users MODIFY COLUMN updated_at varchar(256); # ����������� ������� � VARCHAR

UPDATE users
	SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users
	MODIFY COLUMN created_at DATETIME,
	MODIFY COLUMN updated_at DATETIME;

-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� �����������
-- ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value.
-- ������, ������� ������ ������ ���������� � �����, ����� ���� �������.

CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT '����� �������� ������� �� �������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ �� ������';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15),
    (1, 3, 0),
    (1, 5, 10),
    (1, 7, 5),
    (1, 8, 0);

SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;

-- 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���.
-- ������ ������ � ���� ������ ���������� �������� ('may', 'august')

SELECT name, birthday_at, CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;

SELECT
    name, birthday_at, DATE_FORMAT(birthday_at, '%m') as mounth_of_birth
FROM
    users;

-- 5. (�� �������) ����������� ������������ ����� � ������� �������

-- SELECT * FROM catalogs WHERE id IN (3, 1, 2);

SELECT * FROM catalogs WHERE id IN (3, 1, 2) ORDER BY CASE
    WHEN id = 3 THEN 0
    WHEN id = 1 THEN 1
    WHEN id = 2 THEN 2
END;