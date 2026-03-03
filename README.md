# Clinical Trial Enrollment Optimization
> **Portfolio Project | Clinical Operations Analytics**  
> Tools: Python · SQL · SQLite · Power BI · VS Code  
> Data: ClinicalTrials.gov (3,126 real completed trials)

---

## Project Overview

This project analyzes **3,126 real clinical trials** from ClinicalTrials.gov to identify enrollment patterns, site selection strategies, and trial design factors that influence enrollment size and trial duration.

The analysis is built entirely in VS Code using Python, SQLite, and Power BI — mirroring the analytics stack used in real clinical operations consulting engagements.

**Business Problem:** Every month of Phase 3 delay costs pharmaceutical companies $600K–$8M in delayed launch revenue. Enrollment planning is the #1 controllable variable in clinical operations. This project identifies data-driven strategies to optimize enrollment.

---

## Key Findings

| Finding | Insight |
|---|---|
| Phase 3 vs Phase 2 enrollment | Phase 3 trials enroll **4.7x more patients** (639 vs 136 avg) |
| Industry vs NIH duration | Industry trials complete **3.2x faster** (20.8 vs 67 months) |
| Multinational advantage | Multinational trials enroll **3.4x more patients** (740 vs 217 avg) |
| Top country | USA hosts 1,481 trials — but Russia and UK have highest avg enrollment |
| Trial volume peak | Trial starts peaked in **2008** with 191 new trials |

---

## Project Structure

```
clinical-trial-enrollment/
├── data/
│   └── raw/
│       ├── ctg-studies.csv          # Original ClinicalTrials.gov export
│       ├── ctg_cleaned.csv          # Cleaned trial-level data
│       └── ctg_countries.csv        # Exploded country-level data
├── sql/
│   ├── 01_schema.sql                # SQLite table definitions
│   ├── 02_load_data.py              # CSV → SQLite loader
│   └── 03_queries.sql               # 6 analytical SQL queries
├── notebooks/
│   ├── 01_data_cleaning.ipynb       # Parsing, feature engineering
│   ├── 02_eda.ipynb                 # SQL queries + 5 charts
│   └── 03_survival_analysis.ipynb  # Kaplan-Meier analysis
├── outputs/
│   ├── 01_enrollment_by_phase.png
│   ├── 02_duration_by_funder.png
│   ├── 03_top_countries.png
│   ├── 04_enrollment_trend.png
│   ├── 05_multinational_vs_single.png
│   └── 06_km_by_phase.png
├── powerbi/
│   └── enrollment_dashboard.pbix   # 3-page Power BI dashboard
└── README.md
```

---

## Tech Stack

| Layer | Tool |
|---|---|
| Code Editor | VS Code with Python, Jupyter, SQLite Viewer extensions |
| Data Cleaning | Python — pandas, numpy |
| Visualization | Python — matplotlib, seaborn |
| Survival Analysis | Python — lifelines (Kaplan-Meier) |
| Database | SQLite — queried via Python sqlite3 |
| Dashboard | Power BI Desktop with DAX measures |
| Data Source | ClinicalTrials.gov — ctg-studies.csv |

---

## Data

**Source:** [ClinicalTrials.gov](https://clinicaltrials.gov)  
**File:** ctg-studies.csv  
**Scope:** 3,170 completed interventional trials → 3,126 after cleaning  
**Columns used:** NCT Number, Phases, Enrollment, Funder Type, Sponsor, Start Date, Completion Date, Study Design, Locations

> **Note on patient-level data:** Real patient-level data (dropout reasons, days to enroll per patient) is protected under ICH E6 GCP guidelines. This project uses aggregate trial-level data — exactly what is available in real clinical operations practice.

---

## Data Cleaning

The raw ClinicalTrials.gov export required significant feature engineering:

- **Dates:** Mixed format strings (`YYYY-MM` and `YYYY-MM-DD`) parsed with `pd.to_datetime(errors='coerce')`
- **Trial Duration:** Computed as `(completion_date - start_date).dt.days / 30.44`
- **Study Design:** Pipe-delimited key:value string parsed into `allocation`, `masking`, `primary_purpose`, `intervention_model` columns
- **Locations:** Pipe-delimited site addresses parsed to extract country — exploded into 10,369 country-level rows
- **Phase Labels:** Standardized from `PHASE2|PHASE3` format to readable `Phase 2/3` labels

---

## SQL Queries

Six analytical queries written in SQLite covering:

1. **Enrollment by Phase** — avg enrollment, min/max, avg duration per phase
2. **Duration by Funder Type** — Industry vs NIH vs Other completion speed
3. **Top 20 Countries** — trial count and avg enrollment per country
4. **Enrollment Trend by Year** — trial volume and avg enrollment 2000–2017
5. **Masking vs Enrollment** — double-blind vs open-label enrollment comparison
6. **Multinational vs Single Country** — enrollment and duration by trial scope

---

## Python Charts

| Chart | File | Key Insight |
|---|---|---|
| Avg Enrollment by Phase | 01_enrollment_by_phase.png | Phase 3 = 639 pts vs Phase 1/2 = 86 pts |
| Duration by Funder Type | 02_duration_by_funder.png | Industry 3x faster than NIH |
| Top 15 Countries | 03_top_countries.png | USA dominates volume; Russia highest avg enrollment |
| Enrollment Trend by Year | 04_enrollment_trend.png | Peak trial volume in 2008 |
| Multinational vs Single | 05_multinational_vs_single.png | 3.4x enrollment advantage |

---

## Survival Analysis

Kaplan-Meier survival curves model **trial completion timelines by phase** using the `lifelines` library.

**Interpretation:** The Y-axis shows probability a trial is still running at each month mark. Steeper drop = faster completion.

**Median completion times:**
- Phase 2: **18 months**
- Phase 3: **22 months**
- Phase 1/2: **26 months**
- Phase 2/3: **26 months**

---

## Power BI Dashboard

3-page interactive dashboard built in Power BI Desktop:

**Page 1 — Enrollment Overview**
- KPI cards: Total Trials, Avg Enrollment, Avg Duration, Multinational Rate
- Bar chart: Avg enrollment by phase
- Line chart: Trial volume and enrollment trend by year
- Donut chart: Trials by funder type
- Bar chart: Top 15 countries

**Page 2 — Geographic Analysis**
- Bubble map: Trial activity by country
- Bar chart: Top 15 countries by trial count
- Bar chart: Multinational vs Single Country avg enrollment

**Page 3 — Trial Design & Duration**
- Bar chart: Avg duration by funder type
- Scatter chart: Duration vs enrollment by phase
- KM survival curve: Trial completion timeline by phase

---

## Recommendations

1. **Design Phase 3 programs as multinational from Day 1** — 3.4x enrollment advantage with faster completion
2. **Use phase benchmarks for planning** — Phase 3 avg 639 patients, 22 months median
3. **Prioritize high-volume countries for site selection** — USA, Canada, Germany have proven infrastructure
4. **Close the Industry vs NIH duration gap** — adopt industry-standard milestone tracking and site dashboards
5. **Monitor enrollment pace monthly** — use Power BI dashboard to flag underperforming sites early

---

## Setup Instructions

```bash
# Clone the repo
git clone https://github.com/yourusername/clinical-trial-enrollment.git
cd clinical-trial-enrollment

# Create virtual environment
python -m venv venv
venv\Scripts\activate        # Windows
source venv/bin/activate     # Mac/Linux

# Install dependencies
pip install pandas numpy matplotlib seaborn lifelines openpyxl

# Load data into SQLite
python sql/02_load_data.py

# Open notebooks in VS Code
code .
```

---

## Context

This project mirrors real clinical operations analytics work:
- Data engineering from raw regulatory data sources (equivalent to EDC exports from Medidata Rave / Veeva Vault)
- SQL-based enrollment benchmarking used in site feasibility assessments
- Power BI dashboard format aligned to ZS clinical ops reporting
- Survival analysis methodology applicable to enrollment forecasting models
- Recommendations structured as consulting deliverables with data-backed rationale

---

*Data source: ClinicalTrials.gov | All trial data is publicly available aggregate data | No patient-level data used*
