# Global Renewable Energy Transition Analysis

## Overview

This project analyzes global power plant data to understand how energy capacity is distributed between renewable and non-renewable sources, and what this means for the global energy transition.

The focus is on identifying structural patterns in energy systems and evaluating how countries are progressing toward renewable integration.

---

## Business / Engineering Problem

Global energy systems are under pressure to transition toward low-carbon sources.

Energy planners and policymakers need to understand:

- How much capacity is renewable vs non-renewable  
- Which regions are progressing in the transition  
- Whether renewables are replacing or simply adding to existing systems  

---

## Data Source

Dataset: Global Power Plant Database (Kaggle)

The dataset contains plant-level records including:
- Capacity (MW)  
- Fuel type (solar, wind, hydro, coal, gas, etc.)  
- Country and location  
- Commissioning year :contentReference[oaicite:0]{index=0}  

---

## Tools Used

- SQL — data cleaning, transformation, aggregation  
- Tableau — dashboard and visualisation  

---

## Data Preparation

- Cleaned and standardised plant-level data  
- Grouped fuel types into:
  - Renewable  
  - Non-renewable  
- Aggregated data to:
  - Global capacity totals  
  - Country-level summaries  

---

## Analysis Approach

- Calculated total installed capacity by fuel type  
- Compared renewable vs non-renewable share  
- Analyzed country-level differences  
- Identified trends in capacity growth over time  
- Built a Tableau dashboard to visualise energy mix and distribution  

---

## Key Findings

### 1. Global Energy Mix is Fossil-Dominated

- ~73% non-renewable  
- ~27% renewable :contentReference[oaicite:1]{index=1}  

👉 Interpretation:  
The global energy system is still structurally dependent on fossil fuels.

---

### 2. Renewable Adoption is Uneven

Some countries show high renewable penetration, while others remain fossil-dependent.

👉 Interpretation:  
The transition is region-specific, not uniform.

---

### 3. Mixed Energy Systems Dominate

Most countries rely on a combination of:
- Fossil fuels  
- Renewables  

👉 Interpretation:  
Energy systems are hybrid, not fully transitioned.

---

### 4. Transition is Additive, Not Substitutive

Renewables are being added to the system rather than replacing fossil capacity.

👉 Interpretation:
- Fossil infrastructure remains active  
- Total system capacity increases instead of shifting  

---

## Engineering Implications

- Grid systems must handle hybrid generation mixes  
- Increased need for:
  - Energy storage  
  - Grid flexibility  
  - Load balancing solutions  
- Renewable integration introduces variability challenges  

---

## Business Implications

- Continued reliance on fossil assets  
- Higher infrastructure investment requirements  
- Need for coordinated policy and system planning  

---

## Recommendations

### 1. Invest in Grid Flexibility
Support renewable integration with:
- Storage systems  
- Demand response  
- Flexible generation  

---

### 2. Accelerate Fossil Replacement Strategies
Focus on:
- Retiring aging plants  
- Replacing base-load fossil capacity  

---

### 3. Target Region-Specific Strategies
Different countries require different approaches based on:
- Resource availability  
- Existing infrastructure  

---

## Limitations

- No demand-side data  
- No emissions data  
- No cost modelling  
- Capacity-based analysis (not actual generation output)  

---

## Project Structure

├── data/ # Dataset
├── analysis/ # SQL scripts
├── tableau/ # Dashboard
├── images/ # Dashboard screenshots
├── docs/ # Report / PDF
└── README.md

---

## Dashboard Preview

<img width="1366" height="758" alt="global power plants dashboard" src="https://github.com/user-attachments/assets/2fa5859a-2771-499e-ae9f-f9a2dce93038" />

---

## Conclusion

Global energy systems remain heavily dependent on fossil fuels, with renewable adoption progressing unevenly across regions.

The transition is gradual and additive, requiring system-level upgrades to support long-term decarbonisation.


