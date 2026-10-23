# ecommerce-logistics-insights

# Shipping Experience Analytics
### How delivery delays and freight costs impact customer satisfaction — and which fix is worth doing first

[![Python](https://img.shields.io/badge/Python-3.11-blue)](https://www.python.org/)
[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)](https://powerbi.microsoft.com/)
[![Streamlit](https://img.shields.io/badge/Streamlit-Live%20App-red)](https://streamlit.io/)

**🔗 [Live Dashboard](#)** &nbsp;|&nbsp; **📄 [Executive Summary (PDF)](#)** &nbsp;|&nbsp; **📓 [Full Analysis Notebook](#)**

> *Replace the links above once the dashboard is deployed and the summary is written.*

---

## 1. The Business Problem

This project simulates a real analytics request from an e-commerce operations team:

> **From:** VP of Operations
> **To:** Data Analyst
> **Subject:** Customer complaints about shipping
>
> "We've been hearing more complaints from customers about shipping lately. Can you take a look at what's going on and tell us what we should do about it?"

The request is intentionally vague — matching how real stakeholder requests usually arrive. Before starting the analysis, a set of clarifying questions was used to scope the problem (see [`01_clarifying_questions.md`](./01_clarifying_questions.md)).

**Scoped business question:**
*Do delivery delays and high freight costs — individually or combined — hurt customer satisfaction (review score) and order value? And if we can only fix one thing first, which intervention gives the better return?*

---

## 2. Key Findings

> *Fill in with real numbers once analysis is complete. Keep to 3–5 bullets, lead with the number.*

- Orders delivered late (>X days past estimate) averaged a review score of **X.X**, vs **X.X** for on-time orders.
- Orders in the top quartile of freight-to-price ratio had **X% lower** average order value than the bottom quartile.
- Orders that were **both** late *and* high-freight scored the worst on average (**X.X**) — worse than either problem alone, suggesting a compounding effect.
- [Region/category] showed the highest combined risk and is the best candidate for a pilot fix.

---

## 3. Methodology

**Data:** [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

| Step | What was done | Tools |
|---|---|---|
| 1. Extract & load | Loaded raw CSVs into PostgreSQL, normalized into a relational schema | PostgreSQL, SQL |
| 2. Clean & validate | Handled missing delivery dates, deduplicated orders, flagged invalid freight values | Python (Pandas) |
| 3. Diagnose | Analyzed delay and freight-ratio correlation with review score and order value separately, then combined | SQL (window functions), Pandas |
| 4. Test | Simulated two intervention strategies (free-shipping threshold vs. proactive delay notifications) as an A/B test on synthetic treatment data, layered on real baseline patterns | SciPy (statistical testing) |
| 5. Report | Built KPI dashboard and wrote a one-page executive summary | Power BI (DAX), Streamlit |

**Note on Part 3:** Olist's dataset does not contain real A/B test data. The intervention outcomes are simulated to demonstrate hypothesis-testing methodology; this is clearly labeled in the analysis and is not presented as real experimental results.

A record of dead ends and discarded hypotheses is kept in [`02_analysis/`](./02_analysis/) — not every path taken led somewhere, and that's part of the process.

---

## 4. What I'd Do Next (Follow-up Iteration)

> *After presenting Part 3, the stakeholder asked a natural follow-up: "The results look promising, but what would each option cost to implement, and is it worth it?"*

See [`05_followup_iteration.md`](./05_followup_iteration.md) for a simple cost-benefit comparison between the two intervention strategies.

---

## 5. Project Structure

```
📁 shipping-experience-analytics
├── 📄 00_stakeholder_request.md      # Simulated initial request
├── 📄 01_clarifying_questions.md     # Scoping questions before analysis
├── 📁 02_analysis/                   # SQL queries, notebooks, dead-ends included
├── 📊 03_dashboard/                  # Power BI (.pbix) + Streamlit app
├── 📄 04_executive_summary.pdf       # 1-page, business-language summary
├── 📄 05_followup_iteration.md       # Stakeholder follow-up + cost-benefit answer
├── 📄 requirements.txt
├── 📄 .env.example
└── 📄 README.md
```

---

## 6. Tech Stack

- **Database:** PostgreSQL (schema design, window functions, query optimization)
- **Language:** Python — Pandas (data wrangling), SciPy (statistical testing), scikit-learn (feature analysis)
- **Visualization:** Power BI (DAX measures), Streamlit (live interactive app)
- **Version control:** Git/GitHub

---

## 7. Running This Project Locally

```bash
# Clone the repo
git clone https://github.com/<your-username>/shipping-experience-analytics.git
cd shipping-experience-analytics

# Set up environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# Configure database connection
cp .env.example .env
# then fill in your PostgreSQL credentials in .env

# Download the dataset
# https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
# place CSVs into data/

# Run the Streamlit app
streamlit run 03_dashboard/app.py
```

---

## Contact

**[ชื่อ-นามสกุล]**
📧 [email] · 💼 [LinkedIn] · 💻 [GitHub]
