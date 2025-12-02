{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # プライマリユーザーを設定（あなたのユーザー名）
      system.primaryUser = "ya";  # または "cavin" - 実際のユーザー名を確認
      
      environment.systemPackages = with pkgs; [
        # エディタ・開発ツール
        vim
        neovim
        
        # バージョン管理
        git
        git-lfs
        
        # システムツール
        tree
        tmux
        wget
        fastfetch
        ranger
        htop
        
        # プログラミング言語・ランタイム
        go
        nodejs
        python313
	jdk17
        
        # コンテナ・仮想化
        qemu
        kubectl
        
        # インフラ管理
        ansible
        cloudflared
        
        # その他ユーティリティ
        jq
        hugo
        
        # Rust開発
        rust-analyzer
        
	# その他
	openldap
	perl
	tree
	gotop
      ];

      # GUIアプリやNixに無いものはHomebrewで管理
      homebrew = {
        enable = true;
        
        brews = [
        ];
        
        casks = [
          "docker"
          "visual-studio-code"
          "font-hack-nerd-font"
        ];
      };

      nix.enable = false;
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."cavin" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
