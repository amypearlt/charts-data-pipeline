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