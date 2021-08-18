use vk;

-- 2. ����� ����� ��������� ������������. 
-- �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� ��������������.

SELECT count(*) messag, friend FROM 
	(SELECT body, to_user_id AS friend FROM messages WHERE from_user_id = 1
	 UNION
	 SELECT body,from_user_id AS friend FROM messages WHERE to_user_id = 1) as history

GROUP BY friend
ORDER BY messag DESC
LIMIT 1;

-- 3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.

SELECT SUM(likes) 
FROM (SELECT COUNT(*) AS likes
	  FROM likes,profiles
	  WHERE to_subject_id = profiles.user_id
	  GROUP BY to_subject_id
	  ORDER BY profiles.birthday DESC
	  LIMIT 10) as countlikes;

-- 4. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

SELECT COUNT(*) AS likes, sex FROM likes, profiles
WHERE likes.from_user_id = profiles.user_id
GROUP BY sex;

-- 5. ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.

SELECT id, SUM(acts) as acts FROM 
	(SELECT id, 0 as acts FROM users
	UNION
	SELECT user_id as id, count(*) as acts FROM media
	GROUP BY user_id
	UNION
	SELECT from_user_id, COUNT(*) FROM likes
	GROUP BY from_user_id
	UNION
	SELECT from_user_id, COUNT(*) FROM messages
	GROUP BY from_user_id) AS activities
GROUP BY id
ORDER BY acts
LIMIT 10;