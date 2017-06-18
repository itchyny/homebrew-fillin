class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.6'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.6/fillin_darwin_amd64.zip'
    sha256 '11fabe5d1dc8ea26dd85f06091050decd012faece693e729398800c31312771a'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.6/fillin_darwin_386.zip'
    sha256 'd912f693dd25c135cb447639d298bdf071a28c29456ade7667a1181a7735ef9a'
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
