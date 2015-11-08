class Tmv < Formula
  desc "TMV C++ linear algebra library"
  homepage "https://github.com/rmjarvis/tmv"
  url "https://github.com/rmjarvis/tmv/archive/v0.72.tar.gz"

  depends_on "scons"
  
  def install
    system "scons", "install", "PREFIX=#{prefix}", "WITH_BLAS=false"
  end
end
  
