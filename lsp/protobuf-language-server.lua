return {
  cmd = { "protobuf-language-server", "-stdio" },
  filetypes = { "proto" },
  root_markers = {
    "buf.yaml",
    "buf.work.yaml",
    ".git",
  },
}
