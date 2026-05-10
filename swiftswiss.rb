# typed: false
# frozen_string_literal: true

class Swiftswiss < Formula
  desc "Swiss army knife CLI tool written in Swift using only native Apple frameworks"
  homepage "https://github.com/jftuga/swiftswiss"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/swiftswiss/releases/download/v0.5.0/swiftswiss_v0.5.0.tar.xz"
      sha256 "97d4e9c6442729fceb65ba2c019203f276d7b90dee80972b38c979904ead7273"

      define_method(:install) do
        bin.install "swiftswiss"
      end
    end
  end

  test do
    system "#{bin}/swiftswiss -v"
  end
end