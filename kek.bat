cd cmake-build-release

SET "PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC\14.50.35717\bin\Hostx64\x64"

LIB.EXE /OUT:emulator.lib ^
emulator/emulator.lib ^
emulator/emulator_static.lib ^
crypto/fift.lib ^
crypto/smc-envelope.lib ^
crypto/src_parser.lib ^
crypto/ton_block.lib ^
crypto/ton_crypto_core.lib ^
crypto/ton_crypto.lib ^
git.lib ^
tdactor/tdactor.lib ^
tddb/tddb_utils.lib ^
tdutils/tdutils.lib ^
C:\Users\danda\source\ton\ton-acton\third_libs\lz4\build\VS2022\liblz4\bin\x64_Release\liblz4_static.lib ^
C:\Users\danda\source\ton\ton-acton\third_libs\libmicrohttpd\w32\VS2022\Output\x64\libmicrohttpd.lib ^
C:\Users\danda\source\ton\ton-acton\third_libs\zlib\contrib\vstudio\vc14\x64\ZlibStatReleaseWithoutAsm\zlibstat.lib ^
third-party\abseil-cpp\absl\base\absl_raw_logging_internal.lib ^
third-party\abseil-cpp\absl\base\absl_base.lib ^
third-party\abseil-cpp\absl\base\absl_throw_delegate.lib ^
third-party\abseil-cpp\absl\debugging\absl_debugging_internal.lib ^
third-party\abseil-cpp\absl\strings\absl_cordz_functions.lib ^
third-party\abseil-cpp\absl\debugging\absl_decode_rust_punycode.lib ^
third-party\abseil-cpp\absl\numeric\absl_int128.lib ^
third-party\abseil-cpp\absl\strings\absl_strings_internal.lib ^
third-party\abseil-cpp\absl\crc\absl_crc_cpu_detect.lib ^
third-party\abseil-cpp\absl\base\absl_malloc_internal.lib ^
third-party\abseil-cpp\absl\base\absl_tracing_internal.lib ^
third-party\abseil-cpp\absl\hash\absl_city.lib ^
third-party\abseil-cpp\absl\strings\absl_string_view.lib ^
third-party\abseil-cpp\absl\debugging\absl_demangle_rust.lib ^
third-party\abseil-cpp\absl\crc\absl_crc_internal.lib ^
third-party\abseil-cpp\absl\debugging\absl_stacktrace.lib ^
third-party\abseil-cpp\absl\synchronization\absl_graphcycles_internal.lib ^
third-party\abseil-cpp\absl\strings\absl_strings.lib ^
third-party\abseil-cpp\absl\debugging\absl_demangle_internal.lib ^
third-party\abseil-cpp\absl\strings\absl_str_format_internal.lib ^
third-party\abseil-cpp\absl\time\absl_time.lib ^
third-party\abseil-cpp\absl\hash\absl_hash.lib ^
third-party\abseil-cpp\absl\debugging\absl_symbolize.lib ^
third-party\abseil-cpp\absl\crc\absl_crc32c.lib ^
third-party\abseil-cpp\absl\synchronization\absl_kernel_timeout_internal.lib ^
third-party\abseil-cpp\absl\crc\absl_crc_cord_state.lib ^
third-party\abseil-cpp\absl\synchronization\absl_synchronization.lib ^
third-party\abseil-cpp\absl\strings\absl_cord_internal.lib ^
third-party\abseil-cpp\absl\strings\absl_cordz_handle.lib ^
third-party\abseil-cpp\absl\container\absl_hashtablez_sampler.lib ^
third-party\abseil-cpp\absl\strings\absl_cordz_info.lib ^
third-party\abseil-cpp\absl\strings\absl_cord.lib ^
third-party\abseil-cpp\absl\strings\absl_cord.lib ^
third-party\abseil-cpp\absl\container\absl_raw_hash_set.lib ^
third-party\abseil-cpp\absl\base\absl_log_severity.lib ^
third-party\abseil-cpp\absl\base\absl_spinlock_wait.lib ^
third-party\abseil-cpp\absl\debugging\absl_utf8_for_code_point.lib ^
third-party\abseil-cpp\absl\time\absl_civil_time.lib ^
third-party\abseil-cpp\absl\time\absl_time_zone.lib ^
third-party\abseil-cpp\absl\profiling\absl_exponential_biased.lib ^
third-party\wingetopt\wingetopt.lib ^
third-party\crc32c\crc32c.lib ^
third-party\blst\blst.lib ^
C:\Users\danda\source\ton\ton-acton\third-party\secp256k1\build\src\Release\libsecp256k1.lib ^
tl/tl_api.lib ^
C:\Users\danda\source\ton\ton-acton\third_libs\openssl\libcrypto_static.lib ^
C:\Users\danda\source\ton\ton-acton\third_libs\libsodium\bin\x64\Release\v145\static\libsodium.lib

@REM move emulator.lib C:\Users\danda\source\ton\acton\objs