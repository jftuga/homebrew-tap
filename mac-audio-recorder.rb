# typed: false
# frozen_string_literal: true

class MacAudioRecorder < Formula
  desc "Swift CLI that records macOS system audio and microphone to separate or combined tracks"
  homepage "https://github.com/jftuga/mac-audio-recorder"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/mac-audio-recorder/releases/download/v1.0.0/mac-audio-recorder_v1.0.0.tar.xz"
      sha256 "87557a50562940be1a81cdee84209858ed92a242b03db9828aacafd1497b00cb"

      define_method(:install) do
        bin.install "audiorec"
      end
    end
  end

  test do
    system "#{bin}/audiorec --version"
  end
end