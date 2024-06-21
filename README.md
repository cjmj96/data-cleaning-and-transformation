# Data cleaning and transformation (Airbnb case study)

This project aims to show SQL skills when performing the data cleaning and transformation tasks within the CRISP-DM process model for an Airbnb dataset of the city of Boston. The repository structure is:
- `data`: Contains the raw dataset in csv format.
- `documentation`: Contains the report documenting all tasks performed.
- `scripts`: Contains PostgreSQL scripts for each CRISP-DM phase related to data cleaning and transformation. It’s divided into two directories, data_preparation and data_understanding with PostgreSQL scripts representing the task performed in that phases. And the data dump file to recreate the database in the same state as it was at the time of the dump.

## How to use
To reproduce the results, you can load the data dump file using the following command:

```bash
-- Create new database with the standard PostgreSQL
-- system catalogs, unmodified by any previous actions
createdb -T template0 dbname

-- Restore a dump file
psql --set ON_ERROR_STOP=on dbname < dumpfile
```

Or create the database and then running every script. You need to place the files in `data` on the temporary directory/folder of your operating system. Remember to install psql (16.2).
