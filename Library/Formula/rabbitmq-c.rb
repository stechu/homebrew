require 'formula'

class RabbitmqC < Formula
  homepage 'https://github.com/alanxz/rabbitmq-c'
  url 'https://github.com/alanxz/rabbitmq-c/archive/v0.5.0.tar.gz'
  sha1 '826286c3f04695bdc231d8e7b0541f871975cdcc'

  head 'https://github.com/alanxz/rabbitmq-c.git'

  option :universal

  depends_on 'pkg-config' => :build
  depends_on 'autoconf' => :build # Use a newer version on Snow Leopard too
  depends_on 'automake' => :build
  depends_on :libtool
  depends_on 'rabbitmq'
  depends_on 'simplejson' => :python if MacOS.version <= :leopard

  resource 'codegen' do
    url 'https://github.com/rabbitmq/rabbitmq-codegen/archive/rabbitmq_v3_2_4.tar.gz'
    sha1 '936d66a98e00cb1c2921fa13c5ec1bc8f83d33ad'
  end

  def install
    ENV.universal_binary if build.universal?
    (buildpath/'codegen').install resource('codegen')
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
