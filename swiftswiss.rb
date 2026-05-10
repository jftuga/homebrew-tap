# typed: false
# frozen_string_literal: true

class Swiftswiss < Formula
  desc "Swiss army knife CLI tool written in Swift using only native Apple frameworks"
  homepage "https://github.com/jftuga/swiftswiss"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/swiftswiss/releases/download/v0.5.1/swiftswiss_v0.5.1.tar.xz"
      sha256 "84580a074481746e5b918c105d0a2c12863789991e34f1d7589a26f776b2dc7b"

      define_method(:install) do
        bin.install "swiftswiss"
      end
    end
  end

  test do
    system "#{bin}/swiftswiss -v"
  end
end