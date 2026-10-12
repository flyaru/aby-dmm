AIR ARABIA DMM - FULL NETLIFY PACKAGE (TTS FUNCTION INCLUDED)

PROBLEM: 'Function not found' / HTTP 404 indicates your Netlify Function has NOT been deployed.

THIS ZIP CANNOT FIX THAT BY DRAGGING IT INTO THE EXISTING NETLIFY SITE'S DEPLOY DROPZONE.
Dragging static files into an existing site does not install the TTS function and its Node.js dependency.

QUICKEST WINDOWS SOLUTION WITHOUT GITHUB:
1) Extract ALL files from this ZIP to a normal folder. Do not run inside the ZIP.
2) Install Node.js version 20+ from https://nodejs.org/ if not already installed.
3) Double-click DEPLOY_ON_WINDOWS.bat. Allow Netlify authorization in the browser.
4) Confirm it links to existing 'aby-dmm' site; approve production deployment.
5) Visit https://aby-dmm.netlify.app/.netlify/functions/tts
   Expected JSON: 'status': 'function_deployed'. If it returns 404, function was not published.
6) Visit https://aby-dmm.netlify.app/ and test one short English announcement.

This deploys WEBSITE + FUNCTION together via Netlify CLI; you do NOT need GitHub.

ALTERNATIVE IN POWERSHELL (RUN FROM EXTRACTED FOLDER):
  npm install
  npx --yes netlify-cli@latest login
  npx --yes netlify-cli@latest link --name aby-dmm
  npx --yes netlify-cli@latest deploy --prod --dir=public --functions=netlify/functions --skip-functions-cache

WHAT IS INCLUDED:
 public/          your Air Arabia branded HD-background PWA, zones A/B/C, opt-in Urdu
 netlify/functions/tts.js  audio generation function
 package.json     Edge TTS Node library
 netlify.toml     deployment settings
 DEPLOY_ON_WINDOWS.bat   Windows deployment helper

LIMITATIONS:
 - Function deployment resolves missing-function 404 only; live TTS may still fail with HTTP 502/503 from external provider.
 - The free upstream neural-voice service has no guaranteed uptime or commercial-use rights.
 - No actual Netlify account deployment or live synthesis was executed when this package was created.
 - Verify license/usage permissions and retain backup PA procedures before operational use.
