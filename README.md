# TechQuest
Hi Welcome to Flutter Asssigment Repository # TechQuest 
TechQuest is a flutter application that has three different tasks.This app provides simple UI and scalable project structure that goes beyond the simple counter example.

The app has basic Home Screen, Upload Files screen, Find an element in fibonacci series and Find longest balanced substring screens.

It's configured with Flutter SDK,Firebase for file upload, Navigation,File Picker,Video Player.

## Features

### Page 1: File Upload
- Allows users to select files upto 10MB and upload it on firebase.
- Supported file formats: PDF, DOCX, TXT, JPG, PNG, etc.


<p float="left">
 <img src="/images/fileupload0.png" alt="File Upload" width="200" style="margin-right: 20px;"/>
</p>
<p float="left">
 <img src="/images/fileupload1.png" alt="File Upload" width="200" style="margin-right: 20px;"/>
</p>
<p float="left">
 <img src="/images/fileupload2.png" alt="File Upload" width="200" style="margin-right: 20px;"/>
</p>
<p float="left">
 <img src="/images/fileupload3.png" alt="File Upload" width="200" style="margin-right: 20px;"/>
</p>
<p float="left">
 <img src="/images/fileupload4.png" alt="File Upload" width="200" style="margin-right: 20px;"/>
</p>
<p float="left">
 <img src="/images/fileupload5.png" alt="File Upload" width="200" style="margin-right: 20px;"/>
</p>

### Page 2: Find nth Element in Fibonacci Series
- Users can find the nth element in the Fibonacci series.
- Simply input the value of n and get the corresponding Fibonacci number.

<p float="left">
<img src="/images/fibonacci1.jpeg" alt="Fibonacci Element" width="200" style="margin-right: 20px;"/>
</p>

<p float="left">
<img src="/images/fibonacci2.png" alt="Fibonacci Element" width="200" style="margin-right: 20px;"/>
</p>

<p float="left">
<img src="/images/fibonacci3.png" alt="Fibonacci Element" width="200" style="margin-right: 20px;"/>
</p>

### Page 3: Find Longest Balanced Substring
- Users can find the longest balanced substring in a given string.
- A balanced substring is one where the number of occurances of the two characters are equal.

<p float="left">
<img src="/images/substring.png" alt="Balanced Substring" width="200"/>
</p>

## Getting Started

To run this application, you need to have Flutter installed on your system. If you haven't installed Flutter yet, you can follow the instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone this repository:

```bash
git clone [https://github.com/NaveenaVE/FlutterAssignment.git]
```

2. Navigate to the project directory:
```bash
cd techquest

3.Install dependencies:
```bash
flutter pub get

4.Running the App
To run the app, you can use an emulator/simulator or a physical device connected to your development environment.

Using an Emulator/Simulator
Start your preferred emulator/simulator.

Run the app using the following command:
```bash
flutter run]

##Navigation
The app's homepage consists of three buttons, each navigating to a specific page:

Button 1: Navigates to the File Upload page.
Button 2: Navigates to the Fibonacci Series page.
Button 3: Navigates to the Longest Balanced Substring page.

This Repository consist of three task assisged. It consist of a home screen which consits of three button each navigates to any indiviually task 

Page 1 :

We show case a UI designed and functioning in flutter where user can upload  image or video, from his/her local device or Google drive which consist of maxmium size 10MB. The upload file is successfully uploaded to firebase storage, from where user can download and interact with image or video. 

Along this while file geeting uploaded to firebase storage user can see the progress of file uploading along parallel preview, once file is uploaded or leads to error appropriate message is displayed. 

Page 2 :

Create a straight forward logic that utilizes a recursive function to determine the Fibonacci value at a specified position. Ensuring  performance at scale, allowing it to handle larger numbers without experiencing exponential slowdown. When dealing with substantial numbers where the Fibonacci value becomes excessively large, the application should display an infinity sign instead.

Page 3 :

Implement a function called getBalancedSubstrings(List S) that returns an array of the longest balanced substrings of the input string S
