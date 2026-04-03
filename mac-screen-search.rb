# typed: false
# frozen_string_literal: true

class MacScreenSearch < Formula
  desc "macOS CLI tool to capture screenshots, perform OCR, and highlight or redact matched text"
  homepage "https://github.com/jftuga/mac-screen-search"
  version "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/mac-screen-search/releases/download/v1.0.1/mac-screen-search_v1.0.1.tar.xz"
      sha256 "b09908700efa269f8a6f069cb1d689c7abf6c882fd2f2291dd2b820563173d00"

      define_method(:install) do
        bin.install "mac-screen-search"
      end
    end
  end

  test do
    system "#{bin}/mac-screen-search -v"
  end
end