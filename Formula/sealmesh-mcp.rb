class SealmeshMcp < Formula
  desc "The MCP server a coding agent mounts over stdio to reach sealmesh — Claude Code and Codex both"
  homepage "https://github.com/allocmemory/sealmesh"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "82076cb7a20caf163545acc35565435ca642d46c31ffdd4fc9c3df7edf3c2e08"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "d5176b1da8a89c501abf65760e56ae1a47cb34c024aa0f326b3fa77fd0eefa54"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8828e0e977c8c5179342e59753946a0872f5d63f518fb07807d8f18fb4510acd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.0/sealmesh-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7fbc4bfa3deb9423d0ff2a1731640403c48798fce852e671ee20fa1869f8380"
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
      bin.install "sealmesh-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sealmesh-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sealmesh-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sealmesh-mcp"
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
