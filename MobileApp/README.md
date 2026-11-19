```markdown
# Mobile App Automation Testing (Robot Framework)

Automated end-to-end mobile application test suite built with **Robot Framework** and **AppiumLibrary**.

## Test Environment

Tests were run on the following device:

- **Device:** Lenovo Legion 5 15ITH6
- **Operating system:** Windows 11 Home Single Language, version 25H2 (64-bit)
- **Processor:** 11th Gen Intel Core i7-11800H @ 2.30 GHz
- **Memory:** 16 GB RAM
- **Graphics:** NVIDIA GeForce RTX 3050 Ti Laptop GPU (4 GB) and Intel UHD Graphics
- **Storage:** 477 GB

## Prerequisites

Ensure the following tools and environment variables are installed and properly configured:

- **Python** (3.10+) & **pip**
- **Robot Framework** & **AppiumLibrary** (`robotframework-appiumlibrary`)
- **Node.js** (v22.14.0) & **npm**
- **Java Development Kit (JDK)** (JDK 11 or 17) with `JAVA_HOME` configured
- **Android Studio / Android SDK** with `ANDROID_HOME` configured and `platform-tools` added to `PATH`
- **Appium Server** (v2.x) with the **UiAutomator2** driver (`uiautomator2@8.7.3`)
- **Android Emulator** (e.g., `Pixel_API_33`) or a physical Android device with USB Debugging enabled

## Setup

1. **Navigate to the project directory:**
   ```powershell
   cd "D:\Automation Testing\MobileApp"

```

2. **Install Python dependencies:**
```powershell
pip install robotframework robotframework-appiumlibrary

```


*(Or if using a `requirements.txt` file:)*
```powershell
pip install -r requirements.txt

```


3. **Verify Appium & UiAutomator2 driver installation:**
```powershell
appium driver list --installed

```


4. **Configure application & capabilities:**
* Ensure the target `.apk` file is placed in the designated app path or update `APP_PATH` / desired capabilities inside your resource/config file.
* Verify `DEVICE_NAME` (e.g., `Pixel_API_33`) and `PLATFORM_VERSION` match your active emulator or connected device.



## Executing Tests

1. **Start the Android Emulator:**
```powershell
emulator -avd Pixel_API_33

```


Verify the device is connected and detected:
```powershell
adb devices

```


2. **Start the Appium Server** (in a separate terminal):
```powershell
appium

```


3. **Run the Robot Framework Test Suite** (in a new terminal):
* Run all test suites and save outputs to the `results/` folder:
```powershell
robot -d results tests/

```


* Run a specific test file:
```powershell
robot -d results tests/login_test.robot

```


* Run tests filtered by tag:
```powershell
robot -d results --include smoke tests/

```





## Test Reports

After test execution completes, Robot Framework automatically generates the following artifacts inside the `results/` directory:

* `report.html` — High-level test execution summary
* `log.html` — Detailed step-by-step execution log and screenshots (on failure)
* `output.xml` — Machine-readable XML test output

```

```