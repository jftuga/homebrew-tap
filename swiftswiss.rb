# typed: false
# frozen_string_literal: true

class Swiftswiss < Formula
  desc "Swiss army knife CLI tool written in Swift using only native Apple frameworks"
  homepage "https://github.com/jftuga/swiftswiss"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/swiftswiss/releases/download/v0.2.1/swiftswiss_v0.2.1.tar.xz"
      sha256 "50f84fc76d8a7220b83797f082688083cb8ef845c6c3557e9fd03bdb30a496ac"

      define_method(:install) do
        bin.install "swiftswiss"
      end
    end
  end

  test do
    system "#{bin}/swiftswiss -v"
  end
end