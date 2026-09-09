class Aiquota < Formula
  include Language::Python::Virtualenv

  desc "See how much of every AI subscription you've used, in one place"
  homepage "https://github.com/anujpatel06/aiquota"
  url "https://files.pythonhosted.org/packages/45/9b/201f4512fec4f9719c40706732d89b77d5f744e0368483fa8f32632ed725/aiquota-0.3.0.tar.gz"
  sha256 "882d57e30e5e61ba62caaa25e5429c2e584315f9ff8a30c929cc4c03a96d558c"
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
