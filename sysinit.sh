mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# add following lines in /etc/X11/xorg.conf.d/30-touchpad.conf

# Section "InputClass"
# 	Identifier "libinput touchpad catchall"
# 	MatchIsTouchpad "on"
# 	MatchDevicePath "/dev/input/event*"
# 	Driver "libinput"
# 	Option "NaturalScrolling" "true"
# 	Option "ClickMethod" "clickfinger"
# 	Option "Tapping" "on"
# EndSection
