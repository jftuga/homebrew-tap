# typed: false
# frozen_string_literal: true

class SwiftSwiss < Formula
  desc "Swiss army knife CLI tool written in Swift using only native Apple frameworks"
  homepage "https://github.com/jftuga/swiftswiss"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/swiftswiss/releases/download/v0.2.0/swiftswiss_v0.2.0.tar.xz"
      sha256 "04fa12f8c19db725849c7e3ca4427f8eb73d08709d36ca064ef8a8e1c9754251"

      define_method(:install) do
        bin.install "swiftswiss"
      end
    end
  end

  test do
    system "#{bin}/swiftswiss -v"
  end
end