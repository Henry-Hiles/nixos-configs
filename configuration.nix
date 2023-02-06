# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  boot.loader.grub = {
  	enable = true;
  	device = "/dev/vda";
  	useOSProber = true;
  };
  
  networking = {
    hostName = "quadraticgizmo";
    networkmanager.enable = true;
  };
  
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
	logind.extraConfig = ''
	  # Suspend when power button is pressed
	  HandlePowerKey=suspend
	 '';

  	xserver = {
  		enable = true;
  		layout = "us";
  		xkbVariant = "";
  		displayManager.gdm.enable = true;
  		desktopManager.gnome.enable = true;
  	};

  	pipewire = {
  	    enable = true;
  	    alsa.enable = true;
  	    alsa.support32Bit = true;
  	    pulse.enable = true;
  	    # If you want to use JACK applications, uncomment this
  	    jack.enable = true;
  	
  	    # use the example session manager (no others are packaged yet so this is enabled by default,
  	    # no need to redefine it in your config for now)
  	    #media-session.enable = true;
  	  };
  };

  sound.enable = true;
  security.rtkit.enable = true;

  hardware = {
  	pulseaudio.enable = false;
  	opengl.driSupport32Bit = true;
  };

  users.users.quadradical = {
    isNormalUser = true;
    description = "QuadRadical";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix = {
  	package = pkgs.nixUnstable;
  	extraOptions = ''
  	  experimental-features = nix-command flakes
  	'';
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
	variables = {
		EDITOR = "micro";
		VISUAL = "micro";
	};
  
  	systemPackages = with pkgs; [
	  micro
  	  wget
 	];
  };

  system.stateVersion = "22.11";
}
