# 🚚 Shipping Experience Analytics
**วิเคราะห์ผลกระทบของความล่าช้าในการจัดส่งและต้นทุนค่าส่ง ที่มีต่อความพึงพอใจของลูกค้า พร้อมทดสอบ A/B เปรียบเทียบ 2 แนวทางแก้ปัญหา**

🔗 **[ดู Dashboard แบบ Live ที่นี่](#)** <!-- ใส่ลิงก์ Streamlit/Power BI หลัง deploy -->

---

## 📌 โจทย์ทางธุรกิจ (Business Problem)

> *"เราได้ยิน complaint จากลูกค้าเรื่องการจัดส่งเยอะขึ้นในช่วงหลัง ช่วยดูหน่อยว่าเกิดอะไรขึ้น แล้วเราควรทำอะไรบ้าง"*
> — VP of Operations (จำลองสถานการณ์)

โจทย์นี้กำกวมโดยตั้งใจ (เหมือนงานจริง) จึงเริ่มต้นด้วยการตั้งคำถามเพื่อ clarify scope ก่อนลงมือวิเคราะห์ — ดูรายละเอียดที่ [`00_stakeholder_request.md`](./00_stakeholder_request.md) และ [`01_clarifying_questions.md`](./01_clarifying_questions.md)

---

## 🔍 ข้อค้นพบสำคัญ (Key Findings)

<!-- แก้ไขตามผลวิเคราะห์จริงหลังทำเสร็จ ตัวอย่างโครงที่ควรมี: -->

- **[Finding 1]** — เช่น: Order ที่ล่าช้าเกิน X วัน มี review score เฉลี่ยต่ำกว่า Y เท่าเมื่อเทียบกับ order ที่ส่งตรงเวลา
- **[Finding 2]** — เช่น: หมวดสินค้า/ภูมิภาคที่มี freight-to-price ratio สูงที่สุดคือ...
- **[Finding 3 — Compound Effect]** — เช่น: Order ที่มีทั้ง delay สูง **และ** freight ratio สูง มี review score แย่กว่า order ที่มีปัญหาแค่อย่างเดียวอย่างมีนัยสำคัญ
- **[Finding 4 — A/B Test Result]** — เช่น: การแจ้งเตือนล่วงหน้า (Treatment B) ให้ผลดีกว่า free shipping threshold (Treatment A) ในแง่การรักษา review score โดยมี p-value < 0.05

📄 อ่านสรุปแบบเต็มสำหรับผู้บริหาร (non-technical): [`04_executive_summary.pdf`](./04_executive_summary.pdf)

---

## 🧭 วิธีการวิเคราะห์ (Methodology)

โปรเจกต์นี้จำลอง workflow การทำงานจริงของ Data Analyst แบ่งเป็น 3 ส่วน:

### Part 1 — Business Health Dashboard
สร้าง KPI dashboard ภาพรวม (on-time delivery rate, freight-to-price ratio, average review score, order value) เพื่อระบุจุดที่มีปัญหา

### Part 2 — Deep-Dive Analysis
เจาะลึกหาสาเหตุด้วย SQL window functions และ correlation analysis แยกวิเคราะห์ผลของ delay และ freight cost ทั้งแบบเดี่ยวและแบบรวมกัน (compound effect)

> ระหว่างวิเคราะห์มีสมมติฐานที่ลองแล้ว "ไม่เจอ pattern ชัดเจน" ด้วย — บันทึกไว้ใน [`02_analysis/`](./02_analysis/) เพื่อแสดงกระบวนการคิดทั้งหมด ไม่ใช่แค่ผลลัพธ์ที่สำเร็จ

### Part 3 — Simulated A/B Test
จำลองข้อมูลทดสอบ 2 แนวทางแก้ปัญหา (free shipping threshold vs. proactive delay notification) แล้วใช้สถิติ (t-test / Diebold-Mariano) เปรียบเทียบว่าวิธีไหนคุ้มค่ากว่า สำหรับการตัดสินใจจัดสรรงบประมาณ

> ⚠️ ข้อมูลในส่วน A/B Test เป็น **synthetic data** ที่สร้างขึ้นเพื่อสาธิต methodology เนื่องจาก dataset ต้นฉบับไม่มีผลการทดลองจริง

### Follow-up
หลังนำเสนอผล มีคำถามต่อเนื่องจาก stakeholder เรื่องต้นทุน-ผลตอบแทน — ดูการวิเคราะห์เพิ่มเติมที่ [`05_followup_iteration.md`](./05_followup_iteration.md)

---

## 🛠️ Tech Stack

| หมวด | เครื่องมือ |
|---|---|
| Data Processing | Python (Pandas) |
| Database | PostgreSQL |
| Statistical Testing | SciPy (t-test, hypothesis testing) |
| Visualization | Power BI (DAX), Streamlit |
| Version Control | Git / GitHub |

---

## 📊 ข้อมูลที่ใช้ (Data Source)

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

> ไฟล์ข้อมูลไม่ได้ commit ไว้ใน repo นี้ (ขนาดใหญ่เกินไป) — ดาวน์โหลดจาก Kaggle แล้ววางไว้ในโฟลเดอร์ `data/` ก่อนรันโค้ด

---

## 🚀 วิธีรันโปรเจกต์นี้

```bash
# 1. Clone repository
git clone https://github.com/[username]/shipping-experience-analytics.git
cd shipping-experience-analytics

# 2. ติดตั้ง dependencies
pip install -r requirements.txt

# 3. ตั้งค่า environment variables
cp .env.example .env
# แก้ไขค่าใน .env ให้ตรงกับ PostgreSQL ของคุณ

# 4. รัน dashboard
streamlit run app.py
```

---

## 📁 โครงสร้างโปรเจกต์

```
├── 00_stakeholder_request.md      # โจทย์เริ่มต้นจาก stakeholder (จำลอง)
├── 01_clarifying_questions.md     # คำถามที่ใช้ scope โจทย์ก่อนเริ่มวิเคราะห์
├── 02_analysis/                   # Notebook, SQL queries (รวม dead-ends)
├── 03_dashboard/                  # Power BI / Streamlit source
├── 04_executive_summary.pdf       # สรุป 1 หน้าสำหรับผู้บริหาร
├── 05_followup_iteration.md       # คำถามเพิ่มเติมหลังนำเสนอ + คำตอบ
├── requirements.txt
├── .env.example
└── README.md
```

---

## 👤 ผู้จัดทำ

[Rapeepong]
