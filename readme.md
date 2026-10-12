# Air Arabia DMM Announcer — direct neural TTS patch

## What changed

The earlier function relied on public endpoints. Its `edge-tts-vercel` endpoint returned HTTP 502; retrying the same failing endpoint did not restore speech. This build **attempts direct Edge Neural TTS synthesis within a Netlify Function**, using the `@travisvn/edge-tts` npm dependency, then attempts the public endpoint as a last-resort fallback. Preserves Air Arabia branding, aircraft background, Zone A/B/C announcements, enhanced playback gain and opt-in Urdu.

## Required deployment procedure (important)

**Do not deploy this ZIP with Netlify's static drag-and-drop uploader.** This version contains an npm dependency and a serverless function. Extract ZIP, commit files to a GitHub repository connected to Netlify, and let Netlify run npm install and bundle `netlify/functions/tts.js`. Alternatively, with Node.js and Netlify CLI, run `npm install`, `netlify deploy --build --prod`. Check Netlify build logs and Function logs. Do not upload a plain static folder without function bundling.

## Operational limitations

- This is a best-effort fallback, **not a guaranteed fix**. Direct Edge Neural speech still depends on a third-party online service and may fail, rate-limit or have licensing restrictions. No account-free TTS service can be promised free or reliable forever.
- The direct npm dependency version is selected at install time; pin and test a verified version before production deployment. This package has passed local JavaScript syntax checks, **not live provider synthesis or Netlify deployment**.
- No device/browser synthetic fallback has been introduced. If all voice providers fail, the app will display an error rather than silently replace premium speech.
- For operational PA, pre-generate/cache common announcements and maintain an approved backup, rather than relying on a live free endpoint.
