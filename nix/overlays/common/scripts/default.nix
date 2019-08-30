self: super:
super.runCommand "myscripts" {} ''
  mkdir -p $out/bin
  cp ${./bin}/* $out/bin/
''
