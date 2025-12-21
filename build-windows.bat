REM execute this script inside elevated (Run as Administrator) console "x64 Native Tools Command Prompt for VS 2022"

echo off

echo Installing chocolatey windows package manager...
SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

SET "PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin"
SET "PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"
SET "PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC\14.50.35717\bin\Hostx64\x64"


echo check msbuild exist
where msbuild
IF %ERRORLEVEL% NEQ 0 (
    echo msbuild not found
    exit /b %errorlevel%
)

echo check nmake exist
where nmake
IF %ERRORLEVEL% NEQ 0 (
    echo nmake not found
    exit /b %errorlevel%
)

if not exist "third_libs" (
    mkdir "third_libs"
)
cd third_libs

set third_libs=%cd%
echo %third_libs%

cd ..
echo Current dir %cd%

mkdir build
cd build
cmake -GNinja -DCMAKE_BUILD_TYPE=Release ^
-DPORTABLE=1 ^
-DSODIUM_USE_STATIC_LIBS=1 ^
-DSODIUM_LIBRARY_RELEASE=%third_libs%\libsodium\Build\Release\x64\libsodium.lib ^
-DSODIUM_LIBRARY_DEBUG=%third_libs%\libsodium\Build\Release\x64\libsodium.lib ^
-DSODIUM_INCLUDE_DIR=%third_libs%\libsodium\src\libsodium\include ^
-DLZ4_FOUND=1 ^
-DLZ4_INCLUDE_DIRS=%third_libs%\lz4\lib ^
-DLZ4_LIBRARIES=%third_libs%\lz4\build\VS2022\liblz4\bin\x64_Release\liblz4_static.lib ^
-DMHD_FOUND=1 ^
-DMHD_LIBRARY=%third_libs%\libmicrohttpd\w32\VS2022\Output\x64\libmicrohttpd.lib ^
-DMHD_INCLUDE_DIR=%third_libs%\libmicrohttpd\src\include ^
-DZLIB_FOUND=1 ^
-DZLIB_INCLUDE_DIR=%third_libs%\zlib ^
-DZLIB_LIBRARIES=%third_libs%\zlib\contrib\vstudio\vc14\x64\ZlibStatReleaseWithoutAsm\zlibstat.lib ^
-DOPENSSL_FOUND=1 ^
-DOPENSSL_INCLUDE_DIR=%third_libs%\openssl\include ^
-DOPENSSL_CRYPTO_LIBRARY=%third_libs%\openssl\libcrypto_static.lib ^
-DCMAKE_CXX_FLAGS="/DTD_WINDOWS=1 /EHsc /bigobj" ..

IF %errorlevel% NEQ 0 (
  echo Can't configure TON
  exit /b %errorlevel%
)

IF "%1"=="-t" (
ninja storage-daemon storage-daemon-cli blockchain-explorer fift func tolk tonlib tonlibjson  ^
tonlib-cli validator-engine lite-client validator-engine-console generate-random-id ^
json2tlo dht-server http-proxy rldp-http-proxy adnl-proxy create-state create-hardfork emulator ^
test-ed25519 test-bigint test-vm test-fift test-cells test-smartcont test-net ^
test-tdactor test-tdutils test-tonlib-offline test-adnl test-dht test-rldp test-rldp2 test-catchain ^
test-fec test-tddb test-db test-validator-session-state test-emulator proxy-liteserver
IF %errorlevel% NEQ 0 (
  echo Can't compile TON
  exit /b %errorlevel%
)
) else (
ninja storage-daemon storage-daemon-cli blockchain-explorer fift func tolk tonlib tonlibjson  ^
tonlib-cli validator-engine lite-client validator-engine-console generate-random-id ^
json2tlo dht-server http-proxy rldp-http-proxy adnl-proxy create-state create-hardfork emulator proxy-liteserver
IF %errorlevel% NEQ 0 (
  echo Can't compile TON
  exit /b %errorlevel%
)
)

copy validator-engine\validator-engine.exe test
IF %errorlevel% NEQ 0 (
  echo validator-engine.exe does not exist
  exit /b %errorlevel%
)

echo Strip and copy artifacts
cd ..
echo where strip
where strip
mkdir artifacts
mkdir artifacts\smartcont
mkdir artifacts\lib

for %%I in (build\storage\storage-daemon\storage-daemon.exe ^
  build\storage\storage-daemon\storage-daemon-cli.exe ^
  build\blockchain-explorer\blockchain-explorer.exe ^
  build\crypto\fift.exe ^
  build\crypto\tlbc.exe ^
  build\crypto\func.exe ^
  build\tolk\tolk.exe ^
  build\crypto\create-state.exe ^
  build\validator-engine-console\validator-engine-console.exe ^
  build\tonlib\tonlib-cli.exe ^
  build\tonlib\tonlibjson.dll ^
  build\http\http-proxy.exe ^
  build\rldp-http-proxy\rldp-http-proxy.exe ^
  build\dht-server\dht-server.exe ^
  build\lite-client\lite-client.exe ^
  build\validator-engine\validator-engine.exe ^
  build\utils\generate-random-id.exe ^
  build\utils\json2tlo.exe ^
  build\utils\proxy-liteserver.exe ^
  build\adnl\adnl-proxy.exe ^
  build\emulator\emulator.dll) do (
    echo strip -s %%I & copy %%I artifacts\
    strip -s %%I & copy %%I artifacts\
)

xcopy /e /k /h /i crypto\smartcont artifacts\smartcont
xcopy /e /k /h /i crypto\fift\lib artifacts\lib
