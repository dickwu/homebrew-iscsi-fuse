class IscsiFuse < Formula
  desc "Mount iSCSI targets as FUSE filesystems on macOS"
  homepage "https://github.com/dickwu/iscsi-fuse"
  version "0.2.0"
  license "AGPL-3.0-or-later"

  url "https://github.com/dickwu/iscsi-fuse/releases/download/v#{version}/iscsi-fuse-v#{version}-macos-arm64.tar.gz"
  sha256 "0052fc99010b17937aeceb81cac8300f614a2700fc64b4ab490f4c76443dd70c"

  depends_on :macos

  def install
    bin.install "iscsi-fuse"
  end

  def caveats
    <<~EOS
      macFUSE must be installed and its kernel extension must be allowed in
      System Settings > Privacy & Security for iscsi-fuse to work.

      After installing macFUSE:
        1. Open System Settings > Privacy & Security
        2. Click "Allow" for the "Benjamin Fleischer" system extension
        3. Reboot your Mac
        4. Verify: kextstat | grep macfuse

      To auto-mount at login, see:
        https://github.com/dickwu/iscsi-fuse#auto-mount-at-login-launchd
    EOS
  end

  test do
    assert_match "iscsi-fuse", shell_output("#{bin}/iscsi-fuse --help")
  end
end
