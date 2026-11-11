class SealmeshServer < Formula
  desc "Connection registry and query router for sealmesh daemons"
  homepage "https://github.com/allocmemory/sealmesh"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-server-aarch64-apple-darwin.tar.xz"
      sha256 "5bd642e142d5be61da56e11e0b8982e2536cb45a1cbe7939ad7b6364d98ac664"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-server-x86_64-apple-darwin.tar.xz"
      sha256 "6a47d08628bc0011c41f1660d1dd4da913d729bc7a500e0b030c4629a4e5c378"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-server-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "24347990fd528da3620ab05128d9df397cf1fb71509eaf64f46bede71faebdf3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-server-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fcaeead5748183d099551067ba6c1b4e307e7e44bd503bc1bb550092194d68d7"
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
