CREATE TABLE dailynewsarticles (
    SumberArtikel VARCHAR(255),
    JudulArtikel VARCHAR(255),
    IsiArtikel TEXT,
    WaktuTerbit TIMESTAMP,
    Gambar VARCHAR(255),
    TanggalTerbit DATE,
    BulanTerbit VARCHAR(255),
    TahunTerbit INT
);

ALTER TABLE dailynewsarticles
ADD COLUMN URL VARCHAR(255);

ALTER TABLE dailynewsarticles
ALTER COLUMN SumberArtikel TYPE VARCHAR(1000);

ALTER TABLE dailynewsarticles
ALTER COLUMN JudulArtikel TYPE VARCHAR(1000);

ALTER TABLE dailynewsarticles
ALTER COLUMN IsiArtikel TYPE TEXT;

ALTER TABLE dailynewsarticles
ALTER COLUMN WaktuTerbit TYPE TIMESTAMP;

ALTER TABLE dailynewsarticles
ALTER COLUMN Gambar TYPE VARCHAR(1000);

ALTER TABLE dailynewsarticles
ALTER COLUMN TanggalTerbit TYPE DATE;

ALTER TABLE dailynewsarticles
ALTER COLUMN BulanTerbit TYPE VARCHAR(255);

ALTER TABLE dailynewsarticles
ALTER COLUMN TahunTerbit TYPE INT;

ALTER TABLE dailynewsarticles
ALTER COLUMN URL TYPE VARCHAR(1000);
