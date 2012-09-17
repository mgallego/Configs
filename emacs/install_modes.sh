mkdir .emacs.modes
cd .emacs.modes

git clone https://github.com/ejmr/php-mode.git
git clone https://github.com/yoshiki/yaml-mode.git
git clone https://github.com/mgallego/sf.el.git
git clone https://github.com/jrockway/eproject.git
git clone https://github.com/illusori/emacs-flymake-phpcs.git
git clone https://github.com/alpaker/Fill-Column-Indicator.git
git clone https://github.com/konr/tomatinho.git
git clone https://github.com/blipvert/geben-svn.git
git clone https://github.com/capitaomorte/yasnippet
git clone https://github.com/mgallego/yasnippet-php-mode.git

cd geben-svn
make
cd ..

mkdir lorem-ipsum
cd lorem-ipsum
wget http://www.emacswiki.org/emacs/download/lorem-ipsum.el
cd ..

cd ..
