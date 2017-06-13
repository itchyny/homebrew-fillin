class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.5'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.5/fillin_darwin_amd64.zip'
    sha256 '6c61a36b3570de517f96d930f92c64beb193ff005ad82dd39df5c8a44d2e2678'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.5/fillin_darwin_386.zip'
    sha256 '4975ceae3e6dd4a7191c542c459393409377126d1f4a0450bf633a25f0100ec9'
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
