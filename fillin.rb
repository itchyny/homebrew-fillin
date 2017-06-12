class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.4'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.4/fillin_darwin_amd64.zip'
    sha256 'db498710980ec6c438b839ecca621a7086347522ea163800a463ef4635ece2ca'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.4/fillin_darwin_386.zip'
    sha256 'e186f618f8f26cc112514f35ede0de4c26034dc01b881030dbfd5b7777bd1419'
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
