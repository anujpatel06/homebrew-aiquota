class Aiquota < Formula
  include Language::Python::Virtualenv

  desc "See how much of every AI subscription you've used, in one place"
  homepage "https://github.com/anujpatel06/aiquota"
  url "https://files.pythonhosted.org/packages/fe/d6/0facd67113a3c4216bdd83b869f7932192c91177856ce557877fd83807b5/aiquota-0.4.0.tar.gz"
  sha256 "92124848ed198e78d71f13187bf76a50b897e64782647bcbd952471347a85765"
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
