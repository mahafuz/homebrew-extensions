# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT71 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8a9f4a4ca07626fcd74e2cf96fab51af8f3d4441e09b5c923bc6865ec763b1c4"
    sha256 cellar: :any,                 arm64_big_sur:  "b6ba7f0a12cf88ad5f32b5b146e7eb9b5f0720261d5630cf2ef58c475696fd32"
    sha256 cellar: :any,                 monterey:       "0daf8d910b9bb568c456dc415d5fe1e67009ccd70ad8ab5cba0dbe36658aed04"
    sha256 cellar: :any,                 big_sur:        "39444d76f907cc18c704ffda079ca76b87d12b0dab0b866f0d75348f145f5efd"
    sha256 cellar: :any,                 catalina:       "2151e659a63d49c1a1f19f472a918762e9f2f588345c9c75b0f9eef9805717de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "069873140d45c4563b0cb5d556731309977bb7d18e109b0c07b8003244bf594a"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
