class Tmv < Formula
  desc "TMV C++ linear algebra library"
  homepage "https://github.com/rmjarvis/tmv"
  url "https://github.com/rmjarvis/tmv/archive/v0.72.tar.gz"
  sha256 "39083c804fc1015a08e1e414bb47764f6ea906c06103f0dea3555b734ad57430"
  
  depends_on "scons" => :build
  
  def install
    # hack the TMV version script to just echo the current version
    inreplace "#{buildpath}/bin/tmv-version", "#!/bin/bash", "#!/bin/bash\necho 0.72\nexit"
    scons "PREFIX=#{prefix}", "WITH_BLAS=false"
    scons "install"
  end
end
  
