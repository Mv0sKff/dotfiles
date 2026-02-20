# Corp Profile
#echo "[corp profile]"

alias code='/mnt/c/Program\ Files/Microsoft\ VS\ Code/Code.exe'
alias c='clip.exe'
alias n='explorer.exe .'

alias cur='cursor .'
alias k=kubectl
alias tfclean=tfclear

# corp ca
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

tfclear() {
	echo "terraform state rm $(terraform state list)"
	terraform state rm $(terraform state list)
}

tfgo() {
	echo "tf plan -out=tfp && tf apply tfp"
	tf plan -out=tfp && tf apply tfp
}

fpath+=$(brew --prefix)/share/zsh/site-functions
