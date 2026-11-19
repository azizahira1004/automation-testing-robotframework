Berikut adalah format `README.md` untuk project automation testing **API & Web** menggunakan **Robot Framework** yang sudah dilengkapi spesifikasi perangkat kamu serta catatan konfigurasi `${API_KEY}`:

```markdown
# API & Web Automation Testing (Robot Framework)

Automated end-to-end Web UI and REST API test suite built with **Robot Framework**, **SeleniumLibrary** (or **Browser Library**), and **RequestsLibrary**.

## Test Environment

Tests were run on the following device:

- **Device:** Lenovo Legion 5 15ITH6
- **Operating system:** Windows 11 Home Single Language, version 25H2 (64-bit)
- **Processor:** 11th Gen Intel Core i7-11800H @ 2.30 GHz
- **Memory:** 16 GB RAM
- **Graphics:** NVIDIA GeForce RTX 3050 Ti Laptop GPU (4 GB) and Intel UHD Graphics
- **Storage:** 477 GB

## Prerequisites

Ensure the following tools and packages are installed and configured:

- **Python** (3.10+) & **pip**
- **Robot Framework** (`robotframework`)
- **Web Automation Library:**
  - `robotframework-seleniumlibrary` (for Selenium-based web tests), or
  - `robotframework-browser` + **Node.js** (for Playwright-based web tests)
- **API Automation Library:** `robotframework-requests` & `robotframework-jsonlibrary`
- **Web Browser:** Google Chrome / Microsoft Edge (latest version) along with its matching WebDriver (automatically managed by Selenium Manager in Selenium 4+)

## Setup

1. **Navigate to the project directory:**
   ```powershell
   cd "D:\Automation Testing\WebAndAPI"

```

2. **Install Python dependencies:**
```powershell
pip install robotframework robotframework-seleniumlibrary robotframework-requests robotframework-jsonlibrary

```


*(Or if using a `requirements.txt` file:)*
```powershell
pip install -r requirements.txt

```


3. **Configure API Key (`${API_KEY}`):**
> **Important:** For API test execution, you must provide your own valid `${API_KEY}`. Do not hardcode sensitive keys directly into committed test files.


You can configure `${API_KEY}` using one of the following methods:
* **Option A — Pass via CLI during execution (Recommended):**
```powershell
robot -v API_KEY:your_actual_api_key_here -d results tests/api/

```


* **Option B — Configure in a local variables/config file:**
Open your variables/environment resource file (e.g., `resources/variables.robot` or `config/env.py`) and set:
```robotframework
*** Variables ***
${API_KEY}    your_actual_api_key_here

```





## Executing Tests

### 1. Run API Automation Tests

Run the API suite from the project root:

```powershell
cd "D:\Automation Testing\API & WEB"
robot --outputdir results "Tests\01_api_reqres.robot"
```

This project can run in ReqRes demo mode without `REQRES_API_KEY`. If you have an API key, set it in PowerShell before running:

```powershell
$env:REQRES_API_KEY = "your_reqres_api_key"
robot --outputdir results "Tests\01_api_reqres.robot"
```

To run one API test case only:

```powershell
robot --outputdir results --test "TC01 - Get List Users" "Tests\01_api_reqres.robot"
```

### 2. Run Web Automation Tests

* Run all web test suites (default browser):
```powershell
robot -d results tests/web/

```


* Run web tests with a specific browser variable (e.g., Chrome or Edge):
```powershell
robot -v BROWSER:chrome -d results tests/web/

```


* Run in headless mode:
```powershell
robot -v BROWSER:headlesschrome -d results tests/web/

```



### 3. Run All Tests (API & Web) or Filter by Tag

* Run the entire test suite:
```powershell
robot -v API_KEY:your_actual_api_key_here -d results tests/

```


* Run specific suites by tag (e.g., `smoke` or `regression`):
```powershell
robot -v API_KEY:your_actual_api_key_here -d results --include smoke tests/

```



## Test Reports

After test execution completes, Robot Framework generates the following artifacts inside the `results/` directory:

* `report.html` — High-level test execution summary
* `log.html` — Detailed step-by-step execution log, API request/response details, and failure screenshots
* `output.xml` — Machine-readable XML test output

```

```