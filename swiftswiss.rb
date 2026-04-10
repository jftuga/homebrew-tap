# typed: false
# frozen_string_literal: true

class Swiftswiss < Formula
  desc "Swiss army knife CLI tool written in Swift using only native Apple frameworks"
  homepage "https://github.com/jftuga/swiftswiss"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/swiftswiss/releases/download/v0.3.0/swiftswiss_v0.3.0.tar.xz"
      sha256 "8e1d35503a072d66fb81c2de55549f62afd024f7d54b6c646bd772536ff7f596"

      define_method(:install) do
        bin.install "swiftswiss"
      end
    end
  end

  test do
    system "#{bin}/swiftswiss -v"
  end
end