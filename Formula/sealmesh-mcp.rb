class SealmeshMcp < Formula
  desc "The MCP server a coding agent mounts over stdio to reach sealmesh — Claude Code and Codex both"
  homepage "https://github.com/allocmemory/sealmesh"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "937f3b5da9b343e6c84de4221a32053bbef2627ee9897bf7577770d2c0a1c328"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "e55483caf771674ed82707bf671ba2a9a8347aa109534b8ca3c20564bc1127b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52a9ae1fb16416c8027f0e77fd3c4944b9a25dc65ee22e5d1527e24259d62d95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/allocmemory/sealmesh/releases/download/v0.2.1/sealmesh-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb3498c312ea8826cfa3b545113ef228d99781393b5f47db154ee45fabeb77b1"
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
