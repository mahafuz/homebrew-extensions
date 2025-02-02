# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT71 < AbstractPhpExtension
  init
  desc "Lua PHP extension"
  homepage "https://github.com/laruence/php-lua"
  url "https://pecl.php.net/get/lua-2.0.7.tgz"
  sha256 "86545e1e09b79e3693dd93f2a5a8f15ea161b5a1928f315c7a27107744ee8772"
  head "https://github.com/laruence/php-lua.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b8c9f57d766e4c849162d091b4ae8da4fe7965dba12181c01dcf5775e326fc44"
    sha256 cellar: :any,                 arm64_big_sur:  "b606b228851e979bc65f5f3d697739e73174be6d6e88b54f8885de79ab888199"
    sha256 cellar: :any,                 monterey:       "c1d37a7c0d16e2b83e6bedb2f92850e1b07820c23792a239c46ec3af0901326d"
    sha256 cellar: :any,                 big_sur:        "58d0045c7a20fa5349bfe7f80a062d1f68db7eaade6c8a044cd697ad62eb0336"
    sha256 cellar: :any,                 catalina:       "1132322e5de72ec3445804135281e8bdba9ac601d0e2dfbc945e0aadf5b8e770"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1bddd715e3fe22ae3d884027c13f8b9b952086327dd53f4f877b3c54acb5896d"
  end

  depends_on "lua"

  def install
    args = %W[
      --with-lua=#{Formula["lua"].opt_prefix}
    ]
    Dir.chdir "lua-#{version}"
    inreplace "config.m4", "include/lua.h", "include/lua/lua.h"
    inreplace "php_lua.h", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "lua/lua_closure.h", "lua_closure.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
