importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyBshv0bG_OjVnCk9P5mwW75_qTQ1SzKVmI",
  authDomain: "graduation-project-4083d.firebaseapp.com",
  projectId: "graduation-project-4083d",
  storageBucket: "graduation-project-4083d.firebasestorage.app",
  messagingSenderId: "1081497804318",
  appId: "1:1081497804318:web:eff1a961379cc6c236580f",
});
const messaging = firebase.messaging();
messaging.onBackgroundMessage((payload) => {
  console.log("Background message received:", payload);
});