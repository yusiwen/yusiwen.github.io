{
  description = "Jekyll blog (yusiwen.github.io) dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];
    in {
      devShells = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ruby = pkgs.ruby_3_2;
        in {
          default = pkgs.mkShell {
            packages = [
              # Ruby interpreter (bundler ships as a bundled gem)
              ruby

              # Native-extension build deps (nokogiri, ffi, eventmachine, racc)
              pkgs.libxml2
              pkgs.libxslt
              pkgs.libffi
              pkgs.pkg-config
              pkgs.stdenv.cc

              pkgs.git
            ];

            shellHook = ''
              # Keep gems inside the project, not in the system gem dir
              export BUNDLE_PATH="vendor/bundle"
              export BUNDLE_SILENCE_ROOT_CHECK=1

              echo "─────────────────────────────────────────────"
              echo " Jekyll dev environment (Ruby $(ruby --version))"
              echo ""
              echo "   bundle install            # install gems (first run)"
              echo "   bundle exec jekyll serve  # start dev server :4000"
              echo "─────────────────────────────────────────────"
            '';
          };
        }
      );
    };
}
