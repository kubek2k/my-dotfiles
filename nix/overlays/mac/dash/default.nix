{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip rec {
  name = "Dash";
  version = "4.5.3";
  sourceRoot = "Dash.app";
  src = fetchurl {
    url = https://kapeli.com/downloads/v4/Dash.zip;
    sha256 = "1dkrzh4l5an0z7qv25irmagssaymscjzzgdn1jha11sqhhna9lh1";
  };
  description = "Dash is an API Documentation Browser and Code Snippet Manager";
  homepage = https://kapeli.com/dash;
}
