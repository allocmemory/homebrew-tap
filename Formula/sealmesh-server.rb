class SealmeshServer < Formula
  desc "Connection registry and query router for sealmesh daemons"
  homepage "https://github.com/allocmemory/sealmesh"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-server-aarch64-apple-darwin.tar.xz"
      sha256 "bafb860a9286ce681ba75b326168792c886be9a279f5599e0d04ad5ce0b27fc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-server-x86_64-apple-darwin.tar.xz"
      sha256 "98bcb488ec9fd50a3d2dba8bd72a659ead987a332cc5d678825bdbea0b45da81"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-server-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1cbf968acd4a18fc08b3fce19c1a94f041da6e6228e73677284fadd557e23e09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-server-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d3599061b1308823f90e50f03e451530f0cc6ea71ef5d96e5a10e133b38b1c3"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sealmesh-server"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sealmesh-server"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sealmesh-server"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sealmesh-server"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
