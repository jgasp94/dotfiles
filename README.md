
# vá para o home e crie o diretório "dotfiles"
cd ~
mkdir dotfiles




# crie um repo remoto chamado "dotfiles"
# entre no diretório e inicie um repositório git
cd ~/dotfiles
git init

# vá no github e pegue o endereço SSH do seu 
# repositório 'dotfiles'. Copie aquele endereço
# e configure o seu repo local.
git remote add origin git@github.com:{username}/dotfiles.git

#No repositõrio executar o script InstallSoftware.ps1 como administrador
### diga ao git pra monitorar os arquivos no seu homedir
git config core.worktree '../../'

### ignora tudo
echo '*' > ~/.gitignore

### observações:
### - como estamos gitignorando tudo, use '-f'
# - como estamos em ~/dotfiles, precisamos do '../'
git add -f ../.bashrc
git add -f ../.vimrc


### commit & push
git commit -m 'upando meus dotfiles'
git push

# Recuperando os arquivos em outra máquina:
### certifique-se que está no homedir
cd ~

### use o --no-checkout para não fazer checkout
### dos arquivos dentro diretório que será criado
git clone --no-checkout git@github.com:${username}/dotfiles.git

# entre no repositório recém criado
cd ~/dotfiles

# diga ao git pra monitorar os arquivos no seu homedir
git config core.worktree '../../'

# agora fazemos o checkout dos arquivos
# diretamente no nosso homedir
# ⚠ atenção! ⚠ arquivos atuais serão sobrescritos
git reset --hard origin/master


# Links Úteis

### https://winget.run/
### https://winstall.app
