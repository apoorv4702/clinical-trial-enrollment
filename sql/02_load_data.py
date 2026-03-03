import pandas as pd
import sqlite3
import os

os.chdir(r'E:\Job\Project\Clinical-trial-enrollment')

conn = sqlite3.connect('clinical_trial.db')

# Load trials table
df = pd.read_csv('data/raw/ctg_cleaned.csv')
trials = df[[
    'NCT Number', 'Study Title', 'phase_clean', 'Enrollment',
    'Funder Type', 'Sponsor', 'start_date', 'completion_date',
    'duration_months', 'start_year', 'allocation', 'masking',
    'primary_purpose', 'intervention_model',
    'is_multinational', 'country_count'
]].rename(columns={
    'NCT Number':   'nct_number',
    'Study Title':  'study_title',
    'phase_clean':  'phase',
    'Enrollment':   'enrollment',
    'Funder Type':  'funder_type',
    'Sponsor':      'sponsor'
})
trials.to_sql('trials', conn, if_exists='replace', index=False)
print(f'Loaded {len(trials):,} rows into [trials]')

# Load countries table
df_c = pd.read_csv('data/raw/ctg_countries.csv')
df_c.to_sql('trial_countries', conn, if_exists='replace', index=False)
print(f'Loaded {len(df_c):,} rows into [trial_countries]')

conn.close()
print('\nclinical_trial.db is ready!')
