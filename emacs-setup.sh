rm -rf ~/.emacs.d
wget -c https://github.com/flyingmachine/emacs-for-clojure/archive/book1.zip && unzip book1.zip
mv ~/emacs-for-clojure-book1 ~/.emacs.d
sed -i '13s/$/ (add-to-list '\''package-archives '\''("melpa-stable . "http://stable.melpa.org/packages") t)/' ~/.emacs.d/init.el
sed '14s/$/ (add-to-list '\''package-pinned-packages '\''(cider . "melpa-stable") t)/' ~/.emacs.d/init.el
rm -Rf ~/.emacs.d/elpa/cider-*
echo ""
echo "Please! Run M-x package-refresh contents & M-x package-install cider..."
rm -rf ~/book1.zip
emacs
