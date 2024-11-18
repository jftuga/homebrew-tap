# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Dtmate < Formula
  desc "dtmate: output the difference between date, time or duration"
  homepage "https://github.com/jftuga/DateTimeMate"
  version "1.3.1"

  on_macos do
    on_intel do
      url "https://github.com/jftuga/DateTimeMate/releases/download/v1.3.1/DateTimeMate_1.3.1_darwin_amd64.tar.xz"
      sha256 "6b393bc5fcec859317b9e3b09cc79c273dc993e8012a19ca7464fc617faa9009"

      def install
        bin.install "dtmate"
      end
    end
    on_arm do
      url "https://github.com/jftuga/DateTimeMate/releases/download/v1.3.1/DateTimeMate_1.3.1_darwin_arm64.tar.xz"
      sha256 "886ce17b73b6ee9b88ca3f71e8b7db641d46f2335fc66379c8407df65a47293a"

      def install
        bin.install "dtmate"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jftuga/DateTimeMate/releases/download/v1.3.1/DateTimeMate_1.3.1_linux_amd64.tar.xz"
        sha256 "b70a5456b3f62c56ff857407aed4bf608e3fc1fd28e94af088cee731817edad8"

        def install
          bin.install "dtmate"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jftuga/DateTimeMate/releases/download/v1.3.1/DateTimeMate_1.3.1_linux_arm64.tar.xz"
        sha256 "ce4e7796f4fba82e1ae9cddd7ae22e90a644a4bec2dc793abbcc9bb81a860dd3"

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
