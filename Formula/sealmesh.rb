class Sealmesh < Formula
  desc "See what your coding agents are working on across machines, without messaging anyone"
  homepage "https://github.com/allocmemory/sealmesh"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-aarch64-apple-darwin.tar.xz"
      sha256 "faef91d1c4ed1865b55929f51a4f8ba533e5c3216706c828fa500625338f2a3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-x86_64-apple-darwin.tar.xz"
      sha256 "954cc55c633e8436ff8ecbd3cb9e0012b0dae9a5d72104ab726ffa78fccb603c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "961c42ba551f646e02bc0433d6070788096b5f5279486f0308f7fe491053f382"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cff0089c4c0fadeff91e3de1a3721a1bd902b9382723630ab6bf8dfbb56eb6b0"
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
      bin.install "sealmesh"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sealmesh"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sealmesh"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sealmesh"
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
