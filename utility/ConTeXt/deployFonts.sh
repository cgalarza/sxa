#!/bin/bash

set -euo pipefail
mkdir -p $HOME/.fonts
cat > $HOME/.fonts/toDownload <<HereDoc 
https://github.com/adachis/Lifehacker.me/raw/master/fonts/HelveticaNeue.ttf
https://github.com/jackhumbert/kle-image-creator/raw/master/fonts/HelveticaNeueItalic.ttf
https://github.com/jackhumbert/kle-image-creator/raw/master/fonts/HelveticaNeueLight.ttf
https://github.com/jackhumbert/kle-image-creator/raw/master/fonts/HelveticaNeueLightItalic.ttf
https://github.com/adachis/Lifehacker.me/raw/master/fonts/HelveticaNeue-Bold.ttf
HereDoc
wget --directory-prefix=$HOME/.fonts -i $HOME/.fonts/toDownload -nc

export OSFONTDIR=$HOME/.fonts:$(find / -name "*ttf" -o -name "*otf" -printf "%h\n" 2>/dev/null | sort | uniq | tr '\n' :)
# export OSFONTDIR=$HOME/.fonts
echo $OSFONTDIR

mtxrun --script fonts --reload
luatools --generate
mtxrun --script fonts --list --all --pattern=*
context --reload
mtxrun --script fonts --list --all --pattern=Helv*
