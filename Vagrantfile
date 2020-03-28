Vagrant.configure("2") do |config|
  # config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/vagrant",
    disabled: true,
    type: "rsync",
    rsync__exclude: [ 
      ".git/",
      ".vagrant/",
      ".tox/"
    ]
  config.vm.provider "virtualbox" do |vbox|
    vbox.gui = false
  end
  
  config.vm.define "server" do |server|
    server.vm.box = "generic/ubuntu1804"
  end

  config.vm.define "mac-client" do |mac|
    mac.vm.box = "ramsey/macos-catalina"
    mac.vm.provision "brew", type: "shell",
      keep_color: true,
      privileged: false,
      inline: <<-SCRIPT
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew install python python@3.8 tox
        brew cask install vscode firefox google-chrome chromedriver
        brew install geckodriver
      SCRIPT
  end

  config.vm.define "windows-client" do |win|
    win.vm.box = "peru/windows-10-enterprise-x64-eval"
    win.vm.boot_timeout = 1800
    win.vm.provision "choco", type: "shell",
      keep_color: true,
      privileged: true,
      inline: <<-SCRIPT
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco install --confirm --accept-license --no-progresss python python2 python3 git git-lfs
        choco install --confirm --accept-license --no-progresss google-chrome firefox microsoft-edge selenium-all-drivers
        choco install --confirm --accept-license --no-progresss vscode vscode-edge-debug fluent-terminal
      SCRIPT
  end
end