# typed: false
# frozen_string_literal: true

class MacScreenSearch < Formula
  desc "macOS CLI tool to capture screenshots, perform OCR, and highlight or redact matched text"
  homepage "https://github.com/jftuga/mac-screen-search"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/mac-screen-search/releases/download/v1.1.0/mac-screen-search_v1.1.0.tar.xz"
      sha256 "67a9abfcaedc912eda0feee83cc560f6d7aca744173ab39add959fb182ff83f6"

      define_method(:install) do
        bin.install "mac-screen-search"
      end
    end
  end

  test do
    system "#{bin}/mac-screen-search -v"
  end
end