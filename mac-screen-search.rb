# typed: false
# frozen_string_literal: true

class MacScreenSearch < Formula
  desc "macOS CLI tool to capture screenshots, perform OCR, and highlight or redact matched text"
  homepage "https://github.com/jftuga/mac-screen-search"
  version "1.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/mac-screen-search/releases/download/v1.4.0/mac-screen-search_v1.4.0.tar.xz"
      sha256 "19022c133d41b8452d015201128479f7a5a60963f99c2b42108a586a4897d7f9"

      define_method(:install) do
        bin.install "mac-screen-search"
      end
    end
  end

  test do
    system "#{bin}/mac-screen-search -v"
  end
end