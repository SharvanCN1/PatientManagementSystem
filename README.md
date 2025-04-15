# 🗃️ Database Project with UI Interaction

This project demonstrates a database system using SQL and a Python-based UI. It includes scripts to create and populate the database, perform various queries (views, subqueries, tests), and interact with the data via a simple user interface.

---

## 📁 Project Structure

```
├── create_database.sql     # SQL script to create schema and tables
├── insert_data.sql         # Insert sample data into tables
├── index.sql               # Add indexes to improve performance
├── views.sql               # Create database views
├── view_views.sql          # Inspect and test views
├── sub_queries.sql         # Execute subqueries
├── test.sql                # Test queries and validations
├── queries.sql             # Core queries used in the application
├── app.py                  # Python-based UI to interact with the database
├── requirements.txt        # Python dependencies
├── ER diagram.png          # Entity-Relationship diagram for the database
```

---

## ⚙️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/SharvanCN1/PatientManagementSystem.git
cd PatientManagementSystem 
```

### 2. Set Up the Virtual Environment

```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Set Up the Database

Ensure you have a database server (like PostgreSQL or MySQL) running. Update `app.py` with your DB credentials if needed.

Run the SQL scripts in the following order:

```bash
mysql -U youruser -d yourdb -f create_database.sql
mysql -U youruser -d yourdb -f insert_data.sql
mysql -U youruser -d yourdb -f index.sql
mysql -U youruser -d yourdb -f views.sql
```

(Optional)
```bash
mysql -U youruser -d yourdb -f sub_queries.sql
mysql -U youruser -d yourdb -f test.sql
mysql -U youruser -d yourdb -f view_views.sql
```

### 5. Run the Application

```bash
python app.py
```

This should launch the UI or CLI interface to interact with your database.

---

## 🧠 Features

- Full SQL schema with ER diagram
- Sample data and index optimization
- Views and subqueries
- Basic tests
- Python app for user interaction

---

## 📷 ER Diagram

![ER Diagram](ER%20diagram.png)

---

## 🧪 Testing

To run tests (if included in `test.sql`):

```bash
psql -U youruser -d yourdb -f test.sql
```

---

## 📌 Notes

- Ensure the database server is up and accessible before running scripts.
- Customize credentials and connection strings in `app.py` as needed.
- Modify queries in `queries.sql` or `app.py` to fit your use case.

---

## 📄 License

MIT License
