PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:$HOME/bin; export PATH

BLOCKSIZE=K;	export BLOCKSIZE
EDITOR=vim;   	export EDITOR
PAGER=more;  	export PAGER

if [ -x /usr/games/fortune ] ; then /usr/games/fortune freebsd-tips ; fi

export PATH=$PATH:/usr/local/go/bin

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin

alias gotest="go test $(go list ./... | grep -v /vendor/)"

eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa
