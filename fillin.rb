class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.1'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.1/fillin_darwin_amd64.zip'
    sha256 'a2f2e3af31f8c3e8967d2a9ea69e2adb374318ced84360c9a0dcc5cc6c698644'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.1/fillin_darwin_386.zip'
    sha256 '7c2fd3761fdb986f45e4e0fadae2eacb061c98dd09bf1753b288e202778d94ff'
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
