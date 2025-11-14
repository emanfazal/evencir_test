




# Evencir Test – Flutter Interview Assignment


##  Features Implemented

### ✔️ Home Screen (Nutrition Tab)
- Dynamic week selection  
- Calendar bottom sheet  
- Day selector strip (Mon–Sun)  
- Workout cards  
- Animated insights (Calories, Weight, Hydration)  
- Dynamic weather icon (changes based on time – Sun/Moon)

###  Plan Screen (Training Calendar)
- Fully custom drag-and-drop weekly planner  
- Week view with Monday–Sunday layout  
- Custom appointment cards (workouts)  
- Move workouts between days  
- Weekly minutes summary  
- Pixel-perfect UI based on Figma design  

###  Mood Screen
- Gradient background similar to Figma  
- Static gradient mood ring  
- SleekCircularSlider used only for knob (dot)  
- Changing mood emoji based on slider  
- Mood label updates dynamically  

###  App Structure / Architecture
- Modular file organization  
- Fully GetX state management  
- Custom widgets for reusability  
- Calendar bottom sheet integration  
- Clean UI + UX with animations and styling  

---

##  Dependencies Used

### **1. GetX**
```

get: ^4.6.6

```
State management, route handling, and dependency injection.

### **2. intl**
```

intl: ^0.19.0

```
Used for date formatting (week labels, day names, etc.).

### **3. sleek_circular_slider**
```

sleek_circular_slider: ^2.0.1

```
Used for mood slider knob movement.

### **4. syncfusion_flutter_calendar**
```

syncfusion_flutter_calendar: ^31.2.10

```
Used for drag-and-drop event handling (Plan screen).

### **5. calendar_view**
```

calendar_view: ^1.0.5

```
Used for calendar UI on the Home screen bottom sheet.

---

##  Project Folder Structure

```

lib/
├── core/
│    ├── Widgets/
│    ├── utils/
│    └── theme/
├── features/
│    ├── home/
│    │    ├── HomeView.dart
│    │    └── HomeController.dart
│    ├── plan/
│    │    ├── PlanView.dart
│    │    └── PlanController.dart
│    ├── mood/
│    │    ├── MoodView.dart
│    │    └── MoodController.dart
├── main.dart

```

### **Explanation**
- **core/** – Shared widgets (cards, headers, bottom nav), colors & styling  
- **features/** – Each screen has its own MVC module  
- **controllers/** – GetX logic  
- **views/** – UI screens  
- **utils/** – App-wide helpers, colors, constants  

---

##  Screenshots

> Add your screenshots inside a `screenshots/` folder and link them here:

```

![Home Screen](Screenshots/Home.jpg)
![Home Screen](Screenshots/Home1.jpg)
![Plan Screen](Screenshots/Plan.jpg)
![Mood Screen](Screenshots/Mood.jpg)
![Mood Screen](Screenshots/MoodContent.jpg)
![Mood Screen](Screenshots/MoodHappy.jpg)
![Mood Screen](Screenshots/MoodPeaceful.jpg)

```

---

##  App Demo Video


```

[Watch Demo Video](https://drive.google.com/file/d/1Hzj7A1QUQ_EavVZzCL83svaiIYzqqh-H/view?usp=drivesdk)

```

---

##  APK Download


```

[Download APK](https://github.com/emanfazal/evencir_test/releases/download/app-release.apk)

```

---




