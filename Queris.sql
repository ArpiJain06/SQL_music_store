/* Q1. Who is the senior most employee based on job title? */

SELECT * FROM employee ORDER BY levels desc limit 1

/* Q2. Which Countries have the most invoices? */

SELECT COUNT(*) AS c, billing_country 
FROM invoice 
GROUP BY billing_country
ORDER BY c desc

/* Q3. What are the top 3 values of total invoice? */

SELECT total FROM invoice Order By total desc limit 3

/* Q4. Which city has highest number of invoice totals? */

SELECT SUM(total) as invoice_total, billing_city FROM invoice 
GROUP BY billing_city ORDER BY invoice_total desc limit 1

/* Q5. Which customer has spent the most money? */

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total
FROM customer JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total desc limit 1

/* Q6. Give a list of all rock music listerners, return their email, first name , 
last name and genre. Order it on the basis of email. */

SELECT DISTINCT customer.email, customer.first_name , customer.last_name
FROM customer 
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
) ORDER BY email

/* Q7. Give the names of top 10 rock artists with most number of tracks. */

SELECT COUNT(artist.artist_id) AS number_of_songs, artist.artist_id, artist.name
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs desc limit 10

/* Q8. Return all track names that have length longer than average song length.
Return the name and milliseconds for each track. Order by decreasing song length. */

SELECT name, milliseconds FROM track
WHERE milliseconds >(
	SELECT AVG(milliseconds) AS avg
	FROM track
) ORDER BY milliseconds desc
