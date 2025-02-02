# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT71 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.3.0.tgz"
  sha256 "0114b146e1036d75a83cd438200df73db030b5d12b8c687843809d1d0cec91be"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a95af1503ba898378168bd918fbb8f2fcf79f747d255a5b51625509ce4c09e47"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fd0157a2c0bd3b811e999f3bf12dbfb93fd681027acf754e06c495ed6bcf6621"
    sha256 cellar: :any_skip_relocation, monterey:       "760b3771efa21edd8ddd3491fb0111bbf6559841669f57509907feb3efae16df"
    sha256 cellar: :any_skip_relocation, big_sur:        "0ff34900d0a3f87eb8262a16743a2ed7de0de0eaabe115d832fd807800777799"
    sha256 cellar: :any_skip_relocation, catalina:       "7e654514d3a7dd776935c5cbe53e8469d332ea72b99dfb61a084ac9b9711901e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8d656a42cfb56092514e0eed6e6d8a5be28508286e2ea20ee8e91b503ef49ee5"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
