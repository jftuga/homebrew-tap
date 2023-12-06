# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Spotprice < Formula
  desc "Quickly get AWS spot instance pricing"
  homepage "https://github.com/jftuga/spotprice"
  version "2.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/spotprice/releases/download/v2.0.0/spotprice_2.0.0_darwin_arm64.tar.xz"
      sha256 "163a886780fbaac884bbd190acb5a6042234dcc85824a4e1e89632ce0c2f6d05"

      def install
        bin.install "spotprice"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/jftuga/spotprice/releases/download/v2.0.0/spotprice_2.0.0_darwin_amd64.tar.xz"
      sha256 "a4ecdf43b108ffd6bdfa830967d3e9b36658998e538d28f87ad0fd86b8023bf6"

      def install
        bin.install "spotprice"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/jftuga/spotprice/releases/download/v2.0.0/spotprice_2.0.0_linux_arm64.tar.xz"
      sha256 "898542887686c5c9902dd08ab430a3af7c852d500a8ec9a1274b2faad9755f03"

      def install
        bin.install "spotprice"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/jftuga/spotprice/releases/download/v2.0.0/spotprice_2.0.0_linux_amd64.tar.xz"
      sha256 "d9d8515fa96e25833df3412290588ae47f0936cecf7ee66d5d4cb7e88a9175e0"

      def install
        bin.install "spotprice"
      end
    end
  end

  test do
    system "#{bin}/spotprice -v"
  end
end