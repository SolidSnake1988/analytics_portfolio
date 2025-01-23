# Data Analyst Portfolio

Welcome to my **Data Analyst Portfolio**! This repository demonstrates my proficiency in **SQL** and **Python** for data analysis, using a dataset of vehicle information. Below, you'll find the project structure, key insights, and links to the code and dataset.

---

## 🚗 **Project Overview**

This portfolio project involves analyzing a vehicle dataset (`car_data.csv`) to extract meaningful insights. The analysis is divided into two parts:

1. **SQL Analysis**: Showcases my ability to perform operations such as data definition, data manipulation, aggregation, filtering, sorting, and advanced queries like window functions.
2. **Python Analysis**: Highlights my skills in data preprocessing, visualization, and generating actionable insights using Python libraries like **pandas** and **matplotlib**.

---

## 📁 **Repository Structure**

```
|-- car_data.csv                       # Dataset: Vehicle information
|-- Python Code.ipynb                  # Python notebook for data analysis
|-- Vehicle Manufacturing Portfolio Code.sql # SQL queries for vehicle data analysis
|-- README.md                          # Project documentation (this file)
```

---

## 💾 **Dataset Details**

| **Column Name** | **Description**         |
|-----------------|-------------------------|
| `Car ID`        | Unique identifier for each car |
| `Brand`         | Manufacturer of the car |
| `Model`         | Specific model of the car |
| `Year`          | Year of manufacture     |
| `Color`         | Color of the car        |
| `Mileage`       | Total miles driven      |
| `Price`         | Selling price in USD    |
| `Location`      | City where the car is sold |

---

## 🗄️ **SQL Analysis**

The SQL script (`Vehicle Manufacturing Portfolio Code.sql`) demonstrates the following:

1. **Data Definition**: Creating a table (`vehicle_info`) to store the dataset.
2. **Basic Queries**: Retrieving data with filtering, sorting, and aggregation.
3. **Advanced Techniques**: Using window functions, joins, and correlated subqueries to derive deeper insights.

### Example Query:
```sql
-- Find the average price of cars by brand
SELECT Brand, AVG(Price) AS Avg_Price
FROM vehicle_info
GROUP BY Brand
ORDER BY Avg_Price DESC;
```

---

## 🐍 **Python Analysis**

The Python notebook (`Python Code.ipynb`) focuses on:

1. **Data Preprocessing**: Handling missing values, data type conversion, and exploratory data analysis.
2. **Visualization**: Creating charts to highlight trends (e.g., car price vs. mileage, distribution of car colors).
3. **Insights**: Generating actionable findings to guide decision-making.

### Example Code:
```python
import pandas as pd
import matplotlib.pyplot as plt

# Load the dataset
df = pd.read_csv('car_data.csv')

# Plotting price vs mileage
plt.scatter(df['Mileage'], df['Price'], alpha=0.5)
plt.title('Car Price vs Mileage')
plt.xlabel('Mileage')
plt.ylabel('Price (USD)')
plt.show()
```

---

## 📊 **Key Insights**

1. **Most Expensive Brands**: The top brands with the highest average car prices.
2. **Mileage Impact**: Cars with lower mileage generally command higher prices.
3. **Regional Trends**: Differences in car preferences across locations.

---

## ✨ **How to Use This Portfolio**

1. Clone this repository:
   ```bash
   git clone https://github.com/solidsnake1988/data-analyst-portfolio.git
   ```
2. Explore the SQL queries in `Vehicle Manufacturing Portfolio Code.sql`.
3. Open `Python Code.ipynb` in Jupyter Notebook to run the Python analysis.
4. Review the dataset in `car_data.csv` to understand the structure and content.

---

## 🙌 **Acknowledgments**

This project was created to demonstrate my data analysis skills and provide actionable insights from a real-world dataset. Feedback and suggestions are always welcome!

