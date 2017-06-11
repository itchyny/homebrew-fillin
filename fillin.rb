class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.3'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.3/fillin_darwin_amd64.zip'
    sha256 '4442651e170f9eb17ca913443c66149f50de1581d004830d406e74058779e324'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.3/fillin_darwin_386.zip'
    sha256 'e6ec3fa470134536144ccb9abee515ef7b08ec84f4234cf71484cad24128b7f8'
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
