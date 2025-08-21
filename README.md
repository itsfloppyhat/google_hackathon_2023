# google_hackathon_2023

This project won the 2023 Google Hackathon. 

This was a running application that allowed a user to sign up and enter their running goals and music interests. When a user goes out on a run, it would take the user's heart rate, music preferences, and running goals to suggest timely songs, whether you need a pick-me-up or something to chill you out.

Runs were then given feedback by a coach of your choice, whether you wanted Shrek or David Goggins or Yoda.

This app had a functioning python flask server connected to a Flutter application. The application would take music preferences, goals, and heart rates and submit it to the google gemini api to suggest a song and get the feedback afterwards. The songs would come from Youtube. However, there were free tier limitations, and the application did not connect to any devices that had heart rate or distance tracking. If this application was, it would be fully functioning.

The plan is to re-create this application using iOS tools and make it fully functional.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
