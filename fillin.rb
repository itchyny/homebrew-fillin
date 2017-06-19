class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.8'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.8/fillin_darwin_amd64.zip'
    sha256 'f0aa4213e83340d1220061f1ebf6323d4c7f1e3a3c23d0e788e6bedb8ffe321a'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.8/fillin_darwin_386.zip'
    sha256 '577f149f3f887e9b907a62eaf0789a613a6a549cc4aa8165c5010966aa46e48e'
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
