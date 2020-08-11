/* INFO: create database book_db;*/
/*use book_db;
drop table book_data;
CREATE TABLE book_data (
    book_id INT NOT NULL AUTO_INCREMENT,
    book_authors VARCHAR(1000) NOT NULL,
    book_desc LONGTEXT,
    book_edition VARCHAR(1000),
    book_format VARCHAR(1000),
    book_isbn BIGINT,
    book_pages VARCHAR(500),
    book_rating DECIMAL(10,2),
    book_rating_count BIGINT,
    book_review_count BIGINT,
    book_title LONGTEXT,
    genres LONGTEXT,
    image_url VARCHAR(1000),
    PRIMARY KEY (book_id)
);
use book_db; */

/* INFO: Add FullText for FullText Search */
ALTER TABLE book_data ADD FULLTEXT(book_title, book_authors);

/* INFO: Load csv to sql db - DOES NOT WORK IN MYSQL WORKBENCH DUE TO BUG
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.Procedural.Importing.AnySource.html */
/*LOAD DATA INFILE 'C:\Users\Jon\Documents\_Actual Documents\NYU Tandon\Big Data\ProjectData\book_data.csv' 
INTO TABLE book_data 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; */

/* INFO: For AWS use MySQLImport instead in the command line
Local MySQLImport command:
mysqlimport --ignore-lines=1 --fields-optionally-enclosed-by="\"" --fields-terminated-by=, --verbose --local -u root -p -c book_authors,book_desc,book_edition,book_format,book_isbn,book_pages,book_rating,book_rating_count,book_review_count,book_title,genres,image_url book_db "C:\Users\Jon\Documents\_Actual Documents\NYU Tandon\Big Data\ProjectData\book_data.csv"

MySQLDump from local db:
mysqldump -h localhost -u root -p --databases book_db > export_book_data.sql

MySQLImport to AWS:
mysql -h book-database-1.cmmzkhfp8kbf.us-east-2.rds.amazonaws.com -u admin -p < export_book_data.sql
*/

/* INFO: Clean out unused books */
SELECT * FROM book_data where book_title like '%Unknown Book%';
DELETE FROM book_data where book_title like '%Unknown Book%';


/* INFO: append "|" to beginning and end of authors and genres */
UPDATE book_data SET book_authors=(CONCAT("|",book_authors,"|"));
UPDATE book_data SET genres=(CONCAT("|",genres,"|"));

