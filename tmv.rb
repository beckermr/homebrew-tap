class Tmv < Formula
  desc "TMV C++ linear algebra library"
  homepage "https://github.com/rmjarvis/tmv"
  url "https://googledrive.com/host/0B6hIz9tCW5iZdEcybFNjRHFmOEE/tmv0.72.tar.gz"
  sha256 "39083c804fc1015a08e1e414bb47764f6ea906c06103f0dea3555b734ad57430"
  
  depends_on "scons" => :build
  
  def install
    scons "PREFIX=#{prefix}", "WITH_BLAS=false"
    scons "install"
  end
end
  
