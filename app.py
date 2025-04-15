import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import mysql.connector
from typing import Dict, List, Any
import re

class DatabaseConnector:
    @staticmethod
    def connect():
        try:
            return mysql.connector.connect(
                host="localhost",
                user="admin",
                password="yourpassword",
                database="PatientManagementDB"
            )
        except mysql.connector.Error as e:
            messagebox.showerror("Database Connection Error", str(e))
            return None

    @staticmethod
    def execute_query(query: str, params: tuple = (), fetch: bool = False):
        try:
            connection = DatabaseConnector.connect()
            if not connection:
                return None

            cursor = connection.cursor()
            cursor.execute(query, params)

            result = None
            if fetch:
                result = cursor.fetchall()
            else:
                connection.commit()

            cursor.close()
            connection.close()
            return result
        except mysql.connector.Error as e:
            messagebox.showerror("Database Query Error", str(e))
            return None

class UIStyler:
    @staticmethod
    def configure_style(root: tk.Tk):
        style = ttk.Style()
        style.theme_use('clam')

        colors = {
            'background': '#f0f3f6',
            'primary': '#2c3e50',
            'accent': '#3498db',
            'text': '#333333',
            'secondary': '#7f8c8d'
        }

        root.configure(bg=colors['background'])
        root.option_add("*Font", "Segoe 10")

        style.configure('TNotebook', background=colors['background'])
        style.configure('TNotebook.Tab', 
                        background=colors['primary'], 
                        foreground='white', 
                        padding=[15, 8],
                        font=('Segoe', 10, 'bold'))
        style.map('TNotebook.Tab', 
                  background=[('selected', colors['accent'])],
                  expand=[('selected', [1, 1, 1])])

        style.configure('TButton', 
                        background=colors['accent'], 
                        foreground='white',
                        font=('Segoe', 10, 'bold'))
        style.map('TButton', 
                  background=[('active', colors['primary'])])

        style.configure('TEntry', 
                        background='white', 
                        foreground=colors['text'])
        style.configure('TLabel', 
                        background=colors['background'], 
                        foreground=colors['text'])

        style.configure('Treeview', 
                        background='white', 
                        foreground=colors['text'],
                        rowheight=25,
                        fieldbackground='white')
        style.configure('Treeview.Heading', 
                        background=colors['primary'], 
                        foreground='white',
                        font=('Segoe', 10, 'bold'))

        return colors

class ValidationUtils:
    @staticmethod
    def validate_email(email: str) -> bool:
        email_regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return re.match(email_regex, email) is not None

    @staticmethod
    def validate_date(date: str) -> bool:
        date_regex = r'^\d{4}-\d{2}-\d{2}$'
        return re.match(date_regex, date) is not None

    @staticmethod
    def validate_phone(phone: str) -> bool:
        phone_regex = r'^\+?1?\d{10,14}$'
        return re.match(phone_regex, phone) is not None

class HealthcareManagementApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("Advanced Healthcare Management System")
        self.root.geometry("1600x900")
        self.root.minsize(1200, 700)

        self.colors = UIStyler.configure_style(root)

        self.notebook = ttk.Notebook(root)
        self.notebook.pack(expand=True, fill='both', padx=10, pady=10)

        self.tables = [
            'Patient', 'Doctor', 'Appointment', 
            'Prescription', 'MedicalRecord', 'Bill', 'Staff'
        ]

        self.table_frames: Dict[str, ttk.Frame] = {}
        self.tree_views: Dict[str, ttk.Treeview] = {}
        self.entry_fields: Dict[str, Dict[str, ttk.Entry]] = {}
        self.search_entries: Dict[str, Dict[str, ttk.Entry]] = {}

        self.create_table_tabs()

    def create_table_tabs(self):
        for table in self.tables:
            frame = ttk.Frame(self.notebook)
            self.notebook.add(frame, text=table)
            self.table_frames[table] = frame
            
            self.create_table_ui(table, frame)

    def create_table_ui(self, table: str, frame: ttk.Frame):
        columns = self.get_table_columns(table)
        
        tree = ttk.Treeview(frame, columns=columns, show='headings')
        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, width=100, anchor='center')
        tree.pack(expand=True, fill='both', padx=10, pady=10)
        self.tree_views[table] = tree

        entry_frame = ttk.Frame(frame)
        entry_frame.pack(fill='x', padx=10, pady=5)

        self.entry_fields[table] = {}
        for col in columns[1:]:  
            label = ttk.Label(entry_frame, text=col)
            label.pack(side='left', padx=5)
            entry = ttk.Entry(entry_frame, width=15)
            entry.pack(side='left', padx=5)
            self.entry_fields[table][col] = entry

        search_frame = ttk.Frame(frame)
        search_frame.pack(fill='x', padx=10, pady=5)

        search_label = ttk.Label(search_frame, text="Search:")
        search_label.pack(side='left', padx=5)

        self.search_entries[table] = {}
        for col in columns[1:]:  
            label = ttk.Label(search_frame, text=col)
            label.pack(side='left', padx=5)
            entry = ttk.Entry(search_frame, width=15)
            entry.pack(side='left', padx=5)
            self.search_entries[table][col] = entry

        btn_frame = ttk.Frame(frame)
        btn_frame.pack(fill='x', padx=10, pady=5)

        actions = [
            ("Add", self.add_record),
            ("Update", self.update_record),
            ("Delete", self.delete_record),
            ("Refresh", self.fetch_table_data),
            ("Search", self.search_records)
        ]

        for label, command in actions:
            btn = ttk.Button(
                btn_frame, 
                text=f"{label} {table}", 
                command=lambda t=table, cmd=command: cmd(t)
            )
            btn.pack(side='left', padx=5)

        tree.bind('<<TreeviewSelect>>', lambda event, t=table: self.load_record_data(t, event))

        self.fetch_table_data(table)

    def search_records(self, table: str):
        search_conditions = []
        search_values = []

        for col, entry in self.search_entries[table].items():
            search_value = entry.get().strip()
            if search_value:
                search_conditions.append(f"{col} LIKE %s")
                search_values.append(f"%{search_value}%")

        if not search_conditions:
            self.fetch_table_data(table)
            return

        tree = self.tree_views[table]
        
        for item in tree.get_children():
            tree.delete(item)

        query = f"SELECT * FROM {table} WHERE {' AND '.join(search_conditions)}"
        records = DatabaseConnector.execute_query(query, tuple(search_values), fetch=True)

        if records:
            for record in records:
                tree.insert("", "end", values=record)
        else:
            messagebox.showinfo("Search Results", "No records found matching the search criteria.")

    def get_table_columns(self, table: str) -> List[str]:
        query = f"SHOW COLUMNS FROM {table}"
        columns = DatabaseConnector.execute_query(query, fetch=True)
        return [col[0] for col in columns] if columns else []

    def fetch_table_data(self, table: str):
        tree = self.tree_views[table]
        
        for item in tree.get_children():
            tree.delete(item)

        query = f"SELECT * FROM {table}"
        records = DatabaseConnector.execute_query(query, fetch=True)

        if records:
            for record in records:
                tree.insert("", "end", values=record)

    def add_record(self, table: str):
        columns = self.get_table_columns(table)[1:]  
        values = [self.entry_fields[table][col].get() for col in columns]

        if not all(values):
            messagebox.showwarning("Input Error", "Please fill all fields")
            return

        cols_str = ", ".join(columns)
        placeholders = ", ".join(["%s"] * len(columns))
        query = f"INSERT INTO {table} ({cols_str}) VALUES ({placeholders})"

        if DatabaseConnector.execute_query(query, tuple(values)):
            self.fetch_table_data(table)
            messagebox.showinfo("Success", f"{table} record added successfully!")
            self.clear_entries(table)

    def update_record(self, table: str):
        tree = self.tree_views[table]
        selected = tree.selection()

        if not selected:
            messagebox.showerror("Error", f"Select a {table} record to update")
            return

        columns = self.get_table_columns(table)[1:]  
        record_id = tree.item(selected[0])['values'][0]
        values = [self.entry_fields[table][col].get() for col in columns]
        values.append(record_id)

        set_clause = ", ".join([f"{col} = %s" for col in columns])
        query = f"UPDATE {table} SET {set_clause} WHERE {table}ID = %s"

        if DatabaseConnector.execute_query(query, tuple(values)):
            self.fetch_table_data(table)
            messagebox.showinfo("Success", f"{table} record updated successfully!")

    def delete_record(self, table: str):
        tree = self.tree_views[table]
        selected = tree.selection()

        if not selected:
            messagebox.showerror("Error", f"Select a {table} record to delete")
            return

        record_id = tree.item(selected[0])['values'][0]
        query = f"DELETE FROM {table} WHERE {table}ID = %s"

        if DatabaseConnector.execute_query(query, (record_id,)):
            self.fetch_table_data(table)
            messagebox.showinfo("Success", f"{table} record deleted successfully!")

    def load_record_data(self, table: str, event):
        tree = self.tree_views[table]
        selected = tree.selection()

        if selected:
            values = tree.item(selected[0])['values']
            columns = self.get_table_columns(table)[1:]

            for i, col in enumerate(columns):
                self.entry_fields[table][col].delete(0, tk.END)
                self.entry_fields[table][col].insert(0, str(values[i+1]))

    def clear_entries(self, table: str):
        for entry in self.entry_fields[table].values():
            entry.delete(0, tk.END)
        for entry in self.search_entries[table].values():
            entry.delete(0, tk.END)

def main():
    root = tk.Tk()
    app = HealthcareManagementApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()
