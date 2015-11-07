class Fftw2 < Formula
  desc "legacy FFTW 2.1.5"
  homepage "http://www.fftw.org"
  url "http://www.fftw.org/fftw-2.1.5.tar.gz"
  
  option "with-fortran", "Enable Fortran bindings"
  option :universal
  option "with-mpi", "Enable MPI parallel transforms"
  option "with-openmp", "Enable OpenMP parallel transforms"

  depends_on :fortran => :optional
  depends_on :mpi => [:cc, :optional]
  needs :openmp if build.with? "openmp"

  def install
    args = ["--enable-shared",
            "--disable-debug",
            "--prefix=#{prefix}",
            "--enable-threads",
            "--disable-dependency-tracking"]
    simd_args = ["--enable-sse2"]
    simd_args << "--enable-avx" if ENV.compiler == :clang && Hardware::CPU.avx? && !build.bottle?

    args << "--disable-fortran" if build.without? "fortran"
    args << "--enable-mpi" if build.with? "mpi"
    args << "--enable-openmp" if build.with? "openmp"

    ENV.universal_binary if build.universal?

    # single precision
    # enable-sse2 and enable-avx works for both single and double precision
    system "./configure", "--enable-single", "--enable-type-prefix", *(args + simd_args)
    system "make", "install"

    # clean up so we can compile the double precision variant
    system "make", "clean"

    # double precision
    # enable-sse2 and enable-avx works for both single and double precision
    system "./configure", "--enable-type-prefix", *(args + simd_args)
    system "make", "install"

    # clean up so we can compile the double version w/o type prefixes
    system "make", "clean"

    # double precision
    # enable-sse2 and enable-avx works for both single and double precision
    system "./configure", *(args + simd_args)
    system "make", "install"

  end
end
