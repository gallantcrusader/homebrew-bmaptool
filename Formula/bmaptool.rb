class Bmaptool < Formula
  include Language::Python::Virtualenv

  desc "Create and copy block maps for disk images"
  homepage "https://github.com/yoctoproject/bmaptool"
  url "https://github.com/yoctoproject/bmaptool/archive/refs/tags/v3.9.0.tar.gz"
  sha256 "9940bb97fa0f2c11ee4625a2f620a4ae2b94c556f8d01c070aee08486a2a1812"
  license "GPL-2.0-only"

  depends_on "lzop"
  depends_on "pbzip2"
  depends_on "pigz"
  depends_on "python@3.13"
  depends_on "xz"
  depends_on "lz4" => :recommended
  depends_on "zstd" => :recommended
  depends_on "gpgme" => :optional

  uses_from_macos "bzip2"
  uses_from_macos "unzip"

  resource "hatchling" do
    url "https://files.pythonhosted.org/packages/cf/9c/b4cfe330cd4f49cff17fd771154730555fa4123beb7f292cf0098b4e6c20/hatchling-1.29.0.tar.gz"
    sha256 "793c31816d952cee405b83488ce001c719f325d9cda69f1fc4cd750527640ea6"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/65/ee/299d360cdc32edc7d2cf530f3accf79c4fca01e96ffc950d8a52213bd8e4/packaging-26.0.tar.gz"
    sha256 "00243ae351a257117b6a241061796684b084ed1c516a08c48a3f7e147a9d80b4"
  end

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/fa/36/e27608899f9b8d4dff0617b2d9ab17ca5608956ca44461ac14ac48b44015/pathspec-1.0.4.tar.gz"
    sha256 "0210e2ae8a21a9137c0d470578cb0e595af87edaa6ebf12ff176f14a02e0e645"
  end

  resource "pluggy" do
    url "https://files.pythonhosted.org/packages/f9/e2/3e91f31a7d2b083fe6ef3fa267035b518369d9511ffab804f839851d2779/pluggy-1.6.0.tar.gz"
    sha256 "7dcc130b76258d33b90f61b658791dede3486c3e6bfb003ee5c9bfb396dd22f3"
  end

  resource "trove-classifiers" do
    url "https://files.pythonhosted.org/packages/d8/43/7935f8ea93fcb6680bc10a6fdbf534075c198eeead59150dd5ed68449642/trove_classifiers-2026.1.14.14.tar.gz"
    sha256 "00492545a1402b09d4858605ba190ea33243d361e2b01c9c296ce06b5c3325f3"
  end

  def install
    virtualenv_install_with_resources
    man1.install "docs/man1/bmaptool.1"
  end

  test do
    system bin/"bmaptool", "--help"
    testfile = testpath/"test.img"
    testfile.write("\0" * 4096)
    system bin/"bmaptool", "create", testfile
  end
end
