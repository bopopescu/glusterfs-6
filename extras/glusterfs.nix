#
# executed via extras/build-nix.sh
#
{ src }:
{
  packageOverrides = pkgs: {
    glusterfsDev = (pkgs.callPackage ./glusterfs-pkg.nix {}).overrideDerivation (oldAttrs: {

      inherit src;

      name = "glusterfs-8dev";
      patches = [];

      #
      # install tests into the derivation so we can
      # run prove tests against the resulting output
      #
      postInstall = pkgs.lib.strings.concatStrings [oldAttrs.postInstall ''
        cp -a tests/ $out
      ''];

      #
      # nix won't rewrite /bin/bash if we do not have executable bit
      # on our test files.
      #
      postPatch = pkgs.lib.strings.concatStrings [oldAttrs.postPatch ''
        find tests/ -iname \*.t | xargs -I {} chmod +x {}
      ''];
    });
  };
}

