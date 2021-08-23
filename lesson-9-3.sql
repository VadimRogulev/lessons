-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"

-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, 
-- � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� 
-- "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

use shop_online;

DROP PROCEDURE IF EXISTS hello;

delimiter //

CREATE PROCEDURE hello()

BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN
		SELECT '������ ����';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN
		SELECT '������ ����';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN
		SELECT '������ �����';
	ELSE
		SELECT '������ ����';
	END IF;
END //

delimiter ;

CALL hello();

-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
-- ��������� ����������� ����� ����� ��� ���� �� ���. ��������, 
-- ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, 
-- ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

DROP TRIGGER IF EXISTS nullTrigger;

delimiter //

CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //

delimiter;

-- 3. (�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������. 
-- ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. 
-- ����� ������� FIBONACCI(10) ������ ���������� ����� 55.

DROP FUNCTION IF EXISTS fibonacci;

CREATE FUNCTION fibonacci(n INT)
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE p1 INT DEFAULT 1;
    DECLARE p2 INT DEFAULT 1;
    DECLARE i INT DEFAULT 2;
    DECLARE res INT DEFAULT 0;
   
    IF (n <= 1) THEN RETURN n;
    	ELSEIF (n = 2) THEN RETURN 1;
    END IF;  
    WHILE i < n DO
        SET i = i + 1;
		SET res = p2 + p1;
        SET p2 = p1;
        SET p1 = res;
    END WHILE;
 RETURN res;
 END//
 
delimiter;