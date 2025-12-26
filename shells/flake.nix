{
  description = "Development shells for pentesting and tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Common shell hook
      shellHook = name: ''
        echo "🔧 Entering ${name} environment"
        echo "   Run 'exit' to leave"
      '';

      # =======================================================================
      # TOOL BUNDLES
      # =======================================================================

      webTools = with pkgs; [
        burpsuite
        sqlmap
        ffuf
        gobuster
        feroxbuster
        nikto
        wpscan
        testssl
        subfinder
        rustscan
      ];

      internalTools = with pkgs; [
        python312Packages.impacket
        netexec
        responder
        hydra
        wireshark
        proxychains-ng
        sshpass
        openvpn
      ];

      reversingTools = with pkgs; [
        ghidra
        radare2
        binwalk
      ];

      crackingTools = with pkgs; [
        john
        hashcat
      ];

      exploitTools = with pkgs; [
        metasploit
        exploitdb
      ];

      cloudTools = with pkgs; [
        awscli2
        azure-cli
        google-cloud-sdk
      ];

      remoteTools = with pkgs; [
        remmina
        freerdp
        rustdesk
      ];

      mediaTools = with pkgs; [
        obs-studio
        obsidian
      ];

      # All pentesting tools combined
      ctfTools = webTools ++ internalTools ++ reversingTools ++ crackingTools ++ exploitTools;

    in {
      devShells.${system} = {
        # Web Application Testing
        web = pkgs.mkShell {
          name = "web";
          packages = webTools;
          shellHook = shellHook "web (burpsuite, sqlmap, ffuf, gobuster, etc.)";
        };

        # Internal Network / Active Directory
        internal = pkgs.mkShell {
          name = "internal";
          packages = internalTools;
          shellHook = shellHook "internal (impacket, netexec, responder, hydra, etc.)";
        };

        # Reverse Engineering / Binary Analysis
        reversing = pkgs.mkShell {
          name = "reversing";
          packages = reversingTools;
          shellHook = shellHook "reversing (ghidra, radare2, binwalk)";
        };

        # Password Cracking
        cracking = pkgs.mkShell {
          name = "cracking";
          packages = crackingTools;
          shellHook = shellHook "cracking (john, hashcat)";
        };

        # Exploitation Frameworks
        exploit = pkgs.mkShell {
          name = "exploit";
          packages = exploitTools;
          shellHook = shellHook "exploit (metasploit, exploitdb)";
        };

        # Cloud Security
        cloud = pkgs.mkShell {
          name = "cloud";
          packages = cloudTools;
          shellHook = shellHook "cloud (aws, azure, gcloud)";
        };

        # Remote Desktop
        remote = pkgs.mkShell {
          name = "remote";
          packages = remoteTools;
          shellHook = shellHook "remote (remmina, freerdp, rustdesk)";
        };

        # Media / Content Creation
        media = pkgs.mkShell {
          name = "media";
          packages = mediaTools;
          shellHook = shellHook "media (obs-studio, obsidian)";
        };

        # CTF - All pentesting tools
        ctf = pkgs.mkShell {
          name = "ctf";
          packages = ctfTools;
          shellHook = shellHook "ctf (all pentesting tools)";
        };

        # Default shell (same as ctf)
        default = pkgs.mkShell {
          name = "default";
          packages = ctfTools;
          shellHook = shellHook "default (all pentesting tools)";
        };
      };
    };
}
