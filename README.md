# TwoScreenTestApp

### 🌟 Description

Test application for the iOS developer position. The project loads and displays a list of characters from the Rick and Morty open API, with the ability to navigate to a detailed character screen.

Supports offline mode by saving data in CoreData and displaying it when the internet connection is unavailable.

---

### 🔄 Technologies
- Swift 5
- UIKit
- Clean Architecture (based on Clean Swift)
- CoreData
- Reachability.swift for network monitoring
- Alamofire (for network requests)
- SDWebImage (for image loading)

---

### 🛠️ External Libraries

Dependencies managed via Swift Package Manager (SPM):
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
- [Reachability.swift](https://github.com/ashleymills/Reachability.swift)

---

### 📁 Installation
Follow these steps to build and run the project locally:

1. **Open the project**:
- Open `TwoScreenTestApp.xcodeproj` using Xcode (recommended version: Xcode 15+).

2. **Install dependencies**:
- The project uses Swift Package Manager (SPM) for dependency management.
- When you first open the project, Xcode will automatically start resolving Swift packages.
- If not, go to `File > Packages > Resolve Package Versions` manually.

3. **Configure the environment**:
- No additional configuration is needed.  
- The project uses the public Rick and Morty API (no API key required).

4. **Build the project**:
- Select a simulator (e.g., iPhone 15) or a real device.
- Press `Cmd + B` to build the project.
- If there are no build errors, you are ready to run.

5. **Run the project**:
- Press `Cmd + R` to launch the application on the selected device.

6. **Testing offline mode** (optional):
- Turn off internet connection on your Mac or device.
- Relaunch the app to verify that previously loaded characters are displayed from CoreData.
- You should also see a red banner indicating the lack of internet connectivity.
