# 🦷 Sunrise Dental Clinic — Appointment Management System

![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=java)
![Maven](https://img.shields.io/badge/Maven-3.9-red?style=flat-square&logo=apachemaven)
![MySQL](https://img.shields.io/badge/MySQL-9.0-blue?style=flat-square&logo=mysql)
![Tomcat](https://img.shields.io/badge/Tomcat-11-yellow?style=flat-square&logo=apachetomcat)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-green?style=flat-square&logo=githubactions)
![License](https://img.shields.io/badge/License-Academic-purple?style=flat-square)

A full-stack Java web application for managing patient appointments, billing, and staff authentication at Sunrise Dental Clinic, Colombo.

---

## 📋 Features

| Feature | Description |
|---|---|
| 🔐 **User Authentication** | Secure login/logout with session management and role-based access control |
| 📅 **Register Appointment** | Store patient details including NIC number, dentist, treatment, date & time |
| 🔍 **Search by Appointment No.** | Look up any appointment by appointment number |
| 🪪 **Search by NIC Number** | Retrieve full appointment history by patient NIC number |
| 📋 **Appointment History Panel** | Real-time list of all appointments on the search page |
| 🧾 **Calculate & Print Bill** | Auto-calculate treatment cost + consultation fee with printable invoice |
| 👥 **Manage Staff** (Admin only) | Add, view, and delete staff accounts with role assignment |
| ❓ **Help Section** | Step-by-step guide for clinic staff |
| 🚪 **Exit / Logout** | Secure session termination |

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│     JSP Pages (login, register,         │
│     search, bill, dashboard, help)      │
└──────────────────┬──────────────────────┘
                   │ HTTP
┌──────────────────▼──────────────────────┐
│           Controller Layer              │
│   Java Servlets (Login, Appointment,    │
│   Search, Bill, ManageStaff, Logout)    │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│           Service Layer                 │
│   AppointmentService, BillingService,   │
│   BillingStrategy, BillingStrategyFactory│
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│           Data Access Layer             │
│   AppointmentDAO, UserDAO, BillDAO,     │
│   DBConnection (Singleton)              │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│           MySQL Database                │
│   users | appointments | bills          │
└─────────────────────────────────────────┘
```

---

## 🎨 Design Patterns

| Pattern | Class | Purpose |
|---|---|---|
| **Singleton** | `DBConnection` | Single database connection instance |
| **DAO** | `AppointmentDAO`, `UserDAO`, `BillDAO` | Separated data access logic |
| **Strategy** | `BillingStrategy` + implementations | Pluggable billing algorithms |
| **Factory** | `BillingStrategyFactory` | Centralized strategy object creation |

---

## 🗄️ Database Schema

```sql
sunrise_dental
├── users          (id, username, password, role)
├── appointments   (id, appointment_number, patient_name, address,
│                   contact_number, nic_number, dentist_name,
│                   treatment_type, appointment_date, appointment_time)
└── bills          (id, appointment_number, patient_name,
                    treatment_type, consultation_fee,
                    treatment_cost, total_cost, payment_status)
```

---

## 💰 Billing Rates

| Treatment | Cost (LKR) |
|---|---|
| Teeth Cleaning | 5,000 |
| Dental Filling | 8,000 |
| Tooth Extraction | 12,000 |
| Consultation Fee | 2,000 (all visits) |

---

## 🛠️ Technology Stack

- **Language:** Java 17
- **Framework:** Jakarta Servlet API 6.0 (MVC)
- **Views:** JSP + HTML + CSS (Glassmorphism UI)
- **Database:** MySQL 9.0
- **Build Tool:** Apache Maven 3.9
- **Server:** Apache Tomcat 11
- **Testing:** JUnit 4.13.2 (14 unit tests)
- **CI/CD:** GitHub Actions

---

## 🚀 How to Run

### Prerequisites
- Java 17+
- Maven 3.9+
- MySQL 9.0+
- Apache Tomcat 11

### Step 1 — Set up the database
```bash
mysql -u root -p < sunrise-dental/src/main/resources/schema.sql
```

### Step 2 — Build the WAR
```bash
cd sunrise-dental
mvn clean package -DskipTests
```

### Step 3 — Deploy to Tomcat
```bash
cp target/sunrise-dental.war $CATALINA_HOME/webapps/
```

### Step 4 — Start Tomcat
```bash
brew services start tomcat
```

### Step 5 — Open Browser
```
http://localhost:8080/sunrise-dental/
```

### Login Credentials
```
Staff Login:
  Username: staff
  Password: staffpassword

Admin Login:
  Username: admin
  Password: adminpassword
```

---

## 🧪 Running Tests

```bash
cd sunrise-dental
mvn clean test
```

**14 unit tests across 3 test classes — all passing ✅**

| Test Class | Tests | Covers |
|---|---|---|
| `AppointmentValidationTest` | 2 | Contact number validation |
| `BillingCalculationTest` | 4 | Treatment cost & total calculation |
| `BillingStrategyFactoryTest` | 8 | Strategy resolution & edge cases |

---

## 🔄 CI/CD Pipeline

GitHub Actions automatically runs on every push and pull request:

1. ✅ Checkout code
2. ✅ Set up JDK 17 (Temurin)
3. ✅ Start MySQL 9.0 service container
4. ✅ Initialise database schema
5. ✅ Run `mvn clean test` (14 JUnit tests)
6. ✅ Report pass/fail to GitHub

---

## 📁 Project Structure

```
sunrise-dental/
├── src/main/java/com/sunrisedental/
│   ├── controller/     # Servlets (Login, Logout, Appointment, Search, Bill, ManageStaff)
│   ├── dao/            # Data Access Objects + DBConnection
│   ├── model/          # POJOs (Appointment, Bill, User)
│   └── service/        # Business logic + Billing strategies
├── src/main/resources/
│   └── schema.sql      # MySQL database schema
├── src/main/webapp/
│   ├── css/styles.css  # Global UI styles
│   ├── WEB-INF/web.xml # Servlet mappings
│   └── *.jsp           # View pages
├── src/test/java/      # JUnit test classes
└── pom.xml             # Maven dependencies
```

---

## 📚 Academic Context

This project was developed as part of the **CIS6003 Advanced Programming** module assessment at **ICBT Campus** (Cardiff Metropolitan University).

**Module:** CIS6003 Advanced Programming  
**Assessment:** WRIT1 — Sunrise Dental Clinic System  
**Academic Year:** 2026

---

*Built with ☕ Java | 🗄️ MySQL | 🐱 Apache Tomcat*
