# typed: true
# frozen_string_literal: true

# Homebrew formula for the audiorec command-line recorder.
class MacAudioRecorder < Formula
  desc "Record macOS system audio and microphone to separate tracks"
  homepage "https://github.com/jftuga/mac-audio-recorder"
  url "https://github.com/jftuga/mac-audio-recorder/releases/download/v1.1.0/mac-audio-recorder_v1.1.0.tar.xz"
  version "1.1.0"
  sha256 "761a54db25ba003281bd04ab28302daddd1501938e49b6b15c1a0a22a49a26cb"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    bin.install "audiorec"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/audiorec --version")
  end
end
