{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip rec {
  name = "Dash";
  version = "4.5.3";
  sourceRoot = "Dash.app";
  src = fetchurl {
    url = https://kapeli.com/downloads/v4/Dash.zip;
    sha256 = "0n429q4b8g7fmpx50zkamq19hfd1629jgj055429iw0818891sdg";
  };
  description = "Dash is an API Documentation Browser and Code Snippet Manager";
  homepage = https://kapeli.com/dash;
}
