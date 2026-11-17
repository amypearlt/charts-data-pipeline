CREATE SCHEMA staging;
GO

CREATE TABLE staging.charts (
    week DATE NOT NULL,
    position INT NOT NULL,
    artist NVARCHAR(250) NOT NULL,
    song NVARCHAR(500) NOT NULL,
    label NVARCHAR(100) NOT NULL,
    genre NVARCHAR(500) NOT NULL,
    style NVARCHAR(500)
);
GO