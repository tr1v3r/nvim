#!/usr/bin/env bash
set -euo pipefail

version="0.26.11"
archive="${RUNNER_TEMP:-/tmp}/tree-sitter-cli-linux-x64.zip"
install_dir="${HOME}/.local/bin"

mkdir -p "${install_dir}"
curl --fail --location --retry 3 \
	"https://github.com/tree-sitter/tree-sitter/releases/download/v${version}/tree-sitter-cli-linux-x64.zip" \
	--output "${archive}"

echo "ff1b7f9863f2faafd78dc0e66d902ee85b37f709b314b22c009f51caf233eebd  ${archive}" | sha256sum --check -
unzip -q -o "${archive}" -d "${install_dir}"
chmod +x "${install_dir}/tree-sitter"

if [[ -n "${GITHUB_PATH:-}" ]]; then
	echo "${install_dir}" >> "${GITHUB_PATH}"
fi

"${install_dir}/tree-sitter" --version
