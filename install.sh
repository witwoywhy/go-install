go_dir=~/go
go_sdk_dir=~/go/sdk
go_path_dir=~/go/path

go_version=$1
go_arch=linux-amd64
go_file_download="go$go_version.$go_arch.tar.gz"
go_version_dir="go$go_version"

bash_dir=~/.bashrc

function validate_args() {
	if [[ "$#" -eq 0 ]]; then
		echo "please input go version './install [version]'"
		exit 1
	fi
}

function download() {
	wget https://go.dev/dl/$go_file_download
}

function extract() {
	tar -xzf $go_file_download
}

function rename() {
	mv go $go_version_dir
}

function move() {
	mv $go_version_dir $go_sdk_dir
}

function config() {
	echo "" >> $bash_dir
	echo "export GOROOT=$go_sdk_dir/$go_version_dir" >> $bash_dir
	echo "export GOPATH=$go_path_dir/$go_version_dir" >> $bash_dir
	echo "export GOBIN=\$GOPATH/bin" >> $bash_dir
	echo "export PATH=\$PATH:\$GOROOT/bin:\$GOBIN" >> $bash_dir
}

validate_args "$@"
download
extract
rename
mkdir -p $go_dir
mkdir -p $go_sdk_dir
mkdir -p $go_path_dir
move
config
source $bash_dir
rm -rf $go_file_download
go env