class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.7'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.7/fillin_darwin_amd64.zip'
    sha256 '24b2d298d0b003838c70b3f015d5ac27122249364fc672244075cd8785582daa'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.7/fillin_darwin_386.zip'
    sha256 'eaa2de2e1c19dec20d9ce653f6fcee1584f8aa293a98c02aaf67b3172ea8beb0'
  end

  head do
    url 'https://github.com/itchyny/fillin.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/itchyny'
      ln_s buildpath, buildpath/'.go/src/github.com/itchyny/fillin'
      system 'make', 'build'
      bin.install 'build/fillin'
    else
      bin.install 'fillin'
    end
  end

  test do
    system 'fillin', '--version'
  end
end
