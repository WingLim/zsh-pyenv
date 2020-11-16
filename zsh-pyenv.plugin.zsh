GITHUB="https://github.com"

[[ -z "$PYENV_ROOT" ]] && export PYENV_ROOT="$HOME/.pyenv"

# export PATH
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

_zsh_pyenv_install() {
    echo "Installing pyenv..."
    git clone "${GITHUB}/pyenv/pyenv.git"            "${PYENV_ROOT}"
    git clone "${GITHUB}/pyenv/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"
    git clone "${GITHUB}/pyenv/pyenv-installer.git"  "${PYENV_ROOT}/plugins/pyenv-installer"
    git clone "${GITHUB}/pyenv/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"
    git clone "${GITHUB}/pyenv/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"
    git clone "${GITHUB}/pyenv/pyenv-which-ext.git"  "${PYENV_ROOT}/plugins/pyenv-which-ext"
}

_zsh_pyenv_load() {
    if [[ "$PYENV_LAZY_LOAD" == true ]];then
        function pyenv() {
            unset -f pyenv
            eval "$(command pyenv init -)"
            eval "$(command pyenv virtualenv-init -)"
            pyenv $@
        }
    else
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv-init -)"
    fi
}

# install pyenv if it isnt already installed
if ! (( $+commands[pyenv] )) &>/dev/null; then
    _zsh_pyenv_install
fi

# load pyenv if it is installed
if (( $+commands[pyenv] )) &>/dev/null; then
    _zsh_pyenv_load
fi
