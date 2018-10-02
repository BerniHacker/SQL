Profiling and Analyzing in SQL
by Bernardo Di Chiara
May 17th 2018

This project consists in profiling and analyzing a dataset in SQL.

The used data set is a modified version of the Yelp dataset, cut to 10000 rows
for each table.

The original Yelp dataset is from a US-based organization called Yelp, which 
provides a platform for users to review and rate their interactions with a 
variety of organizations – businesses, restaurants, health clubs, hospitals, 
local governmental offices, charitable organizations, etc...

1. Yelp Dataset Profiling and Understanding

1.1. Let's find the total number of records for each of the tables.
	
Used SQL Code and Results:

/*Counting the number of rows of each table, including possible null values*/

SELECT COUNT (*) AS NumberOfRecords
FROM attribute;

+-----------------+
| NumberOfRecords |
+-----------------+
|           10000 |
+-----------------+

SELECT COUNT (*) AS NumberOfRecords
FROM business;

/*The detailed results for this and the following tables has been omitted 
for brevity. See summary above.*/

SELECT COUNT (*) AS NumberOfRecords
FROM category;

SELECT COUNT (*) AS NumberOfRecords
FROM checkin;

SELECT COUNT (*) AS NumberOfRecords
FROM elite_years;

SELECT COUNT (*) AS NumberOfRecords
FROM friend;

SELECT COUNT (*) AS NumberOfRecords
FROM hours;

SELECT COUNT (*) AS NumberOfRecords
FROM photo

SELECT COUNT (*) AS NumberOfRecords
FROM review;

SELECT COUNT (*) AS NumberOfRecords
FROM tip;

SELECT COUNT (*) AS NumberOfRecords
FROM user;

Summary of the Results:
	
i. Attribute table = 10000
ii. Business table = 10000
iii. Category table = 10000
iv. Checkin table = 10000
v. elite_years table = 10000
vi. friend table = 10000
vii. hours table = 10000
viii. photo table = 10000
ix. review table = 10000
x. tip table = 10000
xi. user table = 10000

Each table has 10000 records.

1.2. Let's find the total number of distinct records for the primary keys 
in each of the tables.

Primary Keys are denoted in the ER-Diagram with a yellow key icon.

Used SQL Code and Results:

/*Checking the primary key and counting the number of distinct records 
for the primary key (or for the foreigner key)*/

PRAGMA table_info(business); /*This command shows information about the 
variables of the table. The primary key is the row corresponding to the value 1
of the column pk. If there is not such a row it means the table has no 
primary key*/

+-----+--------------+--------------+---------+------------+----+
| cid | name         | type         | notnull | dflt_value | pk |
+-----+--------------+--------------+---------+------------+----+
|   0 | id           | varchar(22)  |       1 |       None |  1 |
|   1 | name         | varchar(255) |       0 |       NULL |  0 |
|   2 | neighborhood | varchar(255) |       0 |       NULL |  0 |
|   3 | address      | varchar(255) |       0 |       NULL |  0 |
|   4 | city         | varchar(255) |       0 |       NULL |  0 |
|   5 | state        | varchar(255) |       0 |       NULL |  0 |
|   6 | postal_code  | varchar(255) |       0 |       NULL |  0 |
|   7 | latitude     | float        |       0 |       NULL |  0 |
|   8 | longitude    | float        |       0 |       NULL |  0 |
|   9 | stars        | float        |       0 |       NULL |  0 |
|  10 | review_count | integer      |       0 |       NULL |  0 |
|  11 | is_open      | integer      |       0 |       NULL |  0 |
+-----+--------------+--------------+---------+------------+----+

SELECT COUNT (DISTINCT id) AS DistincyOccurrences
FROM business;

+---------------------+
| DistincyOccurrences |
+---------------------+
|               10000 |
+---------------------+

PRAGMA table_info(hours);

+-----+-------------+--------------+---------+------------+----+
| cid | name        | type         | notnull | dflt_value | pk |
+-----+-------------+--------------+---------+------------+----+
|   0 | hours       | varchar(255) |       0 | NULL       |  0 |
|   1 | business_id | varchar(22)  |       1 | None       |  0 |
+-----+-------------+--------------+---------+------------+----+

/*This table has no primary key*/

SELECT COUNT (DISTINCT business_id) AS DistincyOccurrences
FROM hours;

+---------------------+
| DistincyOccurrences |
+---------------------+
|                1562 |
+---------------------+

PRAGMA table_info(category); /*This table has not primary key*/

/*The detailed results for this and the next tables has been omitted for 
brevity. See summary above.*/

SELECT COUNT (DISTINCT business_id) AS DistincyOccurrences
FROM category;

PRAGMA table_info(attribute); /*This table has not primary key*/

SELECT COUNT (DISTINCT business_id) AS DistincyOccurrences
FROM attribute;

PRAGMA table_info(review);

SELECT COUNT (DISTINCT id) AS DistincyOccurrences
FROM review;

PRAGMA table_info(checkin); /*This table has not primary key*/

SELECT COUNT (DISTINCT business_id) AS DistincyOccurrences
FROM checkin;

PRAGMA table_info(photo);

SELECT COUNT (DISTINCT id) AS DistincyOccurrences
FROM photo;

PRAGMA table_info(tip); /*This table has not primary key*/

SELECT COUNT (DISTINCT business_id) AS DistincyOccurrences
FROM tip;

PRAGMA table_info(user);

SELECT COUNT (DISTINCT id) AS DistincyOccurrences
FROM user;

PRAGMA table_info(friend); /*This table has not primary key*/

SELECT COUNT (DISTINCT user_id) AS DistincyOccurrences
FROM friend;

PRAGMA table_info(elite_years); /*This table has not primary key*/

SELECT COUNT (DISTINCT user_id) AS DistincyOccurrences
FROM elite_years;

Summary of the Results:

i. Business = 10000 (id)
ii. Hours = 1562 (business_id)
iii. Category = 2643 (business_id)
iv. Attribute = 1115 (business_id)
v. Review = 10000 (id) 8090 (business_id) 9581 (user_id)
vi. Checkin = 493 (business_id)
vii. Photo = 10000 (id) 6493 (business_id)
viii. Tip = 3979 (business_id) 537 (user_id)
ix. User = 10000
x. Friend = 11 (user_id)
xi. Elite_years = 2780 (user_id)

1.3. Let's investigate if there are any columns with null values in the Users 
table.
		
Used SQL Code:

/*Looking for null values in each column (primary key cannot have null value)*/
SELECT *
FROM user
WHERE name IS NULL OR
  review_count IS NULL OR
  yelping_since IS NULL OR
  useful IS NULL OR
  funny IS NULL OR
  cool IS NULL OR
  fans IS NULL OR
  average_stars IS NULL OR
  compliment_hot IS NULL OR
  compliment_more IS NULL OR
  compliment_profile IS NULL OR
  compliment_cute IS NULL OR
  compliment_list IS NULL OR
  compliment_note IS NULL OR
  compliment_plain IS NULL OR
  compliment_cool IS NULL OR
  compliment_funny IS NULL OR
  compliment_writer IS NULL OR
  compliment_photos IS NULL;

Summary of the Result: no  
  
1.4. For each table and column listed below, the smallest (minimum), 
largest (maximum), and average (mean) value are valuated.

	i. Table: Review; Column: Stars
	
		min: 1		max: 5		avg: 3.7082
		
	ii. Table: Business; Column: Stars
	
		min: 1		max: 5		avg: 3.6549
	
	iii. Table: Tip; Column: Likes
	
		min: 0		max: 2		avg: 0.0144
	
	iv. Table: Checkin; Column: Count
	
		min: 1		max: 53		avg: 1.9414
	
	v. Table: User; Column: Review_count
	
		min: 0		max: 2000		avg: 24.2995

Used SQL Code and Results:

SELECT MIN (stars) AS MinStars, MAX(stars) AS MaxStars, AVG(stars) AS MeanStars
FROM review;

+----------+----------+-----------+
| MinStars | MaxStars | MeanStars |
+----------+----------+-----------+
|        1 |        5 |    3.7082 |
+----------+----------+-----------+

SELECT MIN (stars) AS MinStars, MAX(stars) AS MaxStars, AVG(stars) AS MeanStars
FROM business;

SELECT MIN (likes) AS MinLikes, MAX(likes) AS MaxLikes, AVG(likes) AS MeanLikes
FROM tip;

SELECT MIN (count) AS MinCount, MAX(count) AS MaxCount, AVG(count) AS MeanCount
FROM checkin;

SELECT MIN (review_count) AS MinCount, MAX(review_count) AS MaxCount, 
  AVG(review_count) AS MeanCount
FROM user;

1.5. Let's list the cities with the most reviews in descending order.

Used SQL Code and Result:

SELECT city,
  SUM(review_count) AS total_reviews /*This gives the sum of all the reviews 
  for all the businesses (and therefore also for all the cities)*/
FROM business
GROUP BY city /*The reviews are grouped by city*/
ORDER BY total_reviews DESC
	
Result:

+-----------------+---------------+
| city            | total_reviews |
+-----------------+---------------+
| Las Vegas       |         82854 |
| Phoenix         |         34503 |
| Toronto         |         24113 |
| Scottsdale      |         20614 |
| Charlotte       |         12523 |
| Henderson       |         10871 |
| Tempe           |         10504 |
| Pittsburgh      |          9798 |
| Montréal        |          9448 |
| Chandler        |          8112 |
| Mesa            |          6875 |
| Gilbert         |          6380 |
| Cleveland       |          5593 |
| Madison         |          5265 |
| Glendale        |          4406 |
| Mississauga     |          3814 |
| Edinburgh       |          2792 |
| Peoria          |          2624 |
| North Las Vegas |          2438 |
| Markham         |          2352 |
| Champaign       |          2029 |
| Stuttgart       |          1849 |
| Surprise        |          1520 |
| Lakewood        |          1465 |
| Goodyear        |          1155 |
+-----------------+---------------+
(Output limit exceeded, 25 of 362 total rows shown)
	
1.6. Let's find the distribution of star ratings to the business in the 
following cities.

i. Avon

Used SQL Code and Result:

SELECT COUNT(id) AS count, stars, city
FROM business
WHERE city = 'Avon'
GROUP BY stars;

+-------+-------+------+
| count | stars | city |
+-------+-------+------+
|     1 |   1.5 | Avon |
|     2 |   2.5 | Avon |
|     3 |   3.5 | Avon |
|     2 |   4.0 | Avon |
|     1 |   4.5 | Avon |
|     1 |   5.0 | Avon |
+-------+-------+------+

ii. Beachwood

Used SQL Code and Result:

SELECT COUNT(id) AS count, stars, city
FROM business
WHERE city = 'Beachwood'
GROUP BY stars;
	
+-------+-------+-----------+
| count | stars | city      |
+-------+-------+-----------+
|     1 |   2.0 | Beachwood |
|     1 |   2.5 | Beachwood |
|     2 |   3.0 | Beachwood |
|     2 |   3.5 | Beachwood |
|     1 |   4.0 | Beachwood |
|     2 |   4.5 | Beachwood |
|     5 |   5.0 | Beachwood |
+-------+-------+-----------+

1.7. Let's find the top 3 users based on their total number of reviews.
		
Used SQL Code and Result:

SELECT name, review_count
FROM user
ORDER BY review_count DESC
LIMIT 3;
		
Result:
		
+--------+--------------+
| name   | review_count |
+--------+--------------+
| Gerald |         2000 |
| Sara   |         1629 |
| Yuri   |         1339 |
+--------+--------------+

8. Let's investigate if posting more reviews correlate with more fans.

As seen below, more you go through the list of users with number of reviews
in descending order, less frequent is to find users with a high number of fans. 
However, there are outliers with high number of reviews and small number of 
fans like L.

183 out of 10000 records show a review count which is higher than 10 times the 
average. Focusing on the top 25, it is possible to notice that 24 of such users
have an amount of fans which is more than 10 times the average. That is 96%.

Therefore, there seems to be a strong correlation between a high review count 
and a high number of fans. Further statistical analysis would be needed 
to confirm this result.

Used SQL Code and Results:

/*Checking the average number of reviews and the average number of fans*/
SELECT AVG(review_count), AVG(fans)
FROM user;

+-------------------+-----------+
| AVG(review_count) | AVG(fans) |
+-------------------+-----------+
|           24.2995 |    1.4896 |
+-------------------+-----------+
	
SELECT name, review_count, fans
FROM user
ORDER BY review_count DESC;

+-----------+--------------+------+
| name      | review_count | fans |
+-----------+--------------+------+
| Gerald    |         2000 |  253 |
| Sara      |         1629 |   50 |
| Yuri      |         1339 |   76 |
| .Hon      |         1246 |  101 |
| William   |         1215 |  126 |
| Harald    |         1153 |  311 |
| eric      |         1116 |   16 |
| Roanna    |         1039 |  104 |
| Mimi      |          968 |  497 |
| Christine |          930 |  173 |
| Ed        |          904 |   38 |
| Nicole    |          864 |   43 |
| Fran      |          862 |  124 |
| Mark      |          861 |  115 |
| Christina |          842 |   85 |
| Dominic   |          836 |   37 |
| Lissa     |          834 |  120 |
| Lisa      |          813 |  159 |
| Alison    |          775 |   61 |
| Sui       |          754 |   78 |
| Tim       |          702 |   35 |
| L         |          696 |   10 |
| Angela    |          694 |  101 |
| Crissy    |          676 |   25 |
| Lyn       |          675 |   45 |
+-----------+--------------+------+
(Output limit exceeded, 25 of 10000 total rows shown)

SELECT name, review_count, fans
FROM user
ORDER BY review_count DESC
LIMIT 25 OFFSET 160;

+---------------------+--------------+------+
| name                | review_count | fans |
+---------------------+--------------+------+
| Karli               |          271 |   13 |
| J                   |          264 |    8 |
| Jean                |          259 |   15 |
| Michelle            |          258 |   69 |
| AJA                 |          257 |   16 |
| Mara                |          256 |   11 |
| bernice             |          255 |  105 |
| Natasha             |          255 |   11 |
| Timmy               |          253 |    3 |
| Melissa             |          253 |   11 |
| Kandy               |          253 |   18 |
| Tasha               |          250 |    8 |
| Seiji               |          250 |   11 |
| Debbie              |          249 |   68 |
| Vanessa             |          249 |   24 |
| Gina                |          248 |    2 |
| Aviv                |          248 |    5 |
| Horst               |          247 |   12 |
| Monera              |          245 |   15 |
| Grace               |          244 |   58 |
| Dimple- LudMilla B. |          243 |   32 |
| Marsh-Silog         |          243 |   13 |
| Fred                |          243 |   53 |
| Kyle                |          240 |   18 |
| Tamaki              |          239 |   23 |
+---------------------+--------------+------+
	
1.9. Checking if they are more reviews with the word "love" or with the word 
"hate".

Summary of the Result: There are more reviews with the word "love".
	
Used SQL Code and Results:

SELECT
  (SELECT COUNT(id)
  FROM review
  WHERE text LIKE '%love%') AS love_count,
  (SELECT COUNT(id)
  FROM review
  WHERE text LIKE '%hate%') AS hate_count
FROM review
GROUP BY love_count;

+------------+------------+
| love_count | hate_count |
+------------+------------+
|       1780 |        232 |
+------------+------------+
	
1.10. Finding the top 10 users with the highest number of fans.

Used SQL Code and Result:
	
SELECT name, fans
FROM user
ORDER BY fans DESC
LIMIT 10;

+-----------+------+
| name      | fans |
+-----------+------+
| Amy       |  503 |
| Mimi      |  497 |
| Harald    |  311 |
| Gerald    |  253 |
| Christine |  173 |
| Lisa      |  159 |
| Cat       |  133 |
| William   |  126 |
| Fran      |  124 |
| Lissa     |  120 |
+-----------+------+	
	
11. Let's check if there is a strong relationship (or correlation) between 
having a high number of fans and being listed as "useful" or "funny".
Also, out of the top 10 users with the highest number of fans, what percent 
are also listed as “useful” or “funny”?

Key:
0% - 25% - Low relationship
26% - 75% - Medium relationship
76% - 100% - Strong relationship
	
Used SQL Code and Results:

/*Finding the average values for the number of fans, the number of useful 
labels and the number of funny labels*/
SELECT AVG(fans), AVG(useful), AVG(funny)
FROM user;

+-----------+-------------+------------+
| AVG(fans) | AVG(useful) | AVG(funny) |
+-----------+-------------+------------+
|    1.4896 |     38.0563 |    24.7927 |
+-----------+-------------+------------+

SELECT name, fans, useful, funny
FROM user
ORDER BY fans DESC;

+-----------+------+--------+--------+
| name      | fans | useful |  funny |
+-----------+------+--------+--------+
| Amy       |  503 |   3226 |   2554 |
| Mimi      |  497 |    257 |    138 |
| Harald    |  311 | 122921 | 122419 |
| Gerald    |  253 |  17524 |   2324 |
| Christine |  173 |   4834 |   6646 |
| Lisa      |  159 |     48 |     13 |
| Cat       |  133 |   1062 |    672 |
| William   |  126 |   9363 |   9361 |
| Fran      |  124 |   9851 |   7606 |
| Lissa     |  120 |    455 |    150 |
| Mark      |  115 |   4008 |    570 |
| Tiffany   |  111 |   1366 |    984 |
| bernice   |  105 |    120 |    112 |
| Roanna    |  104 |   2995 |   1188 |
| Angela    |  101 |    158 |    164 |
| .Hon      |  101 |   7850 |   5851 |
| Ben       |   96 |   1180 |   1155 |
| Linda     |   89 |   3177 |   2736 |
| Christina |   85 |    158 |     34 |
| Jessica   |   84 |   2161 |   2091 |
| Greg      |   81 |    820 |    753 |
| Nieves    |   80 |   1091 |    774 |
| Sui       |   78 |      9 |     18 |
| Yuri      |   76 |   1166 |    220 |
| Nicole    |   73 |     13 |     10 |
+-----------+------+--------+--------+
(Output limit exceeded, 25 of 10000 total rows shown)	

SELECT name, fans, useful, funny
FROM user
ORDER BY fans DESC
LIMIT 25 OFFSET 200;

+-----------+------+--------+-------+
| name      | fans | useful | funny |
+-----------+------+--------+-------+
| Derek     |   15 |    366 |   242 |
| Chad      |   15 |     72 |    44 |
| Tisha     |   15 |    109 |    15 |
| Kristen   |   15 |     45 |    11 |
| Sara      |   15 |     45 |    32 |
| Stephen   |   15 |    125 |    38 |
| Uyen      |   14 |     47 |    75 |
| Rachel    |   14 |    120 |    45 |
| Autumn    |   14 |    215 |   125 |
| Jessica   |   14 |    375 |    14 |
| Matt      |   14 |     42 |    15 |
| Dave      |   14 |     16 |     6 |
| Ron       |   14 |    844 |   305 |
| Kaitlin   |   14 |      8 |     2 |
| Tiffany   |   14 |     88 |     3 |
| Joe       |   14 |     59 |    25 |
| Alias     |   14 |    976 |   342 |
| Brian     |   14 |    110 |    33 |
| Neil Ryan |   13 |    129 |     9 |
| Linna     |   13 |     53 |    23 |
| Priya     |   13 |     10 |     2 |
| Taylor    |   13 |    432 |   246 |
| Desiree   |   13 |     83 |    16 |
| Theresa   |   13 |    115 |    22 |
| Justin    |   13 |     46 |    11 |
+-----------+------+--------+-------+

Interpretation of the Results:

Out of 10000 records, only 206 have more than 10 times the average amount 
of fans and only 6 have more than 100 times the average amount of fans.

Higher is the number of fans, more likely is to get a high number of useful 
or funny labels. However, there are outliers, users with many fans and 
relatively low amount of useful or funny labels (like Lisa).

If we analyze the top 25 users in terms of number of fans, we notice that 
18 of them have a score of "useful" or "funny" which is more than 10 times 
the average. That is 72%, so we conclude that there is a medium correlation
between the number of fans and being rated as useful or funny. A more accurate
statistical analysis would be needed to confirm this result.

2. Analysis

2.1. One city and one category is pick up and the businesses are grouped in 
that city or category by their overall star rating. The businesses with 2-3 
stars are compared to the businesses with 4-5 stars.

The city is Toronto and the category is Restaurants.
	
i. Do the two groups have a different distribution of hours?

Answer:

There are 6 businesses all together (Restaurants in Toronto) in the two groups,
three for each group. Two out of three restaurants which received high score 
are evening restaurants.

Used SQL Code and Results:

SELECT b.name,
  CASE
    WHEN b.stars <= 3.5 THEN 'low score'
	  WHEN b.stars > 3.5 THEN 'high score'
  END AS score,	
       b.review_count,
	   b.stars,
       h.hours
FROM (business AS b INNER JOIN hours AS h ON b.id = h.business_id)
  INNER JOIN category AS c ON b.id = c.business_id
WHERE b.city = 'Toronto' AND c.category = 'Restaurants' AND score = 'low score'
  /*Selecting the Restaurants in Toronto with low score*/;

+------------------+-----------+--------------+-------+-----------------------+
| name             | score     | review_count | stars | hours                 |
+------------------+-----------+--------------+-------+-----------------------+
| Big Smoke Burger | low score |           47 |   3.0 | Monday|10:30-21:00    |
| Big Smoke Burger | low score |           47 |   3.0 | Tuesday|10:30-21:00   |
| Big Smoke Burger | low score |           47 |   3.0 | Friday|10:30-21:00    |
| Big Smoke Burger | low score |           47 |   3.0 | Wednesday|10:30-21:00 |
| Big Smoke Burger | low score |           47 |   3.0 | Thursday|10:30-21:00  |
| Big Smoke Burger | low score |           47 |   3.0 | Sunday|11:00-19:00    |
| Big Smoke Burger | low score |           47 |   3.0 | Saturday|10:30-21:00  |
| 99 Cent Sushi    | low score |            5 |   2.0 | Monday|11:00-23:00    |
| 99 Cent Sushi    | low score |            5 |   2.0 | Tuesday|11:00-23:00   |
| 99 Cent Sushi    | low score |            5 |   2.0 | Friday|11:00-23:00    |
| 99 Cent Sushi    | low score |            5 |   2.0 | Wednesday|11:00-23:00 |
| 99 Cent Sushi    | low score |            5 |   2.0 | Thursday|11:00-23:00  |
| 99 Cent Sushi    | low score |            5 |   2.0 | Sunday|11:00-23:00    |
| 99 Cent Sushi    | low score |            5 |   2.0 | Saturday|11:00-23:00  |
| Pizzaiolo        | low score |           34 |   3.0 | Monday|9:00-23:00     |
| Pizzaiolo        | low score |           34 |   3.0 | Tuesday|9:00-23:00    |
| Pizzaiolo        | low score |           34 |   3.0 | Friday|9:00-4:00      |
| Pizzaiolo        | low score |           34 |   3.0 | Wednesday|9:00-23:00  |
| Pizzaiolo        | low score |           34 |   3.0 | Thursday|9:00-23:00   |
| Pizzaiolo        | low score |           34 |   3.0 | Sunday|10:00-23:00    |
| Pizzaiolo        | low score |           34 |   3.0 | Saturday|10:00-4:00   |
+------------------+-----------+--------------+-------+-----------------------+

SELECT b.name,
  CASE
    WHEN b.stars <= 3.5 THEN 'low score'
	  WHEN b.stars > 3.5 THEN 'high score'
  END AS score,	
       b.review_count,
	   b.stars,
       h.hours
FROM (business AS b INNER JOIN hours AS h ON b.id = h.business_id)
  INNER JOIN category AS c ON b.id = c.business_id
WHERE b.city = 'Toronto' AND c.category = 'Restaurants' AND score = 'high score'
  /*Selecting the Restaurants in Toronto with high score*/;

+-------------+------------+--------------+-------+-----------------------+
| name        | score      | review_count | stars | hours                 |
+-------------+------------+--------------+-------+-----------------------+
| Cabin Fever | high score |           26 |   4.5 | Monday|16:00-2:00     |
| Cabin Fever | high score |           26 |   4.5 | Tuesday|18:00-2:00    |
| Cabin Fever | high score |           26 |   4.5 | Friday|18:00-2:00     |
| Cabin Fever | high score |           26 |   4.5 | Wednesday|18:00-2:00  |
| Cabin Fever | high score |           26 |   4.5 | Thursday|18:00-2:00   |
| Cabin Fever | high score |           26 |   4.5 | Sunday|16:00-2:00     |
| Cabin Fever | high score |           26 |   4.5 | Saturday|16:00-2:00   |
| Sushi Osaka | high score |            8 |   4.5 | Monday|11:00-23:00    |
| Sushi Osaka | high score |            8 |   4.5 | Tuesday|11:00-23:00   |
| Sushi Osaka | high score |            8 |   4.5 | Friday|11:00-23:00    |
| Sushi Osaka | high score |            8 |   4.5 | Wednesday|11:00-23:00 |
| Sushi Osaka | high score |            8 |   4.5 | Thursday|11:00-23:00  |
| Sushi Osaka | high score |            8 |   4.5 | Sunday|14:00-23:00    |
| Sushi Osaka | high score |            8 |   4.5 | Saturday|11:00-23:00  |
| Edulis      | high score |           89 |   4.0 | Sunday|12:00-16:00    |
| Edulis      | high score |           89 |   4.0 | Friday|18:00-23:00    |
| Edulis      | high score |           89 |   4.0 | Wednesday|18:00-23:00 |
| Edulis      | high score |           89 |   4.0 | Thursday|18:00-23:00  |
| Edulis      | high score |           89 |   4.0 | Saturday|18:00-23:00  |
+-------------+------------+--------------+-------+-----------------------+
  
ii. Do the two groups have a different number of reviews?

Answer:

Sushi Osaka and Edulis have both high score but the first has only 8 reviews 
and the second one has 89 reviews. So, based on this very limited amount of 
data, it seems the amount of reviews is not related with the score.

Used SQL code: see i. above.        
         
iii. IS it possible to infer anything from the location data provided between 
these two groups?

Answer:

Based on the longitude data, restaurants which got high score seem to be mostly
in the western part of Toronto.

Used SQL code and Results:

SELECT b.name,
  CASE
    WHEN b.stars <= 3.5 THEN 'low score'
	  WHEN b.stars > 3.5 THEN 'high score'
  END AS score,	
	   b.stars,
       b.neighborhood,
       b.latitude,
       b.longitude
FROM business AS b INNER JOIN category AS c ON b.id = c.business_id
WHERE b.city = 'Toronto' AND c.category = 'Restaurants'
  /*Selecting the Restaurants in Toronto*/
ORDER BY score;

+--------------------+------------+-------+------------------------+----------+-----------+
| name               | score      | stars | neighborhood           | latitude | longitude |
+--------------------+------------+-------+------------------------+----------+-----------+
| Mama Mia           | high score |   4.0 |                        |  43.6809 |  -79.4302 |
| Cabin Fever        | high score |   4.5 | High Park              |  43.6553 |  -79.4567 |
| Sushi Osaka        | high score |   4.5 | Etobicoke              |  43.6452 |  -79.5324 |
| Naniwa-Taro        | high score |   4.0 | Willowdale             |  43.7766 |  -79.4142 |
| Edulis             | high score |   4.0 | Niagara                |  43.6419 |  -79.4066 |
| Royal Dumpling     | low score  |   1.5 | Willowdale             |  43.7752 |   -79.414 |
| Big Smoke Burger   | low score  |   3.0 | Downtown Core          |  43.6546 |  -79.3805 |
| 99 Cent Sushi      | low score  |   2.0 | Downtown Core          |  43.6614 |   -79.379 |
| Pizzaiolo          | low score  |   3.0 | Entertainment District |  43.6479 |  -79.3901 |
| The Kosher Gourmet | low score  |   3.5 |                        |  43.7175 |  -79.4291 |
+--------------------+------------+-------+------------------------+----------+-----------+		
		
2.2. Business are grouped based on the ones that are open and the ones that are
closed.

What differences can be found between the ones that are still open and the ones
that are closed?

Answer:
		
i. Difference 1: Business that are still open have a slight higher average 
stars score     
         
ii. Difference 2: Business that are still open have a much higher amount of 
reviews             
         
Used SQL Code and Result:

SELECT AVG(stars), MAX(stars), MIN(stars), SUM(review_count), is_open
FROM business
GROUP BY is_open;

+---------------+------------+------------+-------------------+---------+
|    AVG(stars) | MAX(stars) | MIN(stars) | SUM(review_count) | is_open |
+---------------+------------+------------+-------------------+---------+
| 3.52039473684 |        5.0 |        1.0 |             35261 |       0 |
| 3.67900943396 |        5.0 |        1.0 |            269300 |       1 |
+---------------+------------+------------+-------------------+---------+
	
2.3. One more analysis and preparation of the data.
	
i. Indicating the type of chosen analysis:
  
Let's prepare data in order to make a prediction on the overall star rating 
of businesses in the state of Arizona.  
         
ii. Writing a short description on the type of data that is needed for 
the analysis:

Common sense tells that potential predictors could be found among location 
related data, may be also the name. Also, the opening hours might have an 
impact as well as the category.

Therefore, the output dataset shall contain the following variables:

id, name, neighborhood, city, postal code, category, hours, stars.

id is used to identify the record. The last variable is the predicted variable,
which is also needed to train the model.             

The category and the opening hours data is concatenated in order to have a 
row for each separate business.

By using some more suitable language (like for example R), it will be possible
to manipulate data further for example by extracting only opening days 
information from the variable contact_hours or by adding new binary variables
telling if the business is open in a certain day.

iii. SQL code used to create the final dataset:

SELECT
  b.id,
  b.name,
  b.neighborhood,
  b.city,
  b.postal_code,
  GROUP_CONCAT (c.category) AS concat_category,
  GROUP_CONCAT (h.hours) AS concat_hours,
  b.stars
FROM (business AS b LEFT JOIN category AS c ON b.id = c.business_id)
  LEFT JOIN hours AS h ON b.id = h.business_id
WHERE b.state = 'AZ'
GROUP BY b.id;
                  
iv. Output of the finished dataset:
 
+------------------------+---------------------------------------------+--------------+------------+-------------+-----------------+--------------+-------+
| id                     | name                                        | neighborhood | city       | postal_code | concat_category | concat_hours | stars |
+------------------------+---------------------------------------------+--------------+------------+-------------+-----------------+--------------+-------+
| --8LPVSo5i0Oo61X01sV9A | Valley Bone and Joint Specialists           |              | Gilbert    | 85234       |            None |         None |   4.5 |
| --9QQLMTbFzLJ_oT-ON3Xw | Great Clips                                 |              | Tempe      | 85283       |            None |         None |   3.0 |
| --FLdgM0GNpXVMn74ppCGw | Welch Physical Therapy                      |              | Gilbert    | 85296       |            None |         None |   3.5 |
| --KQsXc-clkO7oHRqGzSzg | Sam's Club                                  |              | Scottsdale | 85260       |            None |         None |   3.0 |
| --Rsj71PBe31h5YljVseKA | Circle K                                    |              | Phoenix    | 85085       |            None |         None |   4.0 |
| --ab39IjZR_xUf81WyTyHg | Famous Footwear                             |              | Tempe      | 85281       |            None |         None |   4.0 |
| --g-a85VwrdZJNf0R95GcQ | Kabab House                                 |              | Phoenix    | 85032       |            None |         None |   4.5 |
| --orEUqwTzz5QKbmyYbAWw | Advantage Rent-A-Car                        |              | Phoenix    | 85034       |            None |         None |   2.5 |
| --phjqoPSPa8sLmUVNby9w | Maricopa County Department of Public Health |              | Phoenix    | 85006       |            None |         None |   4.0 |
| --qvQS4MigHPykD2GV0-zw | Pearson Moving                              |              | Chandler   | 85225       |            None |         None |   4.0 |
| --ttCFj_csKJhxnaMRNuiw | Impressions Dental                          |              | Chandler   | 85249       |            None |         None |   3.0 |
| -000aQFeK6tqVLndf7xORg | Cool Cat Auto Repair                        |              | Phoenix    | 85017       |            None |         None |   5.0 |
| -01XupAWZEXbdNbxNg5mEg | 18 Degrees Neighborhood Grill               |              | Scottsdale | 85260       |            None |         None |   3.0 |
| -050d_XIor1NpCuWkbIVaQ | Matt's Big Breakfast                        |              | Phoenix    | 85004       |            None |         None |   4.0 |
| -092wE7j5HZOogMLAh40zA | Wong's Jr                                   |              | Peoria     | 85345       |            None |         None |   3.5 |
| -0GU6ghA7z4-xotUZfXl1w | Sport Clips Haircuts - Chandler             |              | Chandler   | 85226       |            None |         None |   5.0 |
| -0KqNhmK40DTzwUPM_Ik9g | Wesley Bolin Memorial Plaza                 |              | Phoenix    | 85007       |            None |         None |   4.5 |
| -0Sgh0QlUKVsWosCWJzGqQ | Domino's Pizza                              |              | Tempe      | 85281       |            None |         None |   2.0 |
| -0WegMt6Cy966qlDKhu6jA | Game Seven Grill                            |              | Phoenix    | 85034       |            None |         None |   2.0 |
| -0aIra_B6iALlfqAriBSYA | Tea2go                                      |              | Phoenix    | 85054       |            None |         None |   5.0 |
| -0jz6c3C6i7RG7Ag22K-Pg | Auto Action                                 |              | Glendale   | 85301       |            None |         None |   2.5 |
| -0t6o9LXMVQ3aV8CHhRTnA | AZ International Marketplace                |              | Mesa       | 85202       |            None |         None |   3.5 |
| -0tgMGl7D9B10YjSN2ujLA | Dubliner                                    |              | Phoenix    | 85032       |            None |         None |   3.5 |
| -11PbySWhJQtK6USx4IP2A | URBAN JUNGLE FUN PARK Mesa                  |              | Mesa       | 85215       |            None |         None |   4.0 |
| -17Uz92KtnWOpeEGVvg17g | BCT Flooring and Showers                    |              | Tempe      | 85282       |            None |         None |   1.0 |
+------------------------+---------------------------------------------+--------------+------------+-------------+-----------------+--------------+-------+
(Output limit exceeded, 25 of 3042 total rows shown)
