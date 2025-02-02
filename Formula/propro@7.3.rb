# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1f58cbdb9b15e98151b1c2b7844554ca264f2bfbe4f398381bb286bf3655faf6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d5eed500672f357acaf39e8d469b305d466b9aa18334a8a05fb1cacfac96c5ae"
    sha256 cellar: :any_skip_relocation, monterey:       "7333316fb372b516fe6ca53dc9c724747d7f8e78638eab9d9824043c0cb46674"
    sha256 cellar: :any_skip_relocation, big_sur:        "191816e84fbc2c5b7bdf60edd6dfce2ce52430f090f82449b920b5ba0806bfb3"
    sha256 cellar: :any_skip_relocation, catalina:       "27a16d7ee187f47924e6b3b18d949d763469a0b7e56c5f21d93163ce6402dc94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "accac3beb9db1ae1b8fbaf164f029000b9b571d336fa39d3c17b251d51da8e6d"
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
