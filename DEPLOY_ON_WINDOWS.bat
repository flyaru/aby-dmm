@echo off
setlocal
cd /d "%~dp0"
title Air Arabia DMM - Deploy website + TTS function to Netlify
color 0F
echo.
echo ================================================================
echo   AIR ARABIA DMM - WEBSITE + SPEECH FUNCTION DEPLOYMENT
echo ================================================================
echo.
echo This updates EXISTING Netlify site: aby-dmm
echo Website: https://aby-dmm.netlify.app
echo.
echo This process uses Netlify CLI, NOT website drag-and-drop.
echo You will need internet access and your Netlify account login.
echo.
where node >nul 2>&1
if errorlevel 1 (
  echo ERROR: Node.js is required. Install Node.js LTS from https://nodejs.org/
  echo Then re-open DEPLOY_ON_WINDOWS.bat
  goto fail
)
node -e "process.exit(Number(process.versions.node.split('.')[0])>=20?0:1)"
if errorlevel 1 (
  echo ERROR: Node.js 20 or newer is required. Install a current Node.js LTS.
  goto fail
)
where npm >nul 2>&1
if errorlevel 1 (
  echo ERROR: npm is required and must be available on PATH.
  goto fail
)
if not exist "public\index.html" goto missing
if not exist "netlify\functions\tts.js" goto missing
if not exist "netlify.toml" goto missing
if not exist "package.json" goto missing

echo [1/4] Installing the speech dependency...
call npm install --no-audit --no-fund
if errorlevel 1 goto fail

echo.
echo [2/4] Opening Netlify authorization if necessary...
call npx --yes netlify-cli@latest login
if errorlevel 1 goto fail

echo.
echo [3/4] Linking to YOUR EXISTING Netlify project aby-dmm...
call npx --yes netlify-cli@latest link --name aby-dmm
if errorlevel 1 goto fail

echo.
echo [4/4] Deploying website and Netlify Function together...
echo This is a PRODUCTION deploy to https://aby-dmm.netlify.app
choice /C YN /M "Continue production deploy"
if errorlevel 2 goto cancel
call npx --yes netlify-cli@latest deploy --prod --dir=public --functions=netlify/functions --skip-functions-cache
if errorlevel 1 goto fail

echo.
echo SUCCESS: Netlify reported a completed deployment.
echo VERIFY DEPLOYMENT: open the following URL in your browser:
echo https://aby-dmm.netlify.app/.netlify/functions/tts
echo Expected: JSON with "status":"function_deployed"
echo This only verifies installation; TTS voice-provider availability must be tested separately.
start "" "https://aby-dmm.netlify.app/.netlify/functions/tts"
echo.
pause
exit /b 0
:missing
echo ERROR: Required file missing; fully extract ZIP first.
goto fail
:cancel
echo Cancelled; live website unchanged.
pause
exit /b 1
:fail
echo.
echo Deployment not confirmed. DO NOT assume the live site was updated.
echo Read the error above. Contact support with the displayed message (omit secrets).
pause
exit /b 1
