class IscsiFuse < Formula
  desc "Mount iSCSI targets as FUSE filesystems on macOS"
  homepage "https://github.com/dickwu/iscsi-fuse"
  version "0.1.0"
  license "AGPL-3.0-or-later"

  url "https://github.com/dickwu/iscsi-fuse/releases/download/v#{version}/iscsi-fuse-v#{version}-macos-arm64.tar.gz"
  sha256 "0d5187fc38eb266096186ef1a28d70c7942d40aff9a7f6dc10308557d15d21d1"

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
