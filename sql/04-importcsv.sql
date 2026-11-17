BULK INSERT staging.charts
FROM 'C:\Users\amy\Amy''s Projects\ChartsSpider\output\cleancharts.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO