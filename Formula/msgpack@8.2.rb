# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any_skip_relocation, arm64_monterey: "32c38b11bb935293e76414f7d6f6d7516774b1da12a454471d9b0864f3a559a3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c5427a9554bc4a98d529eb55a9dcbed1f286dde5b52f490c4c5c3233593b4f86"
    sha256 cellar: :any_skip_relocation, monterey:       "2c8fa1681d26db871754a5b4a49089ec73a01ab0e2eb045046f6cd88c0f5591b"
    sha256 cellar: :any_skip_relocation, big_sur:        "66ccd8a94dc2583c41180dc41356cfd31f67b3f4b921dfb1f32fe1ebc6969f91"
    sha256 cellar: :any_skip_relocation, catalina:       "3116344dab542769e4ac04614ec3edfdc0a13dec35afa91feb212e2b2d84dc92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8a62ba6be85f3de1f2ddb54ef8fac9d108138ed81cc2715edef0f54f6a251170"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
