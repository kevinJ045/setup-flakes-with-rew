{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    # nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = (import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowInsecure = true;
          permittedInsecurePackages = [
          ];
        };
      });
      libraries = with pkgs; [
      ];
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = libraries;
        
        shellHook = ''
          echo $LD_LIBRARY_PATH
          export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
        '';
      };
    }
  );
}
