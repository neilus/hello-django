Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vbox|
    vbox.gui = false
  end

  config.vm.provision "blackbox-tests",
    type: "file",
    source: "BlackBox.robot",
    destination: "BlackBox.robot",
    run: "always"
  config.vm.provision "toxfile",
    type: "file",
    source: "tox.ini",
    destination: "tox.ini",
    run: "always"


  config.vm.define "server" do |server|
    server.vm.box = "generic/ubuntu1804"
    server.vm.synced_folder ".", "/vagrant", disabled: false
    server.vm.network "private_network", type: "dhcp" # ip: "192.168.137.10"
    # server.vm.network "public_network", type: "dhcp"
    server.vm.provision "setup_python", type: "shell",
      keep_color: true,
      privileged: true,
      inline: <<-SCRIPT
        sudo apt-get update -qq
        sudo apt-get install -yq python python-pip
        sudo pip install -U tox
        # cd /vagrant/ && tox --devenv /vagrant/.venv -e py27-django18
        # source /vagrant/.venv/bin/activate
        # python /vagrant/manage.py runserver
      SCRIPT
  end

  config.vm.define "mac-client", autostart: false do |mac|
    mac.vm.box = "ramsey/macos-catalina"
    mac.vm.synced_folder ".", "/vagrant", disabled: true #, type: "smb"
    mac.vm.network "private_network", type: "dhcp" # ip: "192.168.137.20"
    # mac.vm.network "public_network", type: "dhcp"
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
    # win.vm.synced_folder ".", "/vagrant", type: "smb"
    win.vm.network "private_network", type: "dhcp" #ip: "192.168.137.30"
    # win.vm.network "public_network", type: "dhcp"
    win.vm.provision "choco", type: "shell",
      keep_color: true,
      privileged: true,
      inline: <<-SCRIPT
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco install --confirm --accept-license --no-progresss python2 git google-chrome firefox microsoft-edge ie9 ie10 ie11 selenium-all-drivers vscode fluent-terminal
        wuauclt /detectnow /updatenow
      SCRIPT
  end
end
