I used my own [web scraper](https://github.com/amypearlt/thecharttimemachine_scraper) to extract data about 20th century UK music charts, as part of an ETL pipeline (Pandas, SQL Server) with accompanying data analysis and visualisation layers.

To use the Pandas cleaning script for the extracted data, run: 

`python ChartsClean.py -i charts.csv -o output/cleancharts.csv`

Both the raw and cleaned datasets of all 20th century weekly UK singles charts, from 1952 to 1999, can be found on [Kaggle](https://www.kaggle.com/datasets/amypearlt/20th-century-weekly-uk-singles-charts-raw/data?select=Weekly+UK+Singles+Charts.csv).