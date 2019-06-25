# NVM 
export NVM_DIR=$HOME/.nvm
source $(brew --prefix nvm)/nvm.sh

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Mono
export MONO_GAC_PREFIX="/usr/local"

# MOE
export INTEL_MULTI_OS_ENGINE_HOME=/Applications/Intel/multi_os_engine

# Golang
export GOPATH=$HOME/workspace/golang
export GOROOT=/usr/local/opt/go/libexec
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN
export PATH=$PATH:$GOROOT/bin

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="/Users/catstail/workspace/cpp/lib/cocos2d-x-3.16/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="/Users/catstail/workspace/cpp/lib"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="/Users/catstail/workspace/cpp/lib/cocos2d-x-3.16/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT="/usr/local/Cellar/android-sdk/24.4.1_1"
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH
