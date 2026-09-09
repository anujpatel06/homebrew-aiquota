class Aiquota < Formula
  include Language::Python::Virtualenv

  desc "See how much of every AI subscription you've used, in one place"
  homepage "https://github.com/anujpatel06/aiquota"
  url "https://files.pythonhosted.org/packages/bc/f1/2e252109b45c8795b9d716ff09f708cf995f3492bdcf0958c68fb933ddb7/aiquota-0.2.1.tar.gz"
  sha256 "874ea5e6a8d952932a5fdc4d8629e4b8587561b25722ad8d408701c39a347844"
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
