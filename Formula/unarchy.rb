class Unarchy < Formula
  desc "Extract almost any archive on macOS: zip, 7z, rar, tar, dmg, iso and more"
  homepage "https://github.com/alimans315/unarchy"
  url "https://github.com/alimans315/unarchy/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "52976c21114a332f3760a72345bef135848cf13efd6669e1a56580cd3e4bc463"
  license "GPL-3.0-or-later"

  depends_on :macos
  depends_on "sevenzip"
  depends_on "unar"

  def install
    bin.install "unarchy"
  end

  test do
    (testpath/"hello.txt").write "hello from unarchy\n"
    system "/usr/bin/zip", "-q", "hello.zip", "hello.txt"
    system bin/"unarchy", "-q", "-o", testpath/"out", testpath/"hello.zip"
    assert_equal "hello from unarchy\n", (testpath/"out/hello.txt").read
    assert_match "7-zip", shell_output("#{bin}/unarchy --engines")
  end
end
