# bits of this hacked from https://github.com/camphogg/homebrew-science/blob/master/tmv-cpp.rb
# my version always does builds the tests
# I also hacked in the right version in the tmv-version script

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
    scons "test"
    scons "install"

    # dylibs don't have the correct install name.
    #%w[libtmv.0.dylib libtmv_symband.0.dylib].each do |libname|
    #  system "install_name_tool -id #{lib}/#{libname} #{lib}/#{libname}"
    #end

    (share / "tmv/tests").install Dir["test/tmvtest*"]
  end

  test do
    Dir[share / 'tmv/tests/tmvtest*'].each do |testcase|
      system testcase
    end
  end
end
  
