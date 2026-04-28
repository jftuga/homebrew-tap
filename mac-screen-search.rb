# typed: false
# frozen_string_literal: true

class MacScreenSearch < Formula
  desc "macOS CLI tool to capture screenshots, perform OCR, and highlight or redact matched text"
  homepage "https://github.com/jftuga/mac-screen-search"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/mac-screen-search/releases/download/v1.2.0/mac-screen-search_v1.2.0.tar.xz"
      sha256 "41edaf291ebbbe679ccbfc0dba66d0c592dc6d628a4f47391c475883854dfa76"

      define_method(:install) do
        bin.install "mac-screen-search"
      end
    end
  end

  test do
    system "#{bin}/mac-screen-search -v"
  end
end