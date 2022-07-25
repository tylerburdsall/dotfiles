set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:coc_global_extensions = [
      \'coc-markdownlint',
      \'coc-highlight',
      \'coc-go',
      \'coc-pyright',
      \'coc-explorer',
      \'coc-rust-analyzer',
      \'coc-json',
      \'coc-git',
      \'coc-tsserver',
      \'coc-eslint',
      \'coc-solargraph'
      \]
