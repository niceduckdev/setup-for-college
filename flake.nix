{
	description = "tool that makes it easier to manage semesters and courses";
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

	outputs = { self, nixpkgs }: {
		defaultPackage.x86_64-linux = self.packages.x86_64-linux.setup-for-college;

    	packages.x86_64-linux.setup-for-college =
			let
        		pkgs = nixpkgs.legacyPackages.x86_64-linux;
        		name = "setup-for-college";

        		scriptContent = builtins.readFile (self + "/setup-for-college.sh");
        		script = pkgs.writeShellScriptBin name scriptContent;
        		buildInputs = with pkgs; [ ];
			in pkgs.symlinkJoin {
        		name = name;
        		paths = [ script ] ++ buildInputs;
        		buildInputs = [ pkgs.makeWrapper ];
        		postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
      		};
	};
}
