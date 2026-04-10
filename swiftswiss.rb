# typed: false
# frozen_string_literal: true

class Swiftswiss < Formula
  desc "Swiss army knife CLI tool written in Swift using only native Apple frameworks"
  homepage "https://github.com/jftuga/swiftswiss"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/swiftswiss/releases/download/v0.4.0/swiftswiss_v0.4.0.tar.xz"
      sha256 "3831884dfab54a29c040a0ce0500255d855f047e33db9edd824a6b23c89e53c3"

      define_method(:install) do
        bin.install "swiftswiss"
      end
    end
  end

  test do
    system "#{bin}/swiftswiss -v"
  end
end