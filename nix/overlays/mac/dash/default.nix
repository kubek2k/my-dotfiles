{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip rec {
  name = "Dash";
  version = "4.5.3";
  sourceRoot = "Dash.app";
  src = fetchurl {
    url = https://kapeli.com/downloads/v4/Dash.zip;
    sha256 = "1dizd4mmmr3vrqa5x4pdbyy0g00d3d5y45dfrh95zcj5cscypdg2";
  };
  description = "Dash is an API Documentation Browser and Code Snippet Manager";
  homepage = https://kapeli.com/dash;
}
