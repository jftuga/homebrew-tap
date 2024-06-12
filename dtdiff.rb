# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Dtdiff < Formula
  desc "dtdiff: output the difference between date, time or duration"
  homepage "https://github.com/jftuga/dtdiff"
  version "1.0.3"

  on_macos do
    on_intel do
      url "https://github.com/jftuga/dtdiff/releases/download/v1.0.3/dtdiff_1.0.3_darwin_amd64.tar.xz"
      sha256 "b8eba72c0abbe850b2485028e461ebe7036af22a4e0d147433b80d4f5b60c772"

      def install
        bin.install "dtdiff"
      end
    end
    on_arm do
      url "https://github.com/jftuga/dtdiff/releases/download/v1.0.3/dtdiff_1.0.3_darwin_arm64.tar.xz"
      sha256 "e5f1b9b3e091a9e64d499bb5840b8d9b5357a85414cb3f82af279acf5edc4fb9"

      def install
        bin.install "dtdiff"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jftuga/dtdiff/releases/download/v1.0.3/dtdiff_1.0.3_linux_amd64.tar.xz"
        sha256 "53b9fef477f7cf8d7257fe092d495cdc03d84a81c4ef81670a0a3d4f17a36b28"

        def install
          bin.install "dtdiff"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jftuga/dtdiff/releases/download/v1.0.3/dtdiff_1.0.3_linux_arm64.tar.xz"
        sha256 "d1a62b3cb47a15f7deff88ab3825153637aa57dcddd8d27256a43cffb94f25fa"

        def install
          bin.install "dtdiff"
        end
      end
    end
  end

  test do
    system "#{bin}/dtdiff -v"
  end
end
