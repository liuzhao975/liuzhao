# liuzhao
The code used in the article “Study on Evolvement Characteristics and Optimal Operation of Urban Complex Multi-source Water Supply System under Sustainable Development Mode”，and it for real-time optimization of reservoir–supply network with inflow forecast.
---

## 📁 Code Structure Overview

### Ⅰ. Inflow Forecast Module

#### 1. API-based Forecast

**Input:**
- `'Parameters'` sheet  
  - **Baseflow**: Runoff data of nine reservoirs (previous and current year).  
  - **Rainfall Database**: Rainfall data of nine reservoirs (at least the past 20 days + next 3 days forecast).

**Output:**
- `'Inflow'` sheet → `'Qin'`: Predicted inflow for the next **3 days**.

---

#### 2. LSTM-based Forecast

**Input:**
- `'Parameters'` sheet → `'Sheet1'`: Runoff data of nine reservoirs (longer series yields better accuracy).

**Output:**
- `'Inflow'` sheet → `'Qin'`: Predicted inflow for the next **3 days**.

---

### Ⅱ. Main Program — Optimization Scheduling

**Input:**
1. `'Inflow'` sheet: 3-day forecast data (real-time data for the current day must be manually added).  
2. `'data'` sheet → `'crtcndtn'`: Real-time water levels and outflows of nine reservoirs  
   - Odd columns: water levels  
   - Even columns: outflows  

**Output (Saved in `'NBresult(1)'` workbook):**
| Sheet | Description |
|:------|:-------------|
| Sheet1 | Intermediate variables of the algorithm |
| Sheet2 | Intermediate variables of the algorithm |
| Sheet3 | Inflow, outflow, water level, and storage of nine reservoirs (current + next 3 days) |
| Sheet4 | Predicted discharge (spillage) for 3 days |
| Sheet5 | Predicted water level for 3 days |
| Sheet6 | Predicted storage for 3 days |
| Sheet7 | Total water supply over 3 days |
| Sheet8 | Water used for power generation over 3 days |
| Sheet9 | Forecasted inflow for 3 days |
| Sheet10 | Total power generation benefits over 3 days |
| Sheet11 | Reservoir group safety index |
| Sheet12 | Reservoir group water supply reliability |
