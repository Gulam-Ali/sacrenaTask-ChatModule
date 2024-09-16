# Sacrena Coding Test - Chat Screen Implementation

## Overview

Welcome to my submission for the Sacrena iOS Developer position. This project implements a real-time chat screen using the **GetStream** API, following the design provided in the **Figma** file. The project showcases a seamless chat experience between Alice (using the app) and Bob (using the web), with a focus on performance, usability, and responsiveness.

## Features

- **Real-time Messaging**: Powered by **GetStream**, enabling instant message exchange between users.
- **Cross-platform Interaction**: Depicts a scenario where Alice uses the mobile app and Bob communicates via a web client.
- **Responsive UI**: Chat screen closely follows the provided **Figma** design and is fully responsive across devices.
- **MVVM Architecture**: Follows the **MVVM** architecture pattern for clean, maintainable, and testable code.
- **Future Enhancements**: Easily extendable to support features like sending attachments and applying custom fonts.

## Setup Instructions

### Prerequisites

- **Xcode** (for iOS) or **Android Studio** (for Android) to build the app.
- A free **GetStream** account for the chat functionality. Sign up [here](https://getstream.io).

### Steps to Run

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/sacrena-chat-app.git
    ```

2. Install SPM dependencies:

3. Add your **GetStream API key**:
    - In the project, locate the `constant.swift` file and replace with your API key:
      ```swift
      let apiKey = 'YOUR_API_KEY';
      ```

4. Build and run the app:
    - **iOS**: Open in **Xcode** and run.

### Testing Bob's Web Interface

1. Download the HTML code for Bob's web chat provided by Sacrena.
2. Set up Bob’s user details and API key in the HTML file, then open it in a browser.
3. Once the page loads, Bob will send a message to Alice. You can see this reflected in the console logs and within the app.

## Demo

You can view a quick demo of the chat functionality in action, showcasing:
- **Bob (web)** sending messages to **Alice (mobile)**
- **Mobile-to-mobile** interactions

**[Demo Video](https://filetransfer.io/data-package/yJNyn9rH#link)**

## Tech Stack

- **GetStream**: For real-time messaging.
- **MVVM Architecture**: Ensures clean, maintainable code.
- **HTML, CSS, JavaScript**: Used for Bob’s web chat interface.
- **Figma**: For design reference.


