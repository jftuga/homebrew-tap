# typed: true
# frozen_string_literal: true

# Homebrew formula for the shotshifter command-line tool.
class Shotshifter < Formula
  desc "Shift the time axis of dashboard screenshots to another time zone"
  homepage "https://github.com/jftuga/shotshifter"
  url "https://github.com/jftuga/shotshifter/releases/download/v0.2.1/shotshifter_v0.2.1.tar.xz"
  sha256 "843e767b10d20a2d70a89323d677ced7d5a501fa4646d37bac1095f34c52eb9b"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    bin.install "shotshifter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shotshifter --version")
  end
end
