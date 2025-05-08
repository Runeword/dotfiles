.PHONY: all build install clean

all: build

build:
	cd chezmoi-fzf && go build -o ../bin/chezmoi-fzf
	cd aliases-fzf && go build -o ../bin/aliases-fzf

install: build
	mkdir -p $(HOME)/.nix-profile/bin
	cp bin/chezmoi-fzf $(HOME)/.nix-profile/bin
	cp bin/aliases-fzf $(HOME)/.nix-profile/bin

clean:
	rm -rf bin/
	cd chezmoi-fzf && go clean
	cd aliases-fzf && go clean 
