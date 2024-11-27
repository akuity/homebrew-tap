class Kargo < Formula
  desc "Application lifecycle orchestration"
  homepage "https://kargo.akuity.io/"
  version "v1.0.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akuity/kargo/releases/download/#{version}/kargo-darwin-amd64"
      sha256 "131b1e0e4154a3253b4f0b39d572ddfda21ed14d0c505ee5d013f509af35479d"
    elsif Hardware::CPU.arm?
      url "https://github.com/akuity/kargo/releases/download/#{version}/kargo-darwin-arm64"
      sha256 "98fc778ab9a8a43b9f43208a9c3a47d839a699f0123a120196a31d648435404c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akuity/kargo/releases/download/#{version}/kargo-linux-amd64"
      sha256 "17ed084a0354456883a47bedb38b7bf9f4c60b93c9fd78fa52e7ab18695bf2d0"
    elsif Hardware::CPU.arm?
      url "https://github.com/akuity/kargo/releases/download/#{version}/kargo-linux-arm64"
      sha256 "c26c1024a148712f36f3d147e2d246b93792e11f3e591547dc9c177d55ac153f"
    end
  end

  def install
    bin.install "kargo-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch}" => "kargo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kargo --version")
  end
end