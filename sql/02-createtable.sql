USE charts;
GO
CREATE TABLE dbo.Artist (
    artist_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(250) NOT NULL
);
GO
CREATE TABLE dbo.Label (
    label_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);
GO
CREATE TABLE dbo.Genre (
    genre_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);
GO
CREATE TABLE dbo.Style (
    style_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);
GO
CREATE TABLE dbo.Song (
    song_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(500) NOT NULL,
    artist_id INT NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES dbo.Artist(artist_id)
);
GO
CREATE TABLE dbo.SongGenre (
    song_id INT,
    genre_id INT,
    PRIMARY KEY (song_id, genre_id),
    FOREIGN KEY (song_id) REFERENCES dbo.Song(song_id),
    FOREIGN KEY (genre_id) REFERENCES dbo.Genre(genre_id)
);
GO
CREATE TABLE dbo.SongStyle (
    song_id INT,
    style_id INT,
    PRIMARY KEY (song_id, style_id),
    FOREIGN KEY (song_id) REFERENCES dbo.Song(song_id),
    FOREIGN KEY (style_id) REFERENCES dbo.Style(style_id)
);
GO
CREATE TABLE dbo.Entry (
    entry_id INT IDENTITY(1,1) PRIMARY KEY,
    week DATE NOT NULL,
    position INT NOT NULL,
    song_id INT NOT NULL,
    label_id INT NOT NULL,
    FOREIGN KEY (song_id) REFERENCES dbo.Song(song_id),
    FOREIGN KEY (label_id) REFERENCES dbo.Label(label_id)
);
GO