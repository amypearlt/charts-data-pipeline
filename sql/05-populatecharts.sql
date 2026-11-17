INSERT INTO dbo.Artist (name)
SELECT DISTINCT s.artist
FROM staging.charts AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Artist AS a
    WHERE a.name = s.artist
);
GO

INSERT INTO dbo.Label (name)
SELECT DISTINCT s.label
FROM staging.charts AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Label as l
    WHERE l.name = s.label
);
GO

INSERT INTO dbo.Genre (name)
SELECT DISTINCT value
FROM staging.charts AS s
CROSS APPLY STRING_SPLIT(genre, '|')
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Genre AS g
    WHERE g.name = value
);
GO

INSERT INTO dbo.Style (name)
SELECT DISTINCT value
FROM staging.charts AS s
CROSS APPLY STRING_SPLIT(style, '|')
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Style AS st
    WHERE st.name = value
);
GO

INSERT INTO dbo.Song (name, artist_id)
SELECT DISTINCT s.song, a.artist_id
FROM staging.charts AS s
INNER JOIN dbo.Artist AS a ON a.name = s.artist
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Song AS so
    WHERE so.name = s.song
         AND so.artist_id = a.artist_id
);
GO

INSERT INTO dbo.SongGenre (song_id, genre_id)
SELECT DISTINCT so.song_id, g.genre_id
FROM staging.charts AS s
CROSS APPLY STRING_SPLIT(s.genre, '|')
INNER JOIN dbo.Artist AS a ON a.name = s.artist
INNER JOIN dbo.Song AS so ON so.name = s.song
     AND so.artist_id = a.artist_id
INNER JOIN dbo.Genre AS g ON g.name = s.genre
WHERE NOT EXISTS (
     SELECT 1
     FROM dbo.SongGenre AS sg
     WHERE sg.song_id = so.song_id
          AND sg.genre_id = g.genre_id
);
GO

INSERT INTO dbo.SongStyle (song_id, style_id)
SELECT DISTINCT so.song_id, st.style_id
FROM staging.charts AS s
CROSS APPLY STRING_SPLIT(s.style, '|')
INNER JOIN dbo.Artist AS a ON a.name = s.artist
INNER JOIN dbo.Song AS so ON so.name = s.song 
     AND so.artist_id = a.artist_id
INNER JOIN dbo.Style AS st ON st.name = value
WHERE NOT EXISTS (
     SELECT 1
     FROM dbo.SongStyle AS ss
     WHERE ss.song_id = so.song_id
          AND ss.style_id = st.style_id
);
GO

INSERT INTO dbo.Entry (week, position, song_id, label_id)
SELECT DISTINCT s.week, s.position, so.song_id, l.label_id
FROM staging.charts AS s
INNER JOIN dbo.Artist AS a ON a.name = s.artist
INNER JOIN dbo.Song AS so ON so.name = s.song
     AND so.artist_id = a.artist_id
INNER JOIN dbo.Label AS l ON l.name = s.label
WHERE NOT EXISTS (
     SELECT 1
     FROM dbo.Entry AS e
     WHERE e.week = s.week
          AND e.position = s.position
          AND e.song_id = so.song_id
          AND e.label_id = l.label_id
);
GO