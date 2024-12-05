#!/bin/sh

set -e -x

if [ "$#" -lt 2 ]; then
  echo "Usage: ./update.sh <kargo> VERSION"
  exit 1
fi

CLI_NAME="$1"
VERSION="$2"
BREW_VERSION="$3"

if [ "${CLI_NAME}" = "kargo" ]; then
  URL_BASE="https://github.com/akuity/kargo/releases/download"
  CLASSNAME="Kargo"
  DESC="Application lifecycle orchestration"
else
  echo "Unsupported binary: ${CLI_NAME}"
  exit 1
fi

# OSX - Intel
OSX_INTEL_CLI_NAME="${CLI_NAME}-darwin-amd64"
OSX_INTEL_BINPATH="/tmp/${OSX_INTEL_CLI_NAME}"
curl --fail -L -o ${OSX_INTEL_BINPATH} -s "${URL_BASE}/${VERSION}/${OSX_INTEL_CLI_NAME}" || (echo "Failed to curl (${URL_BASE}/${VERSION}/${OSX_INTEL_CLI_NAME})" && exit 1)
OSX_INTEL_SHA256=$(shasum -a 256 "${OSX_INTEL_BINPATH}" | awk '{print $1}')

# OSX - ARM
OSX_ARM_CLI_NAME="${CLI_NAME}-darwin-arm64"
OSX_ARM_BINPATH="/tmp/${OSX_ARM_CLI_NAME}"
curl --fail -L -o ${OSX_ARM_BINPATH} -s "${URL_BASE}/${VERSION}/${OSX_ARM_CLI_NAME}" || (echo "Failed to curl (${URL_BASE}/${VERSION}/${OSX_ARM_CLI_NAME})" && exit 1)
OSX_ARM_SHA256=$(shasum -a 256 "${OSX_ARM_BINPATH}" | awk '{print $1}')

# Linux - Intel
LINUX_INTEL_CLI_NAME="${CLI_NAME}-linux-amd64"
LINUX_INTEL_BINPATH="/tmp/${LINUX_INTEL_CLI_NAME}"
curl --fail -L -o ${LINUX_INTEL_BINPATH} -s "${URL_BASE}/${VERSION}/${LINUX_INTEL_CLI_NAME}" || (echo "Failed to curl (${URL_BASE}/${VERSION}/${LINUX_INTEL_CLI_NAME})" && exit 1)
LINUX_INTEL_SHA256=$(shasum -a 256 "${LINUX_INTEL_BINPATH}" | awk '{print $1}')

# Linux - ARM
LINUX_ARM_CLI_NAME="${CLI_NAME}-linux-arm64"
LINUX_ARM_BINPATH="/tmp/${LINUX_ARM_CLI_NAME}"
curl --fail -L -o ${LINUX_ARM_BINPATH} -s "${URL_BASE}/${VERSION}/${LINUX_ARM_CLI_NAME}" || (echo "Failed to curl (${URL_BASE}/${VERSION}/${LINUX_ARM_CLI_NAME})" && exit 1)
LINUX_ARM_SHA256=$(shasum -a 256 "${LINUX_ARM_BINPATH}" | awk '{print $1}')

CLASS_POSTFIX=$(echo ${BREW_VERSION} | tr -d '.')
CLASS_POSTFIX=$(echo ${CLASS_POSTFIX} | sed "s/@/AT/g")
TEMPLATE="# This is an auto-generated file. DO NOT EDIT
class ${CLASSNAME}${CLASS_POSTFIX} < Formula
    desc \"${DESC}\"
    homepage \"https://kargo.akuity.io/\"
    version \"${VERSION}\"

    on_macos do
      if Hardware::CPU.intel?
        url \"${URL_BASE}/${VERSION}/${OSX_INTEL_CLI_NAME}\"
        sha256 \"${OSX_INTEL_SHA256}\"
      elsif Hardware::CPU.arm?
        url \"${URL_BASE}/${VERSION}/${OSX_ARM_CLI_NAME}\"
        sha256 \"${OSX_ARM_SHA256}\"
      end
    end

    on_linux do
      if Hardware::CPU.intel?
        url \"${URL_BASE}/${VERSION}/${LINUX_INTEL_CLI_NAME}\"
        sha256 \"${LINUX_INTEL_SHA256}\"
      elsif Hardware::CPU.arm?
        url \"${URL_BASE}/${VERSION}/${LINUX_ARM_CLI_NAME}\"
        sha256 \"${LINUX_ARM_SHA256}\"
      end
    end

    def install
      bin.install \"kargo-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch}\" => \"kargo\"
    end

    test do
      assert_match version.to_s, shell_output(\"#{bin}/kargo --version\")
    end
end"

echo "${TEMPLATE}" > "Formula/${CLI_NAME}${BREW_VERSION}.rb"
