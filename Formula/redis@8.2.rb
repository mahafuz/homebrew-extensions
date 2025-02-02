# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "db8c0cd28e67fec0d9a6d27fc39bebb7bac4fe88f3ea247a5a34c2c7e0756155"
    sha256 cellar: :any,                 arm64_big_sur:  "6be1c1a1fdf52d94ee8c522bad4d7d6dc7f89f77f78987b6dd1ee3d2ad72c785"
    sha256 cellar: :any,                 monterey:       "685e042eb01434de0c8ddfcf24df57ee80fb10e612c752a80d74bf745290c233"
    sha256 cellar: :any,                 big_sur:        "6cdc738be806fc30b68ce4fd4704cac2bc0b9064d2d79418c0d4657ef276acb7"
    sha256 cellar: :any,                 catalina:       "910bd0cfe8fd379300cb97e961fc0e36f78970194a8121e0a52fd9bcddcd9e55"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d43822c949202cfc439fcf6a4ea2767265afa39ce8d1d7455ede3980bbde6e48"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  def install
    args = %W[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lz4
      --enable-redis-lzf
      --enable-redis-msgpack
      --enable-redis-zstd
      --with-liblz4=#{Formula["lz4"].opt_prefix}
      --with-libzstd=#{Formula["zstd"].opt_prefix}
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
