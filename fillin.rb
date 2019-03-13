class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.1.0'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.1.0/fillin_darwin_amd64.zip'
    sha256 '7bfd78f881b41bf841702f5ccf39ce8459dca9d803e5a9aa5683fc7707dcfcc0'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.1.0/fillin_darwin_386.zip'
    sha256 '062bd8f62fd2b4e75c1cfe71cbc542c9d0f52476044fd597c33645b6f5d2e087'
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
