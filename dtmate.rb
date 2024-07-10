# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Dtmate < Formula
  desc "dtmate: output the difference between date, time or duration"
  homepage "https://github.com/jftuga/DateTimeMate"
  version "1.0.0"

  on_macos do
    on_intel do
      url "https://github.com/jftuga/DateTimeMate/releases/download/v1.0.0/DateTimeMate_1.0.0_darwin_amd64.tar.xz"
      sha256 "174dc17a06b0070ca349398f030497d931ef81e926b98a377bd77d2d3ff5decb"

      def install
        bin.install "dtmate"
      end
    end
    on_arm do
      url "https://github.com/jftuga/DateTimeMate/releases/download/v1.0.0/DateTimeMate_1.0.0_darwin_arm64.tar.xz"
      sha256 "112bdae2382e4b224d0a347e4b68db9a13d8e1a5a87a9db18bd85560d5fcdbac"

      def install
        bin.install "dtmate"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jftuga/DateTimeMate/releases/download/v1.0.0/DateTimeMate_1.0.0_linux_amd64.tar.xz"
        sha256 "3f1fe9233405957008249be8e3e6ef64a7e6f8eb1f07246ea1dbcd94141b0288"

        def install
          bin.install "dtmate"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jftuga/DateTimeMate/releases/download/v1.0.0/DateTimeMate_1.0.0_linux_arm64.tar.xz"
        sha256 "9c413cfd298733a31016703d1201fe400357961555595cb81404a3ea0a6536cc"

        def install
          bin.install "dtmate"
        end
      end
    end
  end

  test do
    system "#{bin}/dtmate -v"
  end
end
