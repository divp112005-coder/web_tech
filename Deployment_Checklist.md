# 🚀 InfinityFree Deployment Checklist & Best Practices

Congratulations on finishing your local development! Deploying a PHP/MySQL application from a Windows local environment (XAMPP/WAMP) to a live Linux server (InfinityFree) involves a few critical steps. 

Please follow this checklist to ensure a smooth deployment.

## 1. 📂 File Name Case-Sensitivity (CRITICAL)
**Windows** is case-insensitive, meaning `Login.php` and `login.php` are treated as the same file. 
**Linux** (InfinityFree's OS) is strictly **case-sensitive**. This is the #1 cause of "404 Not Found" errors after deployment.

> [!CAUTION]
> If your AngularJS router or HTML expects `views/login.html` but the file is named `views/Login.html`, it will work locally on Windows but will break on InfinityFree!

- [ ] **Check all HTML paths**: Ensure `templateUrl: "views/login.html"` exactly matches the case of the file in your `views` folder.
- [ ] **Check all API inclusions**: Ensure `$http.post('api/login.php')` precisely matches the casing of your PHP scripts.
- [ ] **Rename files to lowercase**: The best practice is to make ALL your file names lowercase (e.g., `login.php`, `register.html`, `app.js`) to completely avoid this issue.

## 2. 🗄️ Database Setup on InfinityFree
You cannot use `localhost` or `root` casually on InfinityFree. You must set up a fresh database.

- [ ] **Create Database**: Go to your InfinityFree Control Panel (vPanel) and find **MySQL Databases**. Create a new database.
- [ ] **Gather Credentials**: Note down the following from the vPanel:
  - MySQL Hostname (e.g., `sql123.epizy.com`)
  - MySQL Username (e.g., `epiz_12345678`)
  - MySQL Database Name (e.g., `epiz_12345678_food_db`)
  - Your vPanel password (used as the database password).
- [ ] **Update `api/db_connect.php`**: I have already structured your `db_connect.php` template. You just need to paste these new credentials where indicated.
- [ ] **Import Database**: In InfinityFree vPanel, open **phpMyAdmin**. Select your new database and use the `Import` tab to upload your modified `database.sql` file.

## 3. 🛡️ API and Security Adjustments
- [ ] **Error Handling**: The `db_connect.php` has been updated to return a generic JSON error instead of raw SQL errors, which prevents leaking system paths on a live server.
- [ ] **Relative Paths**: Your `app.js` is already using relative paths (`api/login.php` rather than `http://localhost/api/login.php`), which means they will work out-of-the-box on your new domain!
- [ ] **Data Sanitization**: `register.php` is now equipped with `trim()` and `filter_var()` for email validation.

## 4. 📤 Uploading via FTP / File Manager
- [ ] **Select Files**: Select all files inside your `web_tech` folder (but not the folder itself).
- [ ] **Upload to `htdocs`**: Using InfinityFree's Online File Manager or FileZilla (FTP), navigate to the `htdocs` folder. Delete any default files there (like `index2.html`), and upload your files directly into `htdocs`.

## 5. ✅ Final verification
- [ ] Check if the site loads without white screens.
- [ ] Try creating an account to verify DB writing works.
- [ ] Test the AngularJS alert validation and order flow.

> [!TIP]
> If you encounter an unexpected API issue or white screen, check the browser's Developer Console (F12) -> Network tab to inspect the exact responses coming from your PHP files. The global `$exceptionHandler` added to `app.js` will catch `[$http:baddata]` parse errors and display a friendly alert.
