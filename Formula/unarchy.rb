class Unarchy < Formula
  desc "Extract almost any archive on macOS: zip, 7z, rar, tar, dmg, iso and more"
  homepage "https://github.com/alimans315/unarchy"
  url "https://github.com/alimans315/unarchy/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7dcd22f2ac74ca0a511474b6d8e2050f06dc3df3dd229684bbf7fb7cbb4572a7"
  license "GPL-3.0-or-later"

  depends_on :macos
  depends_on "sevenzip"
  depends_on "unar"

  def install
    bin.install "unarchy"
    man1.install "unarchy.1"
    zsh_completion.install "completions/_unarchy"
  end

  test do
    (testpath/"hello.txt").write "hello from unarchy\n"
    system "/usr/bin/zip", "-q", "hello.zip", "hello.txt"
    system bin/"unarchy", "-q", "-o", testpath/"out", testpath/"hello.zip"
    assert_equal "hello from unarchy\n", (testpath/"out/hello.txt").read
    assert_match "7-zip", shell_output("#{bin}/unarchy --engines")
  end
end
