class Aiquota < Formula
  include Language::Python::Virtualenv

  desc "See how much of every AI subscription you've used, in one place"
  homepage "https://github.com/anujpatel06/aiquota"
  url "https://files.pythonhosted.org/packages/ea/5a/018100c0cfa923e4b7d451691c0a0f7dc906c0da8693881cd2db1dacbe7b/aiquota-0.5.0.tar.gz"
  sha256 "fc734c63e2bd965613eaf264c4240a98803e7de2ab0dd558bd8862a9139f9d96"
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
