# Data cleaning & transformation

![airbnb-logo](https://i.ibb.co/h9RwFNk/airbnb.png)

<a href="https://www.flaticon.com/free-icons/airbnb" title="airbnb icons">Airbnb icons created by riajulislam - Flaticon</a>

## **Table of content**

- [Summary](#summary)
- [Introduction](#introduction)
- [Data understanding](#data-understanding)
	- [Initial data collection](#initial-data-collection)
- [Data preparation](#data-preparation)
- [Results](#results)
- [Conclusion](#conclusion)
- [References](#references)
- [Appendix](#appendix)

<a id='summary'></a>
## **Summary**

### **Goal**

Produce high quality data for Airbnb listings from Boston, MA. This data could help a data analyst to understand the current short-term rental market, providing insights that will guide the expansion of a real state company or individual.


### **Process**


I stored the data locally, then created a PostgreSQL database with multiple tables representing different elements of the data. Finally, I applied several techniques and methods to ensure data quality.

### **Highlights**


<a id='introduction'></a>
## **Introduction**

This project aims to generate high-quality data using different techniques and methods. This data can assist a data analyst in understanding the current short-term rental market to guide the expansion of a real state company or individual.

I have selected PostgreSQL as my primary tool to take advantage of its features and showcase my expertise.

The project methodology is based on CRISP-DM (Cross-Industry Standard Process for Data Mining) [1], incorporating only the components that aligns with project's objective.


<a id='data-understanding'></a>
## **Data understanding**


<a id='initial-data-collection'></a>
### Initial data collection

The collected data is in .csv format. It contains 7 files representing different aspects of the data. Three of them represent detailed data about listings (`listings.csv`) including their availability in the next 12 months (`calendar.csv`), and past reviews (`reviews.csv`). The next three, represents a summarized version of the detailed data. The remaining two, represents geographical information for the neighborhoods (`neighbourhoods.csv`, `neighbourhoods.geojson`). I select only the first three files containing data that align with the project’s objective. I gathered the data from Inside Airbnb [2] manually.

<a id='references'></a>
## References

[1] N. Hotz, “What is CRISP DM?,” Data Science Project Management, Jan. 19, 2023. https://www.datascience-pm.com/crisp-dm-2/ (accessed May 14, 2024).
‌

[2] Airbnb, “Inside Airbnb” Inside Airbnb. https://insideairbnb.com/ (accessed May 14, 2024).
