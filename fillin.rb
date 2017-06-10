class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.0'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.0/fillin_darwin_amd64.zip'
    sha256 '2b26fa31e85cd2db8a1658da7b630a7aa00e1034acfb1ba29329f3fa9d0cb478'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.0/fillin_darwin_386.zip'
    sha256 '763fd1e534e3a25bd00a6d33b185b066ee502eb14ba7cd215ed7ce539499f931'
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
