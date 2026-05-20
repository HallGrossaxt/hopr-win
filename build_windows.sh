#!/usr/bin/env bash
# ==============================================================================
# HOPR Windows build script for MSYS2/MinGW64 + gfortran
# ==============================================================================
# Prerequisites (install via MSYS2 UCRT64 pacman):
#   pacman -S --needed \
#     mingw-w64-ucrt-x86_64-gcc-fortran \
#     mingw-w64-ucrt-x86_64-cmake \
#     mingw-w64-ucrt-x86_64-ninja \
#     mingw-w64-ucrt-x86_64-hdf5 \
#     mingw-w64-ucrt-x86_64-lapack \
#     mingw-w64-ucrt-x86_64-git
#
# Usage:
#   Run this script from an MSYS2 MinGW64 terminal:
#     bash build_windows.sh [Release|Debug]
# ==============================================================================

set -e

BUILD_TYPE="${1:-Release}"
BUILD_DIR="build_windows"

echo "=== HOPR Windows Build ==="
echo "Build type : ${BUILD_TYPE}"
echo "Build dir  : ${BUILD_DIR}"
echo ""

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

cmake .. \
  -G "Ninja" \
  -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
  -DCMAKE_Fortran_COMPILER=gfortran \
  -DCMAKE_C_COMPILER=gcc \
  -DLIBS_USE_CGNS=OFF \
  -DLIBS_USE_OPENMP=ON \
  -DHOPR_BUILDTESTS=OFF \
  -DHOPR_UNITTESTS=OFF \
  -DCMAKE_EXE_LINKER_FLAGS="-Wl,--stack,268435456"

cmake --build . -j$(nproc)

echo ""
echo "=== Build complete ==="
echo "Executable: ${BUILD_DIR}/bin/hopr.exe"
