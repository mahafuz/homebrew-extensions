# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT74 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a95d2280977b1574d1bee77f07a2db4b0440a2e18f40dbf4cf15b4c7b0c21fd7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2c5bcc6b26ca174f88311de1f31a4bd617639906492efe199cad6d475221692d"
    sha256 cellar: :any_skip_relocation, monterey:       "256ecb05c7ecc6043b2b2e5b7bd5ed620e68630d119819aef4ad712e1789ea96"
    sha256 cellar: :any_skip_relocation, big_sur:        "354a4c35a5d19a0a3c580458cc84468944ec1fc2ff0b8f6bf10732fc3be17cc7"
    sha256 cellar: :any_skip_relocation, catalina:       "2dc836623448bcd1d3801c9c6b91933d468201ca49737b6e8845f94c53eb11ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c4d33fde7e4e9228f2d09ce526faa33c996558e26f3931cf1ffc6f1de15f3f2"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
