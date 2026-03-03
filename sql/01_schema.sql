CREATE TABLE IF NOT EXISTS trials (
    nct_number         TEXT PRIMARY KEY,
    study_title        TEXT,
    phase              TEXT,
    enrollment         INTEGER,
    funder_type        TEXT,
    sponsor            TEXT,
    start_date         TEXT,
    completion_date    TEXT,
    duration_months    REAL,
    start_year         INTEGER,
    allocation         TEXT,
    masking            TEXT,
    primary_purpose    TEXT,
    intervention_model TEXT,
    is_multinational   INTEGER,
    country_count      INTEGER
);

CREATE TABLE IF NOT EXISTS trial_countries (
    nct_number  TEXT,
    country     TEXT,
    enrollment  INTEGER,
    phase       TEXT
);