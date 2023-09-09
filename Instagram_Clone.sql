/*We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/

SELECT * FROM users
    -> ORDER BY created_at
    -> LIMIT 5;
+----+------------------+---------------------+
| id | username         | created_at          |
+----+------------------+---------------------+
| 80 | Darby_Herzog     | 2016-05-06 00:14:21 |
| 67 | Emilio_Bernier52 | 2016-05-06 13:04:30 |
| 63 | Elenor88         | 2016-05-08 01:30:41 |
| 95 | Nicole71         | 2016-05-09 17:30:22 |
| 38 | Jordyn.Jacobson2 | 2016-05-14 07:56:26 |
+----+------------------+---------------------+
5 rows in set (0.00 sec)

/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/

SELECT date_format(created_at,'%W') AS 'day of the week', COUNT(*) AS 'total registration'
    -> FROM users
    -> GROUP BY 1
    -> ORDER BY 2 DESC;
+-----------------+--------------------+
| day of the week | total registration |
+-----------------+--------------------+
| Thursday        |                 16 |
| Sunday          |                 16 |
| Friday          |                 15 |
| Tuesday         |                 14 |
| Monday          |                 14 |
| Wednesday       |                 13 |
| Saturday        |                 12 |
+-----------------+--------------------+
7 rows in set (0.00 sec)

/*method 2*/

 SELECT
    ->     DAYNAME(created_at) AS day,
    ->     COUNT(*) AS total
    -> FROM users
    -> GROUP BY day
    -> ORDER BY total DESC
    -> LIMIT 2;
+----------+-------+
| day      | total |
+----------+-------+
| Thursday |    16 |
| Sunday   |    16 |
+----------+-------+
2 rows in set (0.00 sec)

/*method 3*/

 SELECT
    ->     DAYNAME(created_at) AS day,
    ->     COUNT(*) AS total
    -> FROM users
    -> GROUP BY day
    -> ORDER BY total DESC
    -> ;
+-----------+-------+
| day       | total |
+-----------+-------+
| Thursday  |    16 |
| Sunday    |    16 |
| Friday    |    15 |
| Tuesday   |    14 |
| Monday    |    14 |
| Wednesday |    13 |
| Saturday  |    12 |
+-----------+-------+
7 rows in set (0.00 sec)

/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/

SELECT username
    -> FROM users
    -> LEFT JOIN photos ON users.id = photos.user_id
    -> WHERE photos.id IS NULL;
+---------------------+
| username            |
+---------------------+
| Aniya_Hackett       |
| Kasandra_Homenick   |
| Jaclyn81            |
| Rocio33             |
| Maxwell.Halvorson   |
| Tierra.Trantow      |
| Pearl7              |
| Ollie_Ledner37      |
| Mckenna17           |
| David.Osinski47     |
| Morgan.Kassulke     |
| Linnea59            |
| Duane60             |
| Julien_Schmidt      |
| Mike.Auer39         |
| Franco_Keebler64    |
| Nia_Haag            |
| Hulda.Macejkovic    |
| Leslie67            |
| Janelle.Nikolaus81  |
| Darby_Herzog        |
| Esther.Zulauf61     |
| Bartholome.Bernhard |
| Jessyca_West        |
| Esmeralda.Mraz57    |
| Bethany20           |
+---------------------+
26 rows in set (0.00 sec)

/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/

 SELECT users.username,photos.id,photos.image_url,COUNT(*) AS Total_Likes
    -> FROM likes
    -> JOIN photos ON photos.id = likes.photo_id
    -> JOIN users ON users.id = likes.user_id
    -> GROUP BY photos.id
    -> ORDER BY Total_Likes DESC
    -> LIMIT 1;
ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'ig_clone.users.username' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

/*method 2*/

 SELECT
    ->     username,
    ->     photos.id,
    ->     photos.image_url,
    ->     COUNT(*) AS total
    -> FROM photos
    -> INNER JOIN likes
    ->     ON likes.photo_id = photos.id
    -> INNER JOIN users
    ->     ON photos.user_id = users.id
    -> GROUP BY photos.id
    -> ORDER BY total DESC
    -> LIMIT 1;
+---------------+-----+---------------------+-------+
| username      | id  | image_url           | total |
+---------------+-----+---------------------+-------+
| Zack_Kemmer93 | 145 | https://jarret.name |    48 |
+---------------+-----+---------------------+-------+
1 row in set (0.01 sec)

/*Our Investors want to know...
How many times does the average user post?*/
/*total number of photos/total number of users*/

SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2) as Average_post;
+--------------+
| Average_post |
+--------------+
|         2.57 |
+--------------+
1 row in set (0.00 sec)

/*user ranking by postings higher to lower*/

SELECT users.username,COUNT(photos.image_url)
    -> FROM users
    -> JOIN photos ON users.id = photos.user_id
    -> GROUP BY users.id
    -> ORDER BY 2 DESC;
+-----------------------+-------------------------+
| username              | COUNT(photos.image_url) |
+-----------------------+-------------------------+
| Eveline95             |                      12 |
| Clint27               |                      11 |
| Cesar93               |                      10 |
| Delfina_VonRueden68   |                       9 |
| Aurelie71             |                       8 |
| Jaime53               |                       8 |
| Donald.Fritsch        |                       6 |
| Yvette.Gottlieb91     |                       5 |
| Zack_Kemmer93         |                       5 |
| Harrison.Beatty50     |                       5 |
| Travon.Waters         |                       5 |
| Alexandro35           |                       5 |
| Mariano_Koch3         |                       5 |
| Colten.Harris76       |                       5 |
| Justina.Gaylord27     |                       5 |
| Kenton_Kirlin         |                       5 |
| Kathryn80             |                       5 |
| Adelle96              |                       5 |
| Janet.Armstrong       |                       5 |
| Florence99            |                       5 |
| Josianne.Friesen      |                       5 |
| Andre_Purdy85         |                       4 |
| Harley_Lind18         |                       4 |
| Gus93                 |                       4 |
| Tabitha_Schamberger11 |                       4 |
| Malinda_Streich       |                       4 |
| Dereck65              |                       4 |
| Seth46                |                       4 |
| Elenor88              |                       4 |
| Irwin.Larson          |                       4 |
| Dario77               |                       4 |
| Annalise.McKenzie16   |                       4 |
| Billy52               |                       4 |
| Rick29                |                       4 |
| Arely_Bogan63         |                       3 |
| Presley_McClure       |                       3 |
| Gerard79              |                       3 |
| Emilio_Bernier52      |                       3 |
| Norbert_Carroll35     |                       3 |
| Maya.Farrell          |                       3 |
| Frederik_Rice         |                       3 |
| Keenan.Schamberger60  |                       3 |
| Alek_Watsica          |                       3 |
| Jordyn.Jacobson2      |                       2 |
| Javonte83             |                       2 |
| Aracely.Johnston98    |                       2 |
| Alysa22               |                       2 |
| Milford_Gleichner42   |                       2 |
| Sam52                 |                       2 |
| Ressie_Stanton46      |                       2 |
| Hailee26              |                       2 |
| Willie_Leuschke       |                       2 |
| Nicole71              |                       2 |
| Kaley9                |                       2 |
| Tomas.Beatty93        |                       2 |
| Lennie_Hartmann40     |                       2 |
| Aiyana_Hoeger         |                       1 |
| Darwin29              |                       1 |
| Katarina.Dibbert      |                       1 |
| Rafael.Hickle2        |                       1 |
| Jayson65              |                       1 |
| Kelsi26               |                       1 |
| Kenneth64             |                       1 |
| Delpha.Kihn           |                       1 |
| Granville_Kutch       |                       1 |
| Odessa2               |                       1 |
| Yazmin_Mills95        |                       1 |
| Damon35               |                       1 |
| Karley_Bosco          |                       1 |
| Erick5                |                       1 |
| Meggie_Doyle          |                       1 |
| Imani_Nicolas17       |                       1 |
| Peter.Stehr0          |                       1 |
| Jaylan.Lakin          |                       1 |
+-----------------------+-------------------------+
74 rows in set (0.00 sec)

65