Select REVERSE(UPPER('Why does my cat look at me with such hatred?'));

Select REPLACE(title, ' ', '->') AS title from books;

Select author_lname AS forwards, REVERSE(author_lname) AS backwards from books;

Select CONCAT(UPPER(author_fname), ' ', UPPER(author_lname)) AS 'full name in caps' from books;

Select CONCAT(title, ' was released in ', released_year) AS 'blurb' from books;

Select title, char_length(title) AS 'character count' from books;

Select CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title', CONCAT(author_lname, ',', author_fname) 
AS 'author', CONCAT(stock_quantity, ' in stock') AS 'quantity' from books;

-- Exercises 2
Select title from books where title like '%stories%';

Select title, pages from books ORDER BY pages DESC LIMIT 1;

Select CONCAT(title, ' - ', released_year) AS 'summary' from books ORDER BY released_year DESC limit 3;

Select title, author_lname from books where author_lname like '% %';

Select title, released_year, stock_quantity from books ORDER BY stock_quantity ASC limit 3;

Select title, author_lname from books ORDER BY author_lname, title;

Select CONCAT('MY FAVORITE AUTHOR IS ', UPPER(author_fname), ' ', UPPER(author_lname)) AS 'yell' from books 
ORDER BY author_lname;

-- Exercises 3
Select COUNT(title) from books;

Select COUNT(title), released_year from books GROUP BY released_year;

Select COUNT(title) AS 'books', SUM(stock_quantity) AS 'quantity' from books;

Select author_fname, author_lname, AVG(released_year) from books GROUP BY author_lname, author_fname;

Select CONCAT(author_fname, ' ', author_lname), title, pages from books 
GROUP BY author_lname, author_fname 
ORDER BY pages DESC limit 1;

Select released_year AS 'year', COUNT(title) AS '# books', AVG(pages) from books GROUP BY released_year; 

-- Exercises 4
CREATE TABLE inventory(
    item_name VARCHAR(100),
    price DECIMAL(6,2),
    quantity INT
);

-- Difference between DATETIME and TIMESTAMP is that TIMESTAMP takes up less memory than DATETIME 
-- but does not have as wide of a range of DATETIME, other than that they are the exact same.

Select TIME(NOW());
 
Select DATE(NOW());

Select DAY(NOW());

Select DAYNAME(NOW());

Select DATE_FORMAT(NOW(), '%c/%d/%Y');

Select CONCAT(DATE_FORMAT(NOW(), '%M %D'), ' at ', DATE_FORMAT(NOW(), '%h:%i'));

CREATE TABLE tweets(content VARCHAR(140), username VARCHAR(20), created_time TIMESTAMP DEFAULT NOW());

-- Exercises 5
Select title, released_year FROM books WHERE released_year > 1980;

Select title, CONCAT(author_lname, ' ', author_fname) AS 'author' FROM books WHERE author_lname IN ('Eggers', 'Chabon');

Select title, released_year, CONCAT(author_lname, ' ', author_fname) AS 'author' From books 
where author_lname = 'Lahiri' && released_year > 2000;

Select title, pages from books where pages between 100 AND 200;

Select title, author_lname from books where author_lname like 'C%' || author_lname like 'S%';

Select title, author_lname, 
    CASE WHEN title like '%stories%' THEN 'Short Stories'
    WHEN title like '%Just Kids%' || title like '%A heartbreaking Work%' THEN 'Memoir'                                                     
    ELSE 'Novel'
    END AS 'Type'
FROM books;

Select title, author_lname, CASE WHEN COUNT(title) = 1 THEN '1 book'
    ELSE CONCAT(COUNT(title), ' books')
END AS 'COUNT'
from books 
GROUP BY author_lname; 


-- Exercises 6
Create table students(id INT AUTO_INCREMENT Primary Key, first_name VARCHAR(50));
create table papers(title VARCHAR(100), grade INT, student_id INT, FOREIGN KEY(student_id) REFERENCES students(id));

Select first_name, title, grade FROM students Inner join papers ON students.id = papers.student_id ORDER BY grade DESC;

Select first_name, title, grade FROM students left join papers ON students.id = papers.student_id;

Select first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0) FROM students left join papers ON students.id = papers.student_id;

Select first_name, IFNULL(AVG(grade), 0) AS 'average' FROM students left join papers ON students.id = papers.student_id 
GROUP BY first_name ORDER BY average DESC;

Select first_name, IFNULL(AVG(grade), 0) AS 'average', 
CASE WHEN AVG(grade) >= 75 THEN 'PASSING' 
ELSE 'FAILING' 
END AS 'passing_status' 
FROM students left 
join papers ON students.id = papers.student_id GROUP BY first_name ORDER BY grade DESC;


-- Instagram DB exercises

Select username, created_at from users ORDER BY created_at LIMIT 5;

Select DAYNAME(created_at) AS 'Day', COUNT(*) as 'total' FROM users GROUP BY day ORDER BY total DESC LIMIT 1;

Select username, user_id FROM users LEFT JOIN photos ON users.id = photos.user_id WHERE user_id IS NULL;

Select username, photos.id, photos.image_url, COUNT(likes.user_id) as 'COUNT' FROM photos 
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY COUNT DESC LIMIT 1;

Select (Select COUNT(*) FROM photos) / (Select COUNT(*) FROM users) as 'AVG # photos per user';


Select COUNT(*) as 'COUNT', tag_id, tags.tag_name 
from photo_tags
INNER JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tag_id 
ORDER BY COUNT DESC
LIMIT 5;

Select username, COUNT(*) AS num_likes
FROM users
INNER JOIN likes ON users.id = likes.user_id
GROUP BY username
HAVING num_likes = (SELECT COUNT(*) FROM photos);

