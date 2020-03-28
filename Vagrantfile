Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"
  
  config.vm.define "server" do |server|
    server.vm.box = "generic/ubuntu1804"
  end

  config.vm.define "mac-client" do |mac|
    mac.vm.box = "ramsey/macos-catalina"
  end

  config.vm.define "windows-client" do |win|
    config.vm.box = "peru/windows-10-enterprise-x64-eval"
  end
end