**Database Project - IST 2021/22**

This repository contains the implementation of a database project developed for the **Databases** course at Instituto Superior Técnico (IST). The project focuses on **SQL schema design, integrity constraints, complex queries, web application integration, and OLAP analysis**.

## **Project Overview**

### **1. Database Schema & Integrity Constraints**
- Developed an **SQL schema** following relational database design principles.
- Implemented **primary keys, foreign keys, unique constraints, and check constraints**.
- Defined **stored procedures and triggers** to enforce business rules.

### **2. SQL Queries & Views**
- Implemented complex **SQL queries** for data retrieval and manipulation.
- Developed **views** to summarize key business insights.
- Created **aggregation queries** using `GROUP BY`, `ROLLUP`, and `CUBE`.

### **3. Web Application Prototype**
- Built a **Python CGI-based web application** for data management.
- Allowed users to **insert, update, and delete** records securely.
- Implemented **SQL injection protection** and atomic transactions.

### **4. OLAP Analysis & Index Optimization**
- Designed **OLAP queries** for analyzing sales and replenishment trends.
- Used `ROLLUP`, `CUBE`, and `GROUPING SETS` for multidimensional analysis.
- Optimized performance by implementing **SQL indexes** for faster querying.

## **Installation & Setup**

To set up the project:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/database-project.git
   cd database-project
   ```

2. **Set Up PostgreSQL Database**
   ```sql
   psql -U postgres -c "CREATE DATABASE database_project;"
   psql -U postgres -d database_project -f schema.sql
   psql -U postgres -d database_project -f populate.sql
   ```

3. **Run the Web Application**
   ```bash
   python -m http.server 8000
   ```
   Then, open `http://localhost:8000` in your browser.

## **Results Summary**
- **Designed an optimized relational database schema** with integrity constraints.
- **Developed SQL queries and views** for data extraction and aggregation.
- **Implemented a web-based interface** for database interaction.
- **Created OLAP queries and indexed key attributes** for query optimization.

## **Challenges & Future Improvements**
- **Enhance security** with role-based access control.
- **Optimize indexing further** for high-volume data operations.
- **Improve web UI usability** with AJAX and responsive design.

## **Contributors**
- **Gonçalo Gonçalves**
- **Joana Brito**
- **João Marques**

