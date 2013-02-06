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
git clone https://github.com/auto-complete/popup-el.git
git clone https://github.com/auto-complete/auto-complete.git
git clone git://jblevins.org/git/markdown-mode.git
git clone https://github.com/mgallego/phpdocumentor.el
git clone git://github.com/emacsmirror/nxhtml.git
git clone git://github.com/baohaojun/org-jira.git
hg clone https://code.google.com/p/emacs-soap-client/


cd geben-svn
make
cd ..

mkdir lorem-ipsum
cd lorem-ipsum
wget http://www.emacswiki.org/emacs/download/lorem-ipsum.el
cd ..

cd ..
