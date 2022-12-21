
# Typeahead Challenge

## Running this Project

To run this project, follow the steps below
 - Clone the repository on to your local device
 - Create your personal API key for [The Movie Database](https://github.com/adamayoung/TMDb) API
 - Open the project in Xcode and click the "+" button at the bottom of the project navigator to add a file. 
 - Scroll down to the "Other" section and create an "Empty" file. Name the file "secrets.json". 
 - Place the file in the project folder containing /Sources, /Resources, and the Info.plist. See photo below for document structure
 <img width="261" alt="Screenshot 2022-12-20 at 5 50 12 PM" src="https://user-images.githubusercontent.com/63136835/208795478-f5846f93-0095-48ce-9b3f-0bff92208cf6.png">

 - Paste in your API key into secrets.json using the following format: 
 ```
 { "api_key": "yourapikeyhere" }
 ```
  - Run the project
  - Run Unit Tests with Cmd + u
