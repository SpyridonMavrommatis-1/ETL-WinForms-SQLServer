# Debtors ETL & WinForms Project

This repository contains two main exercises (steps) of the project.

---

## 📌 Step A – ETL with SSIS

### Description

Implementation of a small-scale **ETL (Extract – Transform – Load)** process.  
The goal was to extract data from 5 text files, transform them to match the schema, and load them into SQL Server.

### Steps

**Step 1 – Install SQL Server 2022 Express**

- Solved logical/physical sector size issue by adding `ForcedPhysicalSectorSizeInBytes = 4095` in registry.
- Verified installation with `sqlcmd` and `SELECT @@VERSION;`.

**Step 2 – Install Visual Studio 2022 Community**

- Used full IDE for SSIS projects and C# development.

**Step 3 – Install SQL Server Management Studio (SSMS)**

- Connected with `localhost\SQLEXPRESS` using Windows Authentication.
- Solved TLS issue by enabling **Trust Server Certificate**.

**Step 4 – Database Design (DebtorsDB)**

- Created **DebtorsDB** with NVARCHAR fields for Unicode support.
- Initially added Foreign Keys and UNIQUE constraints, later removed to allow realistic data re-use.
- Ensured integrity through SSIS flow logic and Precedence Constraints.

**Step 5 – SSIS Package (ETL Flow)**

- 5 Data Flow Tasks created:

  1. Load Cases
  2. Load Payments (linked to Cases)
  3. Load Persons
  4. Load Phones
  5. Load Relations (Cases ↔ Persons)

- Execution finished successfully with all tasks green (✔).

**Folder Structure**

- `SSIS_Package`: Integration Services project files (`.dtproj`, `Package.dtsx`, etc.).
- `Database_Scripts`: SQL scripts (create tables, drop, verification queries).

---

## 📌 Step B – WinForms Application

### 1) Unzip Files

C# WinForms application that extracts the `Files.zip` archive using the **DotNetZip (Ionic.Zip.dll)** library.

**Functionality**

- By pressing the **Unzip** button in `Form1`, the program extracts the password-protected archive into a predefined folder.
- On success: shows message _"Το unzip ολοκληρώθηκε επιτυχώς!"_.
- On error: displays an error message.

**Configuration paths**

- Input: `C:\Users\<USERNAME>\Downloads\SoftwareDeveloperExercise\Files.zip`
- Output: `C:\Users\<USERNAME>\Downloads\SoftwareDeveloperExercise\ExtractedFiles`
- Password: `FirstCall13`

---

### 2) Run SSIS Package

- Added a second button **runSSIS** in the form.
- On click, it runs a process calling Microsoft’s `dtexec` tool.
- Executes the SSIS package created in Step A.
- Waits for process completion and shows results (success, warnings, or errors) in a message box.

---

## 📌 Summary

✅ Step A: Completed (SQL Server/SSIS ETL)  
✅ Step B.1: Completed (Unzip functionality)  
✅ Step B.2: Completed (Run SSIS)
