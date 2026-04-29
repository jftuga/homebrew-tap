# typed: false
# frozen_string_literal: true

class MacScreenSearch < Formula
  desc "macOS CLI tool to capture screenshots, perform OCR, and highlight or redact matched text"
  homepage "https://github.com/jftuga/mac-screen-search"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/mac-screen-search/releases/download/v1.3.0/mac-screen-search_v1.3.0.tar.xz"
      sha256 "d1cc96e6fdc3aec97e4245305d103b154355763a1d989ef250f755d3fd08b801"

      define_method(:install) do
        bin.install "mac-screen-search"
      end
    end
  end

  test do
    system "#{bin}/mac-screen-search -v"
  end
end