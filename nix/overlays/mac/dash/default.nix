{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip rec {
  name = "Dash";
  version = "4.5.3";
  sourceRoot = "Dash.app";
  src = fetchurl {
    url = https://kapeli.com/downloads/v4/Dash.zip;
    sha256 = "0zvc119n30ya7xja4f2ksgqcdf8c4xjzszr8w0zgm8w65nfsi8y1";
  };
  description = "Dash is an API Documentation Browser and Code Snippet Manager";
  homepage = https://kapeli.com/dash;
}
