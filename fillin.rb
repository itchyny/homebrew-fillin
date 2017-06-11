class Fillin < Formula
  homepage 'https://github.com/itchyny/fillin'
  version '0.0.2'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.2/fillin_darwin_amd64.zip'
    sha256 '58db2a9a47f512b10a27cc5beec0156f313e61df4ff56f630cac17d966f3ce88'
  else
    url 'https://github.com/itchyny/fillin/releases/download/v0.0.2/fillin_darwin_386.zip'
    sha256 '82dc52c401f83b9bfe06af8088a775ee0939455f40c4fead77bf11e8af211576'
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
