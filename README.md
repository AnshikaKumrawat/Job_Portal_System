# 💼 Job Portal System

A full-stack **Job Portal Web Application** built using **Java (JSP + Servlets)** and **MySQL**, designed to connect job seekers with employers through a clean, role-based platform.

---

## 🚀 Features

### 👤 User (Job Seeker)
- Register & Login with secure session management
- Browse all active job listings
- Search jobs by **Title**, **Category**, and **Location**
- Filter jobs using dropdown (Location + Category)
- View detailed job description
- Apply for jobs by uploading a **Resume (PDF/DOC)**
- Edit profile (Name, Email, Password, Qualification)

### 🛡️ Admin
- Secure admin login (hardcoded credentials)
- Post new job listings (Internal & External)
- View, Edit, and Delete jobs
- View all submitted job applications
- Download applicant resumes directly

---

## 🛠️ Tech Stack

| Layer      | Technology                          |
|------------|--------------------------------------|
| Frontend   | JSP, HTML5, CSS3, Bootstrap 5, Font Awesome |
| Backend    | Java Servlets (Jakarta EE)           |
| Database   | MySQL                                |
| Connector  | MySQL JDBC Driver (`com.mysql.cj.jdbc.Driver`) |
| Server     | Apache Tomcat                        |
| Build Tool | Maven                                |

---

## 📁 Project Structure

```
Job_Portal_System/
│
├── src/main/java/
│   ├── com/dao/
│   │   ├── JobDAO.java          # Job CRUD + Search + Filter operations
│   │   └── UserDAO.java         # User Register, Login, Update
│   │
│   ├── com/dto/
│   │   ├── Jobs.java            # Job entity
│   │   ├── JobApplication.java  # Application entity
│   │   └── User.java            # User entity
│   │
│   ├── com/servlet/
│   │   ├── AddPostServlet.java      # /addJob
│   │   ├── ApplyJobServlet.java     # /ApplyJobServlet (file upload)
│   │   ├── DeleteJobServlet.java    # /delete
│   │   ├── LoginServlet.java        # /login
│   │   ├── LogoutServlet.java       # /logout
│   │   ├── RegisterServlet.java     # /add_user
│   │   ├── UpdateJobServlet.java    # /update
│   │   └── UpdateUserServlet.java   # /update_profile
│   │
│   └── com/util/
│       └── DBUtil.java          # Database connection utility
│
├── src/main/webapp/
│   ├── all_component/
│   │   ├── navbar.jsp
│   │   ├── footer.jsp
│   │   └── all_css.jsp
│   │
│   ├── img/                     # Static images (bg.svg etc.)
│   ├── resumes/                 # Uploaded resumes (auto-created)
│   │
│   ├── index.jsp                # Landing/Home page
│   ├── login.jsp                # Login page
│   ├── signup.jsp               # Registration page
│   ├── home.jsp                 # Job listings (search + browse)
│   ├── more_view.jsp            # Filter jobs by category/location
│   ├── one_view.jsp             # Single job detail view
│   ├── apply_job.jsp            # Job application form
│   ├── apply_result.jsp         # Application success/failure page
│   ├── edit_profile.jsp         # User profile edit
│   ├── admin.jsp                # Admin dashboard
│   ├── add_job.jsp              # Post new job (Admin)
│   ├── view_job.jsp             # View all jobs (Admin)
│   ├── edit_job.jsp             # Edit job (Admin)
│   └── view_applications.jsp    # View all applications (Admin)
│
└── pom.xml
```

---

## 🗄️ Database Setup

1. Create a MySQL database named `job_portal`

2. Run the following SQL to create the required tables:

```sql
CREATE DATABASE job_portal;
USE job_portal;

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    qualification VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user'
);

CREATE TABLE job (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    description TEXT,
    category VARCHAR(100),
    status VARCHAR(20),
    location VARCHAR(100),
    company VARCHAR(200),
    experience INT,
    salary DOUBLE,
    pdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    link VARCHAR(500)
);

CREATE TABLE job_applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    user_name VARCHAR(100),
    email VARCHAR(100),
    resume VARCHAR(300),
    applied_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES job(id)
);
```

---

## ⚙️ Configuration

Open `src/main/java/com/util/DBUtil.java` and update your credentials:

```java
private static final String URL      = "jdbc:mysql://localhost:3306/job_portal";
private static final String USERNAME = "your_mysql_username";
private static final String PASSWORD = "your_mysql_password";
```

---

## 🏃 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/AnshikaKumrawat/Job_Portal_System.git
   ```

2. **Import into Eclipse / IntelliJ** as a Maven project

3. **Configure the database** (see above)

4. **Add MySQL JDBC Driver** to your Tomcat's `lib` folder or include it in `pom.xml`

5. **Deploy on Apache Tomcat** (v9+ recommended)

6. **Access the application** at:
   ```
   http://localhost:8080/Job_Portal_System/
   ```

---

## 🔑 Admin Login

| Field    | Value             |
|----------|-------------------|
| Email    | `admin@gmail.com` |
| Password | `admin@121`       |

> ⚠️ It is recommended to move admin credentials to a secure config file before deploying to production.

---

## 📸 Pages Overview

| Page | Description |
|------|-------------|
| `index.jsp` | Landing page with hero section |
| `login.jsp` | Email + Password login |
| `signup.jsp` | New user registration |
| `home.jsp` | Search jobs by title, category, location |
| `more_view.jsp` | Filter jobs by dropdown |
| `one_view.jsp` | Full job details |
| `apply_job.jsp` | Apply with name, email & resume |
| `admin.jsp` | Admin dashboard |
| `view_applications.jsp` | Admin views all applications + download resumes |

---

## 📌 Key Highlights

- **Role-based access control** — Admin and User roles with session checks on every protected page
- **Internal vs External Jobs** — Admin can mark a job as external and add an apply link
- **Resume Upload** — Stored server-side in `/resumes/` with unique timestamped filenames
- **Dynamic Search** — Title, category, location filters combined using dynamic SQL
- **Responsive UI** — Bootstrap 5 with custom CSS for clean, modern design

