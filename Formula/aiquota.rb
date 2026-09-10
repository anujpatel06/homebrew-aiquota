class Aiquota < Formula
  include Language::Python::Virtualenv

  desc "See how much of every AI subscription you've used, in one place"
  homepage "https://github.com/anujpatel06/aiquota"
  url "https://files.pythonhosted.org/packages/56/64/08a68be24162460f0bf833d77c71001ee4ddea1ae729780b6ef1b8320179/aiquota-0.5.2.tar.gz"
  sha256 "44ebf7c33d02a57d717e16721cc2d62d08582840e2ee6156b4915f992b48b85b"
  license "MIT"

  depends_on "python@3.12"

  # No resources block: aiquota is stdlib-only, on purpose.
  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      To add the menu bar and desktop widgets:

        aiquota install-widget

      That needs a host app — install whichever you want:

        brew install --cask swiftbar    # menu bar
        brew install --cask ubersicht   # desktop

      Then click "+ Add an AI account" in the widget, or run: aiquota link
    EOS
  end

  test do
    assert_match "aiquota #{version}", shell_output("#{bin}/aiquota --version")
    # The widgets must ship inside the package, not just the git repo.
    output = shell_output("#{bin}/aiquota --help")
    assert_match "install-widget", output
  end
end
