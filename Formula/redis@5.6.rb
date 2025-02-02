# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT56 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-4.3.0.tgz"
  sha256 "c0f04cec349960a842b60920fb8a433656e2e494eaed6e663397d67102a51ba2"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "430f331a8f3d6e28f5aa8f0d8db3b9e3745b5348857d84025511d153c6edb7b3"
    sha256                               arm64_big_sur:  "2ee1119eb42fc841c3fc5b8aac4a1b8fa5b33a872dc1ab478affdc191813b117"
    sha256 cellar: :any,                 monterey:       "ed073690308558ea38e14beb39c10527a62d8497fe2c4ca90f7fabc1d4d558dc"
    sha256                               big_sur:        "313ba4b0da7e2e3296f2cc9ef43718099d3234d0295f1aa47ef9aa12a00477bd"
    sha256                               catalina:       "ef273037209ec1b12b0a066a43148b9e4202a69e3801e224a5cda298fe052aea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "688baafc60d31dd85c38efc7ec84ece03db5ab42337363cb80202bcf3ad7c556"
  end

  depends_on "liblzf"
  depends_on "shivammathur/extensions/igbinary@5.6"

  def patch_redis
    mkdir_p "include/php/ext/igbinary"
    headers = Dir["#{Formula["igbinary@5.6"].opt_include}/**/*.h"]
    (buildpath/"redis-#{version}/include/php/ext/igbinary").install_symlink headers unless headers.empty?
  end

  def install
    args = %w[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lzf
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
