/* INFO: Get book details based on book id */
SELECT * FROM book_data  
WHERE book_id = '2';

/* INFO: return critically acclaimed books with high ratings and number of ratings */
SELECT * FROM 
	(SELECT * FROM book_data
	GROUP BY book_title 
	ORDER BY book_rating_count
    DESC limit 10000) AS A  
ORDER BY A.book_rating 
DESC limit 1000;

/* INFO: Very Basic Search Function based on Title and Author */
SELECT * FROM book_data
WHERE book_title LIKE '%Harry Potter%'
OR book_authors LIKE '%Harry Potter%'
ORDER BY book_rating_count
DESC limit 50;

/* INFO: Natural Language Full-Text Search based on Title and Authors
https://dev.mysql.com/doc/refman/8.0/en/fulltext-natural-language.html */
SELECT * FROM book_data
WHERE MATCH (book_title, book_authors)
AGAINST ('Harry Potter Boxed Set, Books 1-5 (Harry Potter, #1-5)' IN NATURAL LANGUAGE MODE);

/* INFO: Books similar to current book based on authors */
SELECT DISTINCT A.* FROM book_data AS A
INNER JOIN 
	(SELECT * FROM book_data
    WHERE book_id = '2') AS B 
ON (A.book_authors like CONCAT('%',B.book_authors,'%')
OR B.book_authors like CONCAT('%',A.book_authors,'%'))
AND NOT A.book_id = '2';

/* INFO: Books similar to current book based on genres */
SELECT DISTINCT A.* FROM book_data AS A
INNER JOIN 
	(SELECT * FROM book_data
    WHERE book_id = '2') AS B 
ON (A.genres like CONCAT('%',B.genres,'%')
OR B.genres like CONCAT('%',A.genres,'%'))
AND NOT A.book_id = '2'AND NOT A.genres = ''
LIMIT 10;