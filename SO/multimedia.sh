sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo add-apt-repository ppa:kdenlive/kdenlive-stable
sudo apt-get update
sudo apt-get install spotify-client kdenlive audacity gthumb gimp inkscape
