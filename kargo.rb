class Kargo < Formula
  desc "Application lifecycle orchestration"
  homepage "https://kargo.akuity.io/"
  version "v1.0.3"

  if OS.mac?
    kernel = "darwin"
    sha256 "131b1e0e4154a3253b4f0b39d572ddfda21ed14d0c505ee5d013f509af35479d"
  elsif OS.linux?
    kernel = "linux"
    sha256 "17ed084a0354456883a47bedb38b7bf9f4c60b93c9fd78fa52e7ab18695bf2d0"
  end

  url "https://github.com/akuity/kargo/releases/download/#{version}/kargo-#{kernel}-amd64"

  def install
    bin_name = "kargo-#{OS.kernel_name.downcase}-amd64"
    bin.install bin_name
    mv bin/bin_name, bin/"kargo"
  end

  test do
    system "#{bin}/kargo", "--version"
  end
end