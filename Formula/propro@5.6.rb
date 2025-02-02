# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT56 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-1.0.2.tgz"
  sha256 "6b4e785adcc8378148c7ad06aa82e71e1d45c7ea5dbebea9ea9a38fee14e62e7"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa1d9ba80bc35b72a1d14eb021df2b44f5fadeb9d05925d7909ef594a011d44e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8494a61c58f376e7b0f310b3af367e91bd467677048ca710cbc057f6f497de3f"
    sha256 cellar: :any_skip_relocation, monterey:       "85192dd8184ef4c391169d1def19af4057b816686a5fa20a5631a8fe454fa775"
    sha256 cellar: :any_skip_relocation, big_sur:        "4ca7d96f03bfff66e14264a9c9e4a2dcf5be440731d0800991847805305799cd"
    sha256 cellar: :any_skip_relocation, catalina:       "ee61181ab48b820b317ef909d51ac50e951126b19f37aca57a67f0179e4da81f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd0d3a3e52a4c1af46f3d5719c30b9654ff84937cad2648650586ea7e4104798"
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
