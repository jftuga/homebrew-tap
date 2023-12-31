# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Changecase < Formula
  desc "convert command line arguments to upper, lower or title case"
  homepage "https://github.com/jftuga/changecase"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jftuga/changecase/releases/download/v1.2.0/changecase_1.2.0_darwin_arm64.tar.xz"
      sha256 "11e3fabef839cd67c49477e7c023ade06d5f6bb4c957c15198600857fb023e4e"

      def install
        bin.install "lower"
        bin.install "upper"
        bin.install "titlecase"
        bin.install "len"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/jftuga/changecase/releases/download/v1.2.0/changecase_1.2.0_darwin_amd64.tar.xz"
      sha256 "02d3c4f7e67d333bd8316aa0ae2c2fb5a7124a8d7d98e5909fcd60b15e4388f4"

      def install
        bin.install "lower"
        bin.install "upper"
        bin.install "titlecase"
        bin.install "len"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/jftuga/changecase/releases/download/v1.2.0/changecase_1.2.0_linux_amd64.tar.xz"
      sha256 "24dd66d29f429832a523dd8d76504643640ef66d209db042c31f8c2b17b1749c"

      def install
        bin.install "lower"
        bin.install "upper"
        bin.install "titlecase"
        bin.install "len"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/jftuga/changecase/releases/download/v1.2.0/changecase_1.2.0_linux_arm64.tar.xz"
      sha256 "36ead8f7380712be4d5e54c9f783aa2fc7df10f35dd4ce089e96092d01f6aa9f"

      def install
        bin.install "lower"
        bin.install "upper"
        bin.install "titlecase"
        bin.install "len"
      end
    end
  end

  test do
    system "#{bin}/lower TEST"
  end
end
