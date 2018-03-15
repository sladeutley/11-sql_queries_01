-- Query all of the entries in the Genre table
SELECT * FROM Genre;

-- Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT INTO Artist (ArtistId, ArtistName, YearEstablished)
VALUES (31, "The Strokes", 1998)

-- Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT INTO Album (AlbumId, Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId)
VALUES (NULL, "Is This It", 2001, 3628, "RCA, Rough Trade", 
(SELECT ArtistId FROM Artist WHERE ArtistName = "The Strokes"),
(SELECT GenreId FROM Genre WHERE LABEL = "Rock"));

-- Using the INSERT statement, add some songs that are on that album to the Song table.
INSERT INTO Song (SongId, Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
VALUES (NULL, "Take It Or Leave It", 316, 2001,
(SELECT GenreId FROM Genre WHERE Label = "Rock"),
(SELECT ArtistId FROM Artist WHERE ArtistName = "The Strokes"),
(SELECT AlbumId FROM Album WHERE Title = "Is This It"));

INSERT INTO Song 
SELECT null, "Last Nite", 318, 2001, g.GenreId, ar.ArtistId, al.AlbumId
FROM Artist ar, Genre g, Album al
WHERE ar.ArtistName = "The Strokes"
AND g.Label = "Rock"
AND al.Title = "Is This It"

-- Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added. Here is some more info on joins that might help.
-- Reminder: Direction of join matters. Try the following statements and see the difference in results.
-- SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.AlbumId;
-- SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.AlbumId;
SELECT s.title AS "songTitle", al.title AS "albumTitle", ar.ArtistName "artistName"
FROM song s
LEFT JOIN album al
ON s.albumid = al.albumid
LEFT JOIN artist as ar
ON s.artistid = ar.artistid
WHERE s.albumid = (SELECT albumid FROM album WHERE title="Is This It");

-- Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT count(song.songid) "song count", album.title Album
FROM Song
JOIN Album
ON song.albumid = album.albumid
GROUP BY album.title

-- Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT count(song.songid) "song count", artist.artistname artist
FROM Song
JOIN Artist
ON song.artistid = artist.artistid
GROUP BY artist.artistname

-- Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

-- USED 'AS'
SELECT count(song.songid) as "song count", genre.label as genre
FROM Song
JOIN genre
ON song.genreid = genre.genreid
GROUP BY genre.label

-- Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
SELECT title, MAX(albumlength) "album length"
from album

-- Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
SELECT title, MAX(songlength) "song length"
from song
-- or
SELECT MAX(Song.SongLength) AS "song length", Song.Title AS "song title"
FROM Song;

-- Modify the previous query to also display the title of the album.
SELECT MAX(songlength) "song length", song.title as "song title", album.title as "album title"
from song
join Album
on song.albumid = album.albumid
