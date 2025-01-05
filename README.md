# How to install
First install vim-plug
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
Then clone this repo to ~/.config/nvim/

and run the nix installer

```
NIXPKGS_ALLOW_UNFREE=1 nix profile install . --impure
```

Then once you have vim-plug and you can run nvim, run
```
:PlugInstall
```
and then you should be good to go
